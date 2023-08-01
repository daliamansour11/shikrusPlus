
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanger/chat/chats/model/GroupModel.dart';
import 'package:taskmanger/chat/chats/model/UsersModel.dart';
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
  List<UserData> member=[];
  CreateNewGroup({
    required this.member
  });
  @override
  State<CreateNewGroup> createState() => _CreateNewGroupState();
}
String membersName='';
List<String> member=[];
var userName ='';
CollectionReference groupCollection =   FirebaseFirestore.instance.collection("groups");
CollectionReference userCollection =   FirebaseFirestore.instance.collection('users ');
class _CreateNewGroupState extends State<CreateNewGroup> {
  TextEditingController _groupnameController = TextEditingController();
  String? Auth = FirebaseAuth.instance.currentUser?.uid;
  String groupName = '';



  int id = 0;
  String userName = '';
  GroupModel? groupModel;
  @override
  void dispose() {
    _groupnameController.dispose();
  }
  bool _isUploading=false;

  UserData user = UserData();
  String type= 'admin';
  @override
  void initState() {
    gettingUserData();
  }

  gettingUserData() async {
    await SharedPreferencesInfo.getUserNameFromSF().then((value) {
      setState(() {
        userName = value ??"";
        print("nameeeeeeeeeeeeee22222222222 ${userName}");
      });
    });
    await SharedPreferencesInfo.getUserIdFromSF().then((value){
      setState(() {
        id = value??0;
        print("nameeeeeeeeeeeeeeIddddd  ${id}");
      });
    });
  }
  List<String> memberName = [];
  String? uid='';

  Future createGroup(String userName, String id, String groupName,String members) async {

    memberName.add(userName);

    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": membersName,
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(memberName),
      "groupId": groupDocumentReference.id,
    });
    DocumentReference userDocumentRefence = userCollection.doc(uid);
    // removed await here check once
    return await userDocumentRefence.update({
      "usersGroups": FieldValue.arrayUnion(
          ["${groupDocumentReference.id}_$groupName"])
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF005373),
        title: Text("CreateNewGroup"),
      ),
      body: CustomScrollView(
          slivers:[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(children: [
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
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>AllUsersScreen( groupName: '',)));
                    },


                    child: Text("Add Members",style: TextStyle(fontSize: 20,fontWeight:
                    FontWeight.w400),),
                  ),
                ),
                Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            height: 330,
                            decoration:   BoxDecoration(borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200],),
                            child:
                            ListView.separated(
                              shrinkWrap: true,
                              itemCount: widget.member.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 5),
                              itemBuilder: (context, index) {
                                print("lennnnnnnnnnnnn${widget.member}");
                                var tpyeeee= widget.member[index].type;
                                memberName.add(widget.member[index].name??"");
                                //for(int i =0; i<=widget.member.length;i++) {
                                membersName = widget.member[index].name ?? '';
                                print("mmmmmmmmmmmmmmmmmmbers  ${membersName}");

                                // memberId.add(widget.member[index].id ?? 0);
                                // List<int> Ids = memberId;
                                //}
                                return ListTile(leading:
                                CachedNetworkImage(
                                  width: mq.height * .050,
                                  height: mq.height * .050,
                                  imageUrl: "${widget.member[index].image}",
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                        child: Icon(CupertinoIcons.person),
                                      ),
                                ),
                                  title: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${widget.member[index].name}"),
                                      ),
                                    ],
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("${widget.member[index].type}"),
                                  ),
                                );
                              },
                            ),
                          )),

                      Container(
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

                            UserData user = UserData();
                            if(_groupnameController.text==""||memberName.isEmpty ||_groupnameController.text.isEmpty){
                              Fluttertoast.showToast(
                                msg: "Please Enter Group Data", // message
                                toastLength: Toast.LENGTH_LONG, // length
                                gravity: ToastGravity.CENTER, // location
                                timeInSecForIosWeb: 4,
                              );
                              // Navigator.of(context).pop();
                            }else{
                              groupName = _groupnameController.text;


                              setState(() {
                                _isUploading = true;
                              });

                              print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ${userName}");
                              createGroup("${userName}",
                                  id.toString(), groupName,
                                  membersName
                              )
                                  .whenComplete(() {
                                setState(() {
                                  print("uiddddddddddddddd${FirebaseAuth
                                      .instance
                                      .currentUser?.uid}");
                                  _isUploading = false;
                                });


                                Navigator.of(context).pop();

                                Navigator.pushReplacement(

                                    context, MaterialPageRoute(builder: (
                                    _) =>
                                    HomeChat()));
                                // showSnakbar(context, Colors.green, "Group created successfully.😍");
                              });

                            }},

                          child: Text("Create New group",
                              style: TextStyle(color: Colors.white, fontSize: 16)),
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
                                  color: Colors.grey),
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
              ],
              ),
            ),
          ]),);

  }


}
