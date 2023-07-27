import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class GroupInfo extends StatefulWidget{
//   final String? groupName;
//   final String? UserName;
//   final String? groupId;
//   final String? groupImage;
//   String? admin;
//   GroupInfo( {
//     required this.groupName,
//     required this.groupId,
//     required this.UserName,
//     required this.groupImage,
//     required this.admin,
//
//   });
//
//   @override
//   State<GroupInfo> createState() => _GroupInfoState();
// }
// class _GroupInfoState extends State<GroupInfo> {
//   CollectionReference groupCollection =   FirebaseFirestore.instance.collection('groups');
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(
//         centerTitle: true,
//         title:Text("Group Info",style: TextStyle(fontSize: 20,color: Colors.white),),
//       backgroundColor: Colors.purple,
//        leading: IconButton(onPressed: (){
//          Navigator.pop(context);
//        }, icon:Icon(Icons.arrow_back_ios,color: Colors.white,)),
//         actions: [IconButton(onPressed: (){
//         // Navigator.pop(context);
//     }, icon:Icon(Icons.exit_to_app ,color: Colors.white,))
//         ],
//       ),
//       body: Container(
//           padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//         child: Column(
//           children: [
//              Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Theme.of(context).primaryColor.withOpacity(0.2),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     CircleAvatar(
//
//                       radius: 30,
//
//                       backgroundColor: Colors.grey[300],
//
//                       child: Text("${widget.groupName!}"
//                        //   .substring(0,1).toUpperCase()}"
//                              ,style:TextStyle(fontWeight: FontWeight.w700),
//                     ),),
//                     SizedBox(height: 15,),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Group:${widget.groupName}',style:
//                     TextStyle(fontWeight: FontWeight.w600),),
//                         SizedBox(height: 15,),
//                         Text('Admin:${widget.admin!}'),
//                 // ,style: TextStyle(fontWeight: FontWeight.w600),),
//                         SizedBox(height: 15,),
//                       ],
//                     )
//
//                   ],
//                 ),
//               ),
//
//       SizedBox(height: 10,),
//       memberList(),
//           ],
//         ),
//       ),
//
//
//
//     );
//   }
// String getName(String s){
//      return s.substring(s.indexOf("_" +"${1}"));
// }
//   @override
//   void initState() {
//     getGroupMembeers("${widget.groupId}");
//     // getGroupAdmin("${widget.groupId}");
//   }
//
//
//   Future getGroupAdmin(String groupId) async {
//     DocumentReference documentReference = FirebaseFirestore.instance
//         .collection('groups').doc(groupId);
//     DocumentSnapshot d = await documentReference.get();
//
//     return d['admin'];
//   }
//     getGroupMembeers(String geoupId){
//     return groupCollection.doc(geoupId).snapshots();
//   }
//
//   Widget memberList() {
//     return  StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('groups').snapshots(),
//           builder: (context,AsyncSnapshot snapshot){
//
//       if (snapshot.hasError)
//       return Text('Error = ${snapshot.error}');
//       final docs = snapshot.data?.docs;
//       if(snapshot.hasData){
//                // if(docs!= null){
//                //    if(snapshot.data['member'].length != 0)
//                    return  Expanded(
//                      child: Container(
//                          child: ListView.builder(
//                              itemCount: docs!.length,
//                                shrinkWrap: true,
//                                physics: BouncingScrollPhysics(),
//                                itemBuilder: (context,i){
//                                  print("last member");
//                                   final member = docs[i].data();
//                              return Container(
//                                padding:EdgeInsets.symmetric(horizontal: 5,vertical: 10) ,
//                                child: ListTile(
//                                  leading: CircleAvatar(
//                                    radius: 30,
//                                    backgroundColor: Colors.grey[200],
//                                    backgroundImage:AssetImage("lib/images/chat2.jpg"),
//                                  ),
//                                  title: Text("${getName("${snapshot.data['member'][i]}")}") ,
//                                  subtitle:Text("${widget.groupId}")
//                              ));
//                            }),
//
//                        ),
//                    );
//
//                  }
//               // }else{
//               //   return Center(
//               //     child: Text("NO member"),
//               //   );
//               //    }
//            return CircularProgressIndicator();
//
//            }
//
//       );
//
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/database_service.dart';
import 'GroupListScreen.dart';

class GroupInfo extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String adminName;
  const GroupInfo({Key? key, required this.groupName, required this.groupId, required this.adminName}) : super(key: key);

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  AuthService authService = AuthService();
  Stream? member;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMember();
  }

  getMember() async {
    DataBaseService(uid: FirebaseAuth.instance.currentUser?.uid??"").getGroupMembers(widget.groupId).then((val){
      setState(() {
        member = val;
      });
    });
  }

  String getName(String r){
    return r.substring(r.indexOf("_")+1);
  }
  String getId(String res){
    return res.substring(0,res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Group Info"),
        actions: [
          IconButton(onPressed: (){
            showDialog(barrierDismissible: false, context: context, builder: (context){
              return AlertDialog(
                title: const Text("Exit"),
                content: const Text("Are you sure you wanna exit from group ☹️"),
                actions: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  },
                    icon: const Icon(Icons.cancel, color: Colors.red,),
                  ),
                  IconButton(onPressed: () async {
                    DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid).toggleGroupJoin(widget.groupId, getName(widget.adminName) , widget.groupName,).whenComplete((){
                      // nextScreenReplace(context, const HomePage());
                    });
                  },
                    icon: const Icon(Icons.exit_to_app, color: Colors.green,),
                  ),
                ],
              );
            });
          }, icon: const Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(widget.groupName.substring(0,1).toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.white,),
                      )
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Group: ${widget.groupName}",style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                        const SizedBox(height: 5,),
                        Text("Admin: ${getName(widget.adminName)}",style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            memberList(),
          ],
        ),
      ),
    );
  }
  memberList(){
    return Column(
      children: [
        SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.only(right: 200.0),
          child: Text("Group Members",style: TextStyle(fontSize: 20),),
        ),
        SizedBox(height: 5,),
        StreamBuilder(
          stream: member,
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              if(snapshot.data['members'] != null){
                if(snapshot.data['members'].length != 0){
                  return ListView.builder(itemCount: snapshot.data['members'].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(getName(snapshot.data['members'][index]).substring(0,1).toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                          ),
                          title: Text(getName(snapshot.data['members'][index])),
                          // subtitle: Text(getId(snapshot.data['members'][index])),
                        ),
                      );
                    },
                  );
                }
                else{
                  return const Center(child: Text("NO member"),);
                }
              }
              else{
                return const Center(child: Text("NO member"),);
              }
            }
            else{
              return Center(
                child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
              );
            }
          },
        ),
      ],
    );
  }
}