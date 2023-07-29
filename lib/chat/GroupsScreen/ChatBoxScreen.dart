import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../Authentication/login/model/Users.dart';
import '../../core/SharedPreferenceInfo.dart';
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
  GroupMessageTile groupMessageTile ;

  ChatBoxScreen({
    required this.groupName,
    required this.groupId,
    required this.UserName,
    required this.groupImage,
    required this.groupModel,
    required this.groupMessageTile,
  });

  @override
  State<ChatBoxScreen> createState() => _ChatBoxScreenState();
}

class _ChatBoxScreenState extends State<ChatBoxScreen> {


  bool _isUploading = false;
  bool _showEmoji = false;

  @override
  CollectionReference groupCollection =
  FirebaseFirestore.instance.collection('groups');
  List<GroupMessageTile> groupMessage = [];



  String admin = "";
  Stream <QuerySnapshot>? chats;
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
      print("nameeeeeeeeeeeeee22222222222 ${logedInUser}");
    });
  }

  @override
  void initState() {
    gettingUserData();
    _messageController.addListener(() {
      setState(() {});
    });
  }

  // @override
  // void dispose()
  // {
  // _messageController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Row(
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
                SizedBox(height: 4,),
                Text("  ${widget.groupName}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,)),
                // SizedBox(
                //   height: 4,
                // ),
                // Text("  ${widget.groupId}",
                //     style: TextStyle(
                //         color: Colors.green,
                //         fontSize: 14,
                //         fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GroupInfo(
                              groupName: '${widget.groupName}',
                              groupId: '${widget.groupId}',
                              adminName: admin,
                            )));
              },
              icon: Icon(Icons.info, color: Colors.grey,))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _listMessagesWidget()),
          if(_isUploading)
            Align(alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 5),
                  child: CircularProgressIndicator(strokeWidth: 2,),
                )),
          // _chatInput(),
          _inputMessagesTextField(),
          // emoji select window
          if(_showEmoji)

            SizedBox(
              height: mq.height * .35,
              child: EmojiPicker(
                textEditingController: _messageController,
                config: Config(
                  columns: 8,
                  emojiSizeMax: 32 * (Platform.isIOS ? 1.3 : 1.0),
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
          final data=snapshot.data?.docs;
          groupMessage=data?.map((e) => GroupMessageTile.fromJson(e.data())).toList().cast<GroupMessageTile>()?? [];
          print("we are here");
          return snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                GroupMessageTile groupMessageTile = groupMessage[index];
                print("${snapshot.data.docs[index]['message']}");
                if (groupMessageTile.sender == logedInUser) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Flexible(
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: mq.width * .04,),
                                    // blue tick icon for read messages
                                    if(widget.groupMessageTile.read.isNotEmpty)
                                      Icon(Icons.done_all_rounded, color: Colors.blue, size: 20,),
                                    SizedBox(width: mq.width * .01,),
                                    // msg send time
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(
                                      widget.groupMessageTile.type == Type.image ? mq.width * .03 : mq
                                          .width * .02),
                                  margin: EdgeInsets.symmetric(
                                      vertical: mq.height * .02, horizontal: mq.width * .03),
                                  decoration: BoxDecoration(color: Color.fromARGB(255, 130, 223, 135),
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                          bottomLeft: Radius.circular(30))),
                                  child: Column(
                                      children: [

                                        Text(
                                          logedInUser.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              letterSpacing: -0.5),
                                        ),

                                        // to send images
                                        widget.groupMessageTile.type == Type.text
                                            ? Text("${snapshot.data.docs[index]['message']}",
                                          style: GoogleFonts.balooBhai2(fontSize: 20),) :
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: CircularProgressIndicator(strokeWidth: 2,),
                                                ),
                                            imageUrl: widget.groupMessageTile.message,
                                            errorWidget: (context, url, error) => Icon(Icons.image),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: mq.width * .029991, top: 10, left: .09),
                                          child:
                                          // formatted send time
                                          //(message['timestamp'] == null) ? null : (message['timestamp'] as Timestamp).toDate(),
                                          Text( "${readTimestamp("${snapshot.data.docs[index]['time']==null?null: (snapshot.data.docs[index]['time']as Timestamp ).toDate()}")}",style: TextStyle(color: Colors.black54),),
                                        ),


                                        ]),
                                ),

                              ]
                          )

                        ],
                      ),
                    ),
                  );
                }else {

                  return  Align(
                      alignment: Alignment.centerLeft,
                      child:Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  widget.groupMessageTile.type == Type.image ? mq.width * .03 : mq
                                      .width * .02),
                              margin: EdgeInsets.symmetric(
                                  vertical: mq.height * .01, horizontal: mq.width * .03),
                              decoration: BoxDecoration(color: Colors.grey[400],
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              child: Column(
                                  children: [
                                    Text(
                                      "${snapshot.data.docs[index]['sender']}".toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: -0.5),
                                    ),
                                    widget.groupMessageTile.type == Type.text
                                        ? Text("${snapshot.data.docs[index]['message']}",
                                      style: GoogleFonts.balooBhai2(fontSize: 20),) :
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CircularProgressIndicator(strokeWidth: 2,),
                                            ),
                                        imageUrl: widget.groupMessageTile.message,
                                        errorWidget: (context, url, error) => Icon(Icons.image),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: mq.width * .029991, top: 10, left: .07),
                                      child:
                                      Text( "${readTimestamp("${snapshot.data.docs[index]['time']==null?null: (snapshot.data.docs[index]['time']as Timestamp ).toDate()}")}",style: TextStyle(color: Colors.black54),),

                                    )
                                  ]),
                            ),
                          ])
                  );
                }
              }
          ): Container(
              child: Center(child: Text(
                "Say Hii!!👋", style: GoogleFonts.balooBhai2(fontSize: 30),),
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
                  IconButton(onPressed: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _showEmoji = !_showEmoji;
                    });
                  },
                      icon:
                      Icon(Icons.emoji_emotions_outlined, color: Colors.purple,
                        size: 23,)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: _messageController,
                        onTap: () {
                          if (_showEmoji)
                            setState(() {
                              _showEmoji = !_showEmoji;
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
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera);
                        if (image != null) {
                          print("image path: ${image.path}");
                          setState(() => _isUploading = true,);

                          Apis.sendGroupImage(
                              widget.groupModel, File(image.path));
                          setState(() => _isUploading = false,);
                        }
                      },
                      icon: Icon(Icons.camera_alt_rounded, color: Colors.purple,
                        size: 30,)),
                  SizedBox(width: mq.width * .01,),
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final List<XFile> images = await picker
                            .pickMultiImage();
                        for (var i in images) {
                          setState(() => _isUploading = true,);
                          await Apis.sendGroupImage(widget.groupModel, File(i
                              .path));
                          setState(() => _isUploading = false,);
                        }
                      },
                      icon: Icon(Icons.image, color: Colors.purple, size: 30,)),
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

                  setMessage( );

                },
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),)),
        ],
      ),
    );
  }

  setMessage() {
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = ({
        'message': _messageController.text,
        'sender': logedInUser,
        'senderId': logedInUserId,
        'time': widget.groupMessageTile.time,

        // 'type': type,
      });
      setMessages("${widget.groupId}", chatMessageMap);
      _messageController.clear();
      print("groupppppppppppppppppppppp${widget.groupName}");
      print("grouppppppppppppppppppppppIddddddddddd${_messageController.text}");
    }
  }
  setMessages(String groupId, Map<String, dynamic> chatMessageData) {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData["message"],
      "recentMessageSender": chatMessageData["sender"],
      "recentMessageSender": chatMessageData["senderId"],
      "recentMessageTime": chatMessageData["time"],
      // "recentMessageType": chatMessageData["type"].toString(),
    });
    SetOptions(merge: true);
  }



  String readTimestamp(String timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat( 'K:m'' ''a');
    var date = DateTime.parse(timestamp);
    var diff = date.difference(now);
    var time = '';

      if (diff.inDays == 1) {
        time = (diff.inDays/360).toString() + 'DAY AGO';
      } else {
        time = (diff.inDays/360).toString() + 'DAYS AGO';
      }
    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    }

    return time;
  }
}



class  GroupMessageTile {

  GroupMessageTile(
      {required this.message,
        required this.time,
        required this.type,
        required this.sender,
        required this.senderId,
        required this.read
      });
  late final String message;
  late final String sender;
  late final String senderId;
  late final String read;
  late final  DateTime time;
  late final Type type;
  GroupMessageTile.fromJson(Map<String, dynamic> json){
    message = json['message'].toString();
    sender = json['sender'].toString();
    senderId = json['senderId'].toString();
    read = json['read'].toString();
    type = json['type'].toString()==Type.image.name?Type.image:Type.text;
    time = json['time'].toDate();
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['sender'] = sender;
    _data['senderId'] = senderId;
    _data['read'] = read;
    _data['type'] = type.name;
    _data['time'] = time;
    return _data;
  }
}
enum Type{text,image}