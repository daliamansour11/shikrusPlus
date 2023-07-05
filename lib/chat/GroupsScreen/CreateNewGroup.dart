
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanger/chat/chats/HomeChat.dart';
import 'package:taskmanger/home/view/homescreen.dart';


import '../../Authentication/login/model/Users.dart';
import '../../core/SharedPreferenceInfo.dart';
import '../../core/TextFiledContainerWidget.dart';
import '../helper_function.dart';
import '../services/database_service.dart';
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
  bool _isLoading=false;
  String userName = "";
  int id = 0;

  Users_model users_model = Users_model("", "email", "phone", "password", "", true, "image", "status",[]);
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
      body: Container(
        margin: EdgeInsets.all(10),
        height: 400,
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            height: 69.0,
            width: 69.0,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(62.0),
            ),
            child: Center(child: Image.asset("lib/images/chat.jpg")),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Add group Image",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.purple),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            flex: 1,
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
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1.50,endIndent: 100,indent: 100,
          ),
          Container(
            margin: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 10),
            height: 63,
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
                    _isLoading = true;
                  });
                  DataBaseService(uid: FirebaseAuth.instance.currentUser?.uid)
                      .createGroup(userName,
                      id.toString() , groupName)
                      .whenComplete(() {
                    setState(() {
                      print("uiddddddddddddddd${FirebaseAuth.instance.currentUser?.uid}");
                      _isLoading = false;
                    });
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => HomeChat()));
                    // showSnakbar(context, Colors.green, "Group created successfully.😍");
                  });
                }
                   },
              child: Text("Create New group",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
          Row(
            children: [
              Text(
                ' By Clicking Creat New Group , '
                    'you agree to the ',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[400]),
              ),
              Text(
                'Privact Policy',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF005373)),
              )
            ],
          )
        ]),
      ),
    );

  }


}
