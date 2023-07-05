
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanger/chat/chats/api/apis.dart';

import '../../Authentication/login/model/Users.dart';
import '../../core/Dialogs.dart';
import '../../main.dart';
import '../chats/ChatBoxScreen.dart';
import '../chats/api/MyDate.dart';
import '../chats/model/chat_msg.dart';
import '../helper_function.dart';
import '../services/database_service.dart';
import 'CreateNewGroup.dart';

class GroupListScreen extends StatefulWidget{
  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  String? AuthEmail = FirebaseAuth.instance.currentUser?.email;
  CollectionReference groupCollection =   FirebaseFirestore.instance.collection('groups ');

  String groupName = '';

  String userName = '';

  String email = '';

  Stream? groups;

  String getId(String s){
    return s.substring(0,s.indexOf('_'));
  }

  String getName(String s){
    return s.substring(0,s.indexOf('_')+1);
  }

  @override
  void initState() {
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunction.getUserNameFromSF().then((value){
      setState(() {
        userName = value!;
      });
    });
    await HelperFunction.getUserEmailFromSF().then((val) => {
      setState((){
        email = val!;
      })
    });
    //getting the list of snapshot in our stream
    await DataBaseService(uid: FirebaseAuth.instance.currentUser?.uid??"").getUserGroups().then((snapshot){
      setState(() {
        groups = snapshot;
      });
    });
  }

  Users_model users_model = Users_model("", "email", "phone", "password", "", true, "image", "status",[]);

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: AuthEmail=="mohmed112@gmail.com"?
        Visibility(
          visible: true,
          child: FloatingActionButton(
            onPressed: () {

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateNewGroup()));

              },
            child: Icon(Icons.people_alt_outlined),
           backgroundColor: Color(0xFF005373),
          ),
        ):  Visibility(
          visible: false,
          child: FloatingActionButton(
            onPressed: () {

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateNewGroup()));

            },
            child: Icon(Icons.people_alt_outlined),
            backgroundColor: Color(0xFF005373),
          ),
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
                                    DataBaseService(uid: FirebaseAuth.instance.currentUser?.uid) . getUserGroups();

                                    final data = docs[i].data();
                                    return ListTile(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder:
                                                  (context) =>
                                                  ChatBoxScreen(groupName: '${data['groupName']}'
                                                    , groupId: '${data['groupId']}', UserName: '${users_model.name}'
                                                    , groupImage: '${data['groupImage']}', groupModel: GroupModel(groupName: '${data['groupName']}',
                                                        groupId: '${data['groupId']}',
                                                        groupImage: ''),),
                                                    // friendUid: '', friendName: '',
                                                  )
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
class MessageCard extends StatefulWidget {
  final Messages messages;
  const MessageCard({super.key, required this.messages});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    bool isMe=Apis.user==widget.messages.fromId;
    return InkWell(
      onLongPress: () {
        _showbottomsheet(isMe);
      },
      child: isMe?_greenMessage():_redMessage(),
    );
  }
  // sender msgs
  Widget _redMessage(){

    // update the read msg status when sender sends a msg
    if(widget.messages.read.isEmpty){
      Apis.updateMessageReadstatus(widget.messages);
      // print('msg updated');
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.messages.type==Type.image?mq.width* .03: mq.width * .05),
            margin: EdgeInsets.symmetric(vertical: mq.height * .02,horizontal: mq.width *.03),
            decoration: BoxDecoration(color: Colors.teal[200],
                border: Border.all(color: Colors.redAccent),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),bottomRight: Radius.circular(30))),
            child:
            widget.messages.type==Type.text
                ?Text(widget.messages.msg,style: GoogleFonts.balooBhai2(fontSize: 20),):
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                placeholder: (context,url)=> Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2,),
                ),
                imageUrl: widget.messages.msg,
                errorWidget: (context, url, error) => Icon(Icons.image),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: mq.width * .04),

          child: Text(
            // formatted send time
            MyDate.getFormattedtime(context: context, time: widget.messages.send),
            style: GoogleFonts.balooBhai2(fontSize: 15,color: Colors.black54),),
        )
      ],
    );
  }
  // user/my msgs
  Widget _greenMessage(){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: mq.width * .04,),

            // blue tick icon for read messages
            if(widget.messages.read.isNotEmpty)
              Icon(Icons.done_all_rounded,color: Colors.blue,size: 20,),
            SizedBox(width: mq.width * .01,),

            // msg send time
            Text(
              MyDate.getFormattedtime(context: context, time: widget.messages.send),
              style: GoogleFonts.balooBhai2(fontSize: 15,color: Colors.black54),),
          ],
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.messages.type==Type.image?mq.width* .03:mq.width * .05),margin: EdgeInsets.symmetric(vertical: mq.height * .02,horizontal: mq.width *.03),
            decoration: BoxDecoration(color: Color.fromARGB(255, 130, 223, 135),
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomLeft: Radius.circular(30))),
            child:
            // to send images
            widget.messages.type==Type.text
                ?Text(widget.messages.msg,style: GoogleFonts.balooBhai2(fontSize: 20),):
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                placeholder: (context,url)=> Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2,),
                ),
                imageUrl: widget.messages.msg,
                errorWidget: (context, url, error) => Icon(Icons.image),
              ),
            ),
          ),
        ),

      ],
    );
  }
  void _showbottomsheet(bool isMe){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        builder: (_){
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(vertical: mq.height *.015,horizontal: mq.width *.4),
                decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(8)),
              ),

              // copy text
              widget.messages.type==Type.text?
              _OptionItem(icon: Icon(Icons.copy,color: Colors.blue,size: 26,),
                  name: 'Copy Text',
                  onTap: () async {
                    await Clipboard.setData(
                        ClipboardData(text: widget.messages.msg))
                        .then((value) {
                      //for hiding bottom sheet
                      Navigator.pop(context);
                      Dialogs.showSnack(context, 'Text Copied!');
                    });
                  })
              // save image
                  :_OptionItem(icon: Icon(Icons.download_rounded,color: Colors.blue,size: 26,),
                  name: 'Save Image',
                  onTap: () async {
                    try {
                      log('Image Url: ${widget.messages.msg}');
                      await GallerySaver.saveImage(widget.messages.msg,
                          albumName: 'You Chat')
                          .then((success) {
                        //for hiding bottom sheet
                        Navigator.pop(context);
                        if (success != null && success) {
                          Dialogs.showSnack(
                              context, 'Image Successfully Saved!');
                        }
                      });
                    } catch (e) {
                      log('ErrorWhileSavingImg: $e');
                    }

                  }),
              if(isMe)
                Divider(
                  color: Colors.black54,endIndent: mq.width *.04,indent: mq.width *.04,
                ),


              //edit msg
              if(widget.messages.type==Type.text && isMe)
                _OptionItem(icon: Icon(Icons.edit,color: Colors.blue,size: 26,),
                    name: 'Edit Message',
                    onTap: (){
                      Navigator.pop(context);
                      _showMessageUpdateDialog();
                    }),

              // del msg
              if (isMe)
                _OptionItem(icon: Icon(Icons.delete,color: Colors.red,size: 26,),
                    name: 'Delete Message',
                    onTap: () async {
                      // UploadTask uploadTask = await storageReference.putFile(mFileImage);
                      if(mounted)
                        await Apis.deleteMessage(widget.messages).then((value) {
                          Navigator.pop(context);
                        });
                    }),
              Divider(
                color: Colors.black54,endIndent: mq.width *.04,indent: mq.width *.04,
              ),

              // sent time
              _OptionItem(icon: Icon(Icons.remove_red_eye,color: Colors.blue,size: 26,),
                  name: 'Send At:  ${MyDate.getMessageTime(context: context, time: widget.messages.send)}',
                  onTap: (){}),


              // read time
              _OptionItem(icon: Icon(Icons.remove_red_eye,color: Colors.green,size: 26,),
                  name: widget.messages.read.isEmpty?
                  "Read at:  Not seen yet":
                  'Read at: ${MyDate.getMessageTime(context: context, time: widget.messages.read)}',
                  onTap: (){}),

            ],

          );
        });
  }

  // showing bottom sheet for msg details
  void _showMessageUpdateDialog() {
    String updatedMsg = widget.messages.msg;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: const EdgeInsets.only(
              left: 24, right: 24, top: 20, bottom: 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          //title
          title: Row(
            children: const [
              Icon(
                Icons.message,
                color: Colors.blue,
                size: 28,
              ),
              Text(' Update Message')
            ],
          ),

          //content
          content: TextFormField(
            initialValue: updatedMsg,
            maxLines: null,
            onChanged: (value) => updatedMsg = value,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          //actions
          actions: [
            //cancel button
            MaterialButton(
                onPressed: () {
                  //hide alert dialog
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                )),

            //update button
            MaterialButton(
                onPressed: () {
                  //hide alert dialog
                  Navigator.pop(context);
                  Apis.updatemessage(widget.messages, updatedMsg);
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ))
          ],
        ));
  }


}

class _OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;

  const _OptionItem({required this.icon, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Padding(
        padding:  EdgeInsets.only(left:mq.width *.05,top: mq.height *.015,bottom: mq.height *.015),
        child: Row(
          children: [
            icon,
            Flexible(child: Text('    $name',style: TextStyle(fontSize: 16,letterSpacing: .5,color: Colors.black87),)),
          ],
        ),
      ),
    );
  }
}

