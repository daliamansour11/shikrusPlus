
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanger/chat/chats/model/GroupModel.dart';
import '../../Authentication/login/model/Users.dart';
import '../../core/SharedPreferenceInfo.dart';
import '../../core/TextFiledContainerWidget.dart';
import '../../main.dart';
import '../chats/api/apis.dart';
import '../chats/view/HomeChat.dart';
import '../helper_function.dart';
import '../services/database_service.dart';
import 'AllUserWidget.dart';
import 'ChatGroupData.dart';
import 'GroupListScreen.dart';

class CreateNewGroup extends StatefulWidget {
  @override
  State<CreateNewGroup> createState() => _CreateNewGroupState();
}

CollectionReference groupCollection =   FirebaseFirestore.instance.collection("groups");
CollectionReference userCollection =   FirebaseFirestore.instance.collection('users ');
class _CreateNewGroupState extends State<CreateNewGroup> {
  TextEditingController _groupnameController = TextEditingController();
  String? Auth = FirebaseAuth.instance.currentUser?.uid;
  String groupName = '';
  bool _isUploading=false;
  bool _isempty= false;

  String userName = "";
  int id = 0;
      GroupModel? groupModel;
  // Users_model users_model = Users_model("", "email", "phone", "password", "", true, "image", "status",[]);
  @override
  void dispose() {
    _groupnameController.dispose();
  }

  @override
  void initState() {
    gettingUserData();
  }

  gettingUserData() async {
    await SharedPreferencesInfo.getUserNameFromSF().then((value){
      setState(() {
        userName = value!;
        print("nameeeeeeeeeeeeee$userName");
      });
    });await SharedPreferencesInfo.getUserIdFromSF().then((value){
      setState(() {
        id = value!;
        print("nameeeeeeeeeeeeee$userName");
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF005373),
        title: Text("CreateNewGroup"),
      ),
      body: Column(children: [
        SizedBox(
          height: 5,
        ),
          Expanded(

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 85,vertical: 0),
              child: Container(

                  child:   CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/personn.jpg"),
                    child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Color(0xFF775FAF),
                              child: InkWell(
                                  onTap: ()async{

                                      final ImagePicker picker=ImagePicker();
                                      final XFile? image = await picker.pickImage(source: ImageSource.camera);
                                      if(image!=null){
                                        print("image path: ${image.path}");
                                        setState(() => _isUploading=true,);

                                        Apis.sendGroupImage(groupModel!,File(image.path));
                                        setState(() => _isUploading=false,);

                                      }

                                  },
                                  child: Icon(Icons.camera_alt_outlined)),
                            ),
                          ),
                        ]
                    ),
                  )

              ),
            ),
          ),
          SizedBox(
            height: 5.0,),
        Padding(
            padding: const EdgeInsets.only(right: 220.0),
            child: Text("groupName",style: TextStyle(fontSize: 20,fontWeight:
            FontWeight.w400),textAlign: TextAlign.start,),
          ),

         Expanded(

           child: Padding(
                padding: const EdgeInsets.only(left: 5.0,right: 5.0,),
                child: TextFieldContainerWidget(

                    // focusNode: focusNode,
                    controller: _groupnameController,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.person,
                    hintText: "groupName..",
                    borderRadius: 0.0,
                    //  color: Colors.white,
                    iconClickEvent: () {
                       setState(() {});
                    },
                  ),
              ),
         ),


          SizedBox(
            height: 1,
          ),
           Padding(
                padding: const EdgeInsets.only(right: 205.0,),
                  child: Text("Add Memmbers",style: TextStyle(fontSize: 20,fontWeight:
                  FontWeight.w400),),
                ),
        Expanded(
          flex: 4,
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                // height: 330,
                    decoration:   BoxDecoration(borderRadius: BorderRadius.circular(20),

                      color: Colors.grey,),
                
                child:_isempty==_isempty?Center(child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllUsersWidget()));
                    },
                    child: Text("Add Group Members")),):

                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                      CachedNetworkImage(
                        width: mq.height * .050,
                        height: mq.height * .050,
                        // imageUrl: groupModel!.groupImage??"",
                        errorWidget: (context, url, error) =>
                            CircleAvatar(
                              child: Icon(CupertinoIcons.person),
                            ),
                        imageUrl: '',
                      ),
                      title: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(""),
                          ),
                        ],
                      ),
                      subtitle: Text(""),
                    );
                  },
                ),
              )),
        ),


          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(160),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 2,
                      spreadRadius: 1,
                      offset: Offset(0, 0.50))
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF005373),
                  padding: EdgeInsets.all(20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: ()async {
                  groupName= _groupnameController.text;
                  if(groupName != ""){
                    setState(() {
                      _isUploading = true;
                    });
                    DataBaseService(uid: FirebaseAuth.instance.currentUser?.uid)
                        .createGroup(userName,
                        id.toString() , groupName)
                        .whenComplete(() {
                      setState(() {
                        print("uiddddddddddddddd${FirebaseAuth.instance.currentUser?.uid}");
                        _isUploading = false;
                      });
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => HomeChat()));
                      // showSnakbar(context, Colors.green, "Group created successfully.😍");
                    });
                  }
                     },
                child: Text("Create New group",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0,left: 5.0),
                child: Text(
                  ' By Clicking Creat New Group , '
                      'you agree to the ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[400]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0,left: 5.0),
                child: Text(
                  'Privact Policy',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF005373)),
                ),
              )
            ],
          )
        ]),

    );

  }


}
