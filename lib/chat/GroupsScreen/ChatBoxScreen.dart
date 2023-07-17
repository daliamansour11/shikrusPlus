import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../Authentication/login/model/Users.dart';
import '../../main.dart';
import '../GroupsScreen/GroupInfo.dart';
import '../chats/api/MyDate.dart';
import '../chats/api/apis.dart';
import '../chats/model/GroupModel.dart';
import '../chats/model/chat_msg.dart';
import '../services/database_service.dart';

TextEditingController _messageController = TextEditingController();

class ChatBoxScreen extends StatefulWidget {
  final String groupName;
  final String UserName;
  final String groupId;
  final String groupImage;
  GroupModel groupModel;
  ChatBoxScreen({
    required this.groupName,
    required this.groupId,
    required this.UserName,
    required this.groupImage,
    required this.groupModel,
  });

  @override
  State<ChatBoxScreen> createState() => _ChatBoxScreenState();
}

class _ChatBoxScreenState extends State<ChatBoxScreen> {

  bool  _isUploading = false;
  bool  _showEmoji = false;
  @override
  CollectionReference groupCollection =
  FirebaseFirestore.instance.collection('groups');

  // void dispose() {
  //   _messageController.dispose();
  // }

  String admin = "";
  Stream <QuerySnapshot>? chats;
  Users_model users_model = Users_model("", "email", "phone", "password", "", true, "image", "status",[]);

  @override
  void initState() {
    _messageController.addListener(() {
      setState(() {});
    });
    getChatandAdmin();
  }

  getChatandAdmin() async {
    var chatResult = await DataBaseService().getChats(widget.groupId);
    if (chatResult != null) {
      setState(() {
        chats = chatResult;
      });
    }

    var adminResult = await DataBaseService().getGroupAdmin(widget.groupId);
    if (adminResult != null) {
      setState(() {
        admin = adminResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Expanded(
          flex: 1,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[400],
                radius: 21.0,
                backgroundImage: NetworkImage('${widget.groupImage}'),
              ),
              SizedBox(
                width: 3,
              ),
              Column(
                children: [
                  Text("  ${widget.groupName}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,)),
                  SizedBox(
                    height: 4,
                  ),
                  Text("  ${widget.groupId}",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupInfo(
                          groupName: '${widget.groupName}',
                          groupId: '${widget.groupId}',
                          adminName: admin,
                        )));
              },
              icon: Icon(Icons.info,color: Colors.grey,))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _listMessagesWidget()),
          if(_isUploading)
            Align(alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 5),
                  child: CircularProgressIndicator(strokeWidth: 2,),
                )),
          // _chatInput(),
          _inputMessagesTextField(),
          // emoji select window
          if(_showEmoji)

            SizedBox(
              height: mq.height *.35,
              child: EmojiPicker(
                textEditingController: _messageController,
                config: Config(
                  columns: 8,
                  emojiSizeMax: 32 * (Platform.isIOS?1.3:1.0),
                ),
              ),
            )

        ],
      ),
    );
  }

  _listMessagesWidget() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("groups")
            .doc("${widget.groupId}")
            .collection("messages")
            .orderBy('time')
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          print("we are here");
          return snapshot.hasData
              ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              print("${snapshot.data.docs[index]['message']}");
              return MessageTile(
                  message: snapshot.data.docs[index]['message'],
                  sender: snapshot.data.docs[index]['sender'],
                  sendByMe: widget.UserName ==
                      snapshot.data.docs[index]['sender'], time:snapshot.data.docs[index]['time'].toDate(), senderImage: '' ,);
            },
          )
              : Container(
          child: Center(child: Text("Say Hii!!👋",style: GoogleFonts.balooBhai2(fontSize: 30),),

          ));
          return CircularProgressIndicator();
        });
  }

  _inputMessagesTextField() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(80),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]),
              child: Row(
                children: [
                  SizedBox(
                    width: 4,
                  ),
                  IconButton(onPressed: (){
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _showEmoji=!_showEmoji;
                    });
                  },
                      icon:
                      Icon(Icons.emoji_emotions_outlined,color: Colors.purple,size: 23,)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: _messageController,
                        onTap: (){
                          if(_showEmoji)
                            setState(() {
                              _showEmoji=!_showEmoji;
                            });
                        },
                        decoration: InputDecoration(
                          hintText: "type message here",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker=ImagePicker();
                        final XFile? image = await picker.pickImage(source: ImageSource.camera);
                        if(image!=null){
                          print("image path: ${image.path}");
                          setState(() => _isUploading=true,);

                          Apis.sendGroupImage(widget.groupModel,File(image.path));
                          setState(() => _isUploading=false,);

                        }
                      },
                      icon: Icon(Icons.camera_alt_rounded,color: Colors.purple,size: 30,)),
                  SizedBox(width: mq.width * .01,),
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker=ImagePicker();
                        final List<XFile> images = await picker.pickMultiImage();
                        for(var i in images){
                          setState(() => _isUploading=true,);
                          await Apis.sendGroupImage(widget.groupModel,File(i.path));
                          setState(() => _isUploading=false,);
                        }
                      },
                      icon: Icon(Icons.image,color: Colors.purple,size: 30,)),
                  SizedBox(
                    width: 2,
                  ),
                ],
              ),
            ),
          ),



          SizedBox(
            width: 10,
          ),
          Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(45),
              ),
              child: InkWell(
                onTap: () {
                  setMessage();
                },
                child: Icon(
                  _messageController.text.isEmpty ? Icons.mic : Icons.send,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
  setMessage() {
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = ({
        'message': _messageController.text,
        'sender': widget.UserName,
        'time': DateTime.now(),
      });
      setMessages("${widget.groupId}", chatMessageMap);
      _messageController.clear();
    }
  }

  setMessages(String groupId, Map<String, dynamic> chatMessageData) {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData["message"],
      "recentMessageSender": chatMessageData["sender"],
      "recentMessageTime": chatMessageData["time"].toString(),
    });
    SetOptions(merge: true);
  }
}



class MessageTile extends StatefulWidget {
  final String message;

  final String sender;
  final String senderImage;
  final DateTime time;


  final bool sendByMe;

  MessageTile(
      {required this.message, required this.sender, required this.sendByMe, required this.time, required this.senderImage});

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  Messages? _messages;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: widget.sendByMe ? 0 : 24,


          right: widget.sendByMe ? 24 : 0),
      alignment: widget.sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sendByMe
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          color: widget.sendByMe
              ? Colors.purple[400]
              : Colors.blueGrey,
          borderRadius: widget.sendByMe
              ? const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )
              : const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child:




            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.sender.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5),
              ),
              SizedBox(
                height: 5,
              ),
              Text(" ${ widget.message}"
                ,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              // Spacer(),
              Text(MyDate.getLastMsgTime(context: context, time:widget.time.millisecondsSinceEpoch.toString()),style: TextStyle(color: Colors.black54),),
]  )



      ),
    );
  }
}
