import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanger/chat/chats/model/Messages.dart';
import 'package:taskmanger/core/SharedPreferenceInfo.dart';
import '../../main.dart';
import '../chats/model/GroupModel.dart';
import '../chats/model/UsersModel.dart';
import 'ChatBoxScreen.dart';
import '../chats/api/MyDate.dart';
import '../services/database_service.dart';
import 'CreateNewGroup.dart';

class GroupListScreen extends ConsumerStatefulWidget {
  final DateTime time;

  GroupListScreen({
    required this.time,
  });

  @override
  ConsumerState<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends ConsumerState<GroupListScreen> {
  CollectionReference groupCollection =
  FirebaseFirestore.instance.collection('groups ');

  String getId(String s) {
    return s.substring(0, s.indexOf('_'));
  }
  GroupModel? ge ;

  String? userLogedInType="admin" ;
  String? type = ""  ;
  String logedInUser = '';
  int logedInUserId = 0;
  gettingUserData() async {
    await SharedPreferencesInfo.getUserNameFromSF().then((value) {
      setState(() {
        logedInUser = value ?? "";
      });
      print("nameeeeeeeeeeeeee22222222222 ${logedInUser}");
    });await SharedPreferencesInfo.getUserIdFromSF().then((senderId) {
      setState(() {
        logedInUserId = senderId ?? 0;
      });
      print("nameeeeeeeeeeeeee22222222222 ${logedInUserId}");
    });await SharedPreferencesInfo.getUserTypeFromSF().then((usertype) {
      setState(() {
        type = usertype ?? "0";
      });
      print("nameeeeeeeeeeeeee22222222222${type}");
    });
  }
  UserData? user1;
  GroupMessageTile? message;
  @override
  void initState() {
    gettingUserData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        floatingActionButton:type==userLogedInType?
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateNewGroup(member: [],)));
          },
          child: Icon(Icons.people_alt_outlined),
          backgroundColor: Color(0xFF005373),

        ):  Visibility(
          visible: false,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateNewGroup(member: [],)));
            },
            child: Icon(Icons.people_alt_outlined),
            backgroundColor: Color(0xFF005373),

          ),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 3,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('groups')
                        // .where('member',arrayContains: '${FirebaseAuth.instance.currentUser?.uid}')
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.hasError)
                            return Text('Error = ${snapshot.error}');
                          final docs = snapshot.data?.docs;
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: docs!.length,
                              itemBuilder: (_, i) {
                                DataBaseService(
                                    uid: FirebaseAuth.instance.currentUser?.uid)
                                    .getUserGroups();

                                final data = docs[i].data();
                                return Card(

                                    margin: EdgeInsets.symmetric(horizontal: mq.width *.03,vertical: 5),
                                    color: Colors.grey[300],
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    elevation: 2,
                                    child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ChatBoxScreen(
                                                  groupName: '${data['groupName']}',
                                                  groupId: '${data['groupId']}',
                                                  UserName: '${data['sender']}',
                                                  groupImage: '${data['groupImage']}',
                                                  groupModel: GroupModel(
                                                    groupName: '${data['groupName']}',
                                                    groupId: '${data['groupId']}',
                                                    groupImage: '',
                                                    about: '', sender: '${data['sender']}', senderId:'${data['senderId']}', receiverId: '',
                                                  ), groupMessageTile: GroupMessageTile(message: '',
                                                    time:DateTime.now(), type: Type.text, sender: '', read: '', senderId: "logedInUserId")
                                                  ,
                                                ),
                                                // friendUid: '', friendName: '',
                                              ));
                                        },
                                        // user profile pic
                                        leading: InkWell(
                                          onTap: () {
                                            // showDialog(context: context, builder: (_)=>DialogProfile(user: widget.user));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(mq.height * .3),
                                            child: CachedNetworkImage(
                                              width: mq.height * .050,
                                              height: mq.height * .050,
                                              // imageUrl: groupModel!.groupImage??"",
                                              errorWidget: (context, url, error) =>
                                                  CircleAvatar(
                                                    child: Icon(CupertinoIcons.person),
                                                  ),
                                              imageUrl: '',
                                            ),
                                          ),
                                        ),
                                        // user name show
                                        title: Text("${data['groupName']}",
                                            style: GoogleFonts.balooBhai2(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        // last msg show
                                        subtitle: Text(
                                            "${message != null ? message!.type == Type.image ?
                                            'Photo' : message!.message :data["recentMessage"]}",
                                            maxLines: 1
                                        ),

                                        trailing:
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: mq.width * .029991, top: 10, left: .07),
                                          child:
                                         Text( "${MyDate.readTimestamp("${data['recentMessageTime']== null?DateTime.now(): (data['recentMessageTime']as Timestamp ).toDate()}")}",style: TextStyle(color: Colors.black54),),
                                        )
                                    ));
                              },
                              // separatorBuilder: (BuildContext context, int index) {
                              //   return Divider(thickness: 0.5,);
                              //}
                            );
                          }
                          //
                          return Center(child: CircularProgressIndicator());
                        },
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}