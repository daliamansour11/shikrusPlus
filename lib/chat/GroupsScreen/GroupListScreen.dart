import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Authentication/login/model/Users.dart';
import '../chats/model/group_model.dart';
import '../chats/view/ChatBoxScreen.dart';
import 'CreateNewGroup.dart';

class GroupListScreen extends StatefulWidget{
  // String? Auth = FirebaseAuth.instance.currentUser?.email;
  CollectionReference groupCollection =   FirebaseFirestore.instance.collection('groups ');
  String groupName = '';

  String getId(String s){
    return s.substring(0,s.indexOf('_'));
  }
  String getName(String s){
    return s.substring(0,s.indexOf('_')+1);
  }
  getUserGroups()async{
    return     FirebaseFirestore.instance.collection('users ').where('uId',isEqualTo: FirebaseAuth.instance.currentUser?.uid) ;
  }


  @override
  void initState() {
    getUserGroups();
  }
  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  Users_model users_model = Users_model("", "email", "phone", "password", "", true, "image", "status",[]);

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewGroup()));
          },
          child: Icon(Icons.people_alt_outlined),
         backgroundColor: Color(0xFF005373),
        ),
          body:  Container(
            child: Column(
              children: [
           SizedBox(height: 10,),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Center(
                        child:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('groups')
                              // .where('member',arrayContains: '${FirebaseAuth.instance.currentUser?.uid}')
                               .snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasError)
                              return Text('Error = ${snapshot.error}');
                            final docs = snapshot.data?.docs;
                            if (snapshot.hasData ) {
                              return ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: docs!.length,
                                  itemBuilder: (_, i) {
                                    final data = docs[i].data();
                                    return ListTile(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder:
                                                  (context) =>
                                                  ChatBoxScreen(groupModel: GroupModel(groupName: '${data['groupName']}'
                                                    , groupId: '${data['groupId']}', UserName: '${users_model.name}'
                                                    , groupImage: '${data['groupImage']}', pushToken: '', email: '',),
                                                    // friendUid: '', friendName: '',
                                                  )),
                                              );
                                        },
                                        leading: CircleAvatar(

                                          backgroundColor: Colors.grey[200],
                                          // backgroundImage: NetworkImage('${data['groupImage']}'),
                                          radius: 30,
                                        ),
                                        title: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("${data['groupName']}"),
                                            ),
                                          ],
                                        ),
                                        subtitle:
                                            Text("${data['groupId']}"),
                                        );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return Divider(thickness: 0.5,);
                                  });
                            }
                            // }

                            return Center(child: CircularProgressIndicator());
                          },
                        )


                    ),
                  ),
                ),
              ],
            ),
          )
      );

  }
}

class GroupTile extends StatefulWidget{
  final String userName;
  final String groupId;
  final String groupName;

  GroupTile({

 required this.userName, required this.groupId, required this.groupName});
  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
return Container(
  color: Colors.grey,

);

  }
}