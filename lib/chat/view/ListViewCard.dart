

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../chats/model/UsersModel.dart';
import '../chats/view/ChatScreen.dart';
import '../chats/api/MyDate.dart';
import '../chats/api/apis.dart';
import '../chats/model/chat_msg.dart';
class ListViewCard extends StatefulWidget {
  final UserData user;
  const ListViewCard({super.key, required this.user});

  @override
  State<ListViewCard> createState() => _ListViewCardState();
}

class _ListViewCardState extends State<ListViewCard> {
  // last msg info
  Messages? _messages;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: mq.width *.03,vertical: 5),
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=> ChatScreen( userId: '${widget.user.id}', userImage: '${widget.user.image}', UserName: '${widget.user.name}', user: widget.user,)));
          },
          // profile pic + list of chat users
          child: StreamBuilder<QuerySnapshot>(
              stream: Apis.getLastMessage(widget.user),
              builder: (context,AsyncSnapshot  snapshot){
                // final data=snapshot.data?.docs;
                final list=snapshot.data?.docs.map((e) => Messages.fromJson(e.data())).toList().cast<String>()?? [];
                // if(list.isNotEmpty){
                //   _messages=list[0];
                // }
                return  ListTile(
                  // user profile pic
                    leading: InkWell(
                      onTap: (){
                        // showDialog(context: context, builder: (_)=>DialogProfile(user: widget.user));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(mq.height *.3),
                        child: CachedNetworkImage(
                          width: mq.height * .050,
                          height: mq.height *.050,
                          imageUrl: widget.user.image??"",
                          errorWidget: (context, url, error) => CircleAvatar(child: Icon(CupertinoIcons.person),),
                        ),
                      ),
                    ),
                    // user name show
                    title: Text(widget.user.name??"",style: GoogleFonts.balooBhai2(fontWeight: FontWeight.bold,fontSize: 20)),
                    // last msg show
                    // subtitle: Text(_messages!=null?_messages!.type==Type.image?'Photo':
                    // _messages!.msg:
                    // widget.user.about,maxLines: 1,),

                  //  trailing: Text("10:10 pm",style: TextStyle(color: Colors.black54),),
                    // last msg time
                    trailing: _messages==null?
                    // show green dot for unread msg of sender
                    null: _messages!.read.isEmpty && _messages!.fromId!=Apis.user!?
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(10)),
                    ):
                    // show send time for read msg
                    Text(MyDate.readTimestamp(_messages!.send)
                      ,style: TextStyle(color: Colors.black54),)
                );
              }

          ),
        )
    );
  }
}