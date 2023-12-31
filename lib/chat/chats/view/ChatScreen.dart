import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/SharedPreferenceInfo.dart';
import '../../../main.dart';
import '../../view/MessageCard.dart';
import '../api/apis.dart';
import '../model/UsersModel.dart';
import '../model/chat_msg.dart';

class ChatScreen extends StatefulWidget {
  final String UserName;
  final String userId;
  final String userImage;
  final UserData user;

  const ChatScreen({
    super.key,
    required this.user,
    required this.userId,
    required this.userImage,
    required this.UserName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Messages> _list = [];

  // _ private var
  final _textcontroller = TextEditingController();
  String type = "";

  gettingUserType() async {
    await SharedPreferencesInfo.getUserTypeFromSF().then((value) {
      setState(() {
        type = value!;
        print("nameeeeeeeeeeeeee$type");
      });
    });
  }

  @override
  void initState() {
    gettingUserType();
    gettingUserData();
  } // emoji var           image uploading

  bool _showEmoji = false, _isUploading = false;
  int idt = 0;

  gettingUserData() async {
    await SharedPreferencesInfo.getUserIdFromSF().then((value) {
      setState(() {
        idt = value!;
        print("nameeeeeeeeeeeeee$idt");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.red));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        // backbutton -> emoji win off
        child: WillPopScope(
          onWillPop: () {
            if (_showEmoji) {
              setState(() {
                _showEmoji = !_showEmoji;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            backgroundColor: Colors.teal[50],
            appBar: AppBar(
              backgroundColor: Colors.grey[300],
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[400],
                    radius: 21.0,
                    backgroundImage: NetworkImage('${widget.userImage}'),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Column(
                    children: [
                      Text("  ${widget.UserName}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                type == "admin"
                    ? Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream:
                              //Apis.getAllMessages(widget.user),
                              FirebaseFirestore.instance
                                  .collection(
                                      'chat/${Apis.getsendConversionId(widget.user.id.toString(), idt ?? 0)}/messages')
                                  .orderBy('send', descending: true)
                                  .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            switch (snapshot.connectionState) {
                              // if data is loading
                              case ConnectionState.waiting:
                              case ConnectionState.none:
                                return SizedBox();

                              case ConnectionState.active:
                              case ConnectionState.done:
                                final data = snapshot.data?.docs;

                                _list = data
                                        ?.map(
                                            (e) => Messages.fromJson(e.data()))
                                        .toList()
                                        .cast<Messages>() ??
                                    [];

                                if (_list.isNotEmpty) {
                                  return ListView.builder(
                                      // last msg to show 1st
                                      reverse: true,
                                      physics: BouncingScrollPhysics(),
                                      padding:
                                          EdgeInsets.only(top: mq.height * .01),
                                      itemCount: _list.length,
                                      itemBuilder: (context, index) {
                                        return MessageCard(
                                          messages: _list[index],
                                          userId: widget.userId,
                                        );
                                        // return Text("msgs:${_list[index]}");
                                      });
                                } else {
                                  return Center(
                                    child: Text(
                                      "Say Hii!!👋",
                                      style:
                                          GoogleFonts.balooBhai2(fontSize: 30),
                                    ),
                                  );
                                }
                            }
                          },
                        ),
                      )
                    : Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream:
                              //Apis.getAllMessages(widget.user),
                              FirebaseFirestore.instance
                                  .collection(
                                  'chat/${Apis.getsenduserConversionId(idt ?? 0, widget.user.id.toString())}/messages')
                                  .orderBy('send', descending: true)
                                  .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            switch (snapshot.connectionState) {
                              // if data is loading
                              case ConnectionState.waiting:
                              case ConnectionState.none:
                                return SizedBox();

                              case ConnectionState.active:
                              case ConnectionState.done:
                                final data = snapshot.data?.docs;

                                _list = data
                                        ?.map(
                                            (e) => Messages.fromJson(e.data()))
                                        .toList()
                                        .cast<Messages>() ??
                                    [];

                                if (_list.isNotEmpty) {
                                  return ListView.builder(
                                      // last msg to show 1st
                                      reverse: true,
                                      physics: BouncingScrollPhysics(),
                                      padding:
                                          EdgeInsets.only(top: mq.height * .01),
                                      itemCount: _list.length,
                                      itemBuilder: (context, index) {
                                        return MessageCard(
                                          messages: _list[index],
                                          userId: widget.userId,
                                        );
                                        // return Text("msgs:${_list[index]}");
                                      });
                                } else {
                                  return Center(
                                    child: Text(
                                      "Say Hii!!👋",
                                      style:
                                          GoogleFonts.balooBhai2(fontSize: 30),
                                    ),
                                  );
                                }
                            }
                          },
                        ),
                      ),
                if (_isUploading)
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )),
                _chatInput(),

                // emoji select window
                if (_showEmoji)
                  SizedBox(
                    height: mq.height * .35,
                    child: EmojiPicker(
                      textEditingController: _textcontroller,
                      config: Config(
                        columns: 8,
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.3 : 1.0),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

// input keyboard + send button
  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .02),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  // emoji func
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _showEmoji = !_showEmoji;
                        });
                      },
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: Colors.blue,
                        size: 28,
                      )),
                  Expanded(
                      child: TextField(
                    controller: _textcontroller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      if (_showEmoji)
                        setState(() {
                          _showEmoji = !_showEmoji;
                        });
                    },
                    decoration: InputDecoration(
                        hintText: 'Start Chatting....',
                        hintStyle: TextStyle(fontSize: 18),
                        border: InputBorder.none),
                  )),
                  //  select gallery multiple images
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final List<XFile> images =
                            await picker.pickMultiImage();
                        for (var i in images) {
                          setState(
                            () => _isUploading = true,
                          );
                          if (_list.isEmpty) {
                            // on 1st msg add the user
                            print("${_list.isEmpty}emptyy");
                            Apis.sendusersMessage(widget.user);
                            await Apis.sendChatImage(widget.user, File(i.path));
                          } else {
                            await Apis.sendChatImage(widget.user, File(i.path));
                          }
                          setState(
                            () => _isUploading = false,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.image,
                        color: Colors.blue,
                        size: 30,
                      )),

                  //  camera button
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          print("image path: ${image.path}");
                          setState(
                            () => _isUploading = true,
                          );
                          if (_list.isEmpty) {
                            // on 1st msg add the user
                            print("${_list.isEmpty}emptyy");
                            Apis.sendusersMessage(widget.user);
                            Apis.sendChatImage(widget.user, File(image.path));
                          } else {
                            Apis.sendChatImage(widget.user, File(image.path));
                          }
                          setState(
                            () => _isUploading = false,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.blue,
                        size: 30,
                      )),
                  SizedBox(
                    width: mq.width * .01,
                  )
                ],
              ),
            ),
          ),
          // click to send msgs
          MaterialButton(
            onPressed: () async {
              if (_textcontroller.text.isNotEmpty) {
                if (_list.isEmpty) {
                  // on 1st msg add the user
                  print("${_list.isEmpty}emptyy");
                  Apis.sendusersMessage(widget.user);
                  type == "admin"
                      ? Apis.sendAdminMessage(
                          widget.user, _textcontroller.text, Type.text)
                      : Apis.sendMessage(
                          widget.user, _textcontroller.text, Type.text);
                } else {
                  print("${_list.isEmpty} ${widget.user.id}emptyy");
                  type == "admin"
                      ? Apis.sendAdminMessage(
                          widget.user, _textcontroller.text, Type.text)
                      : Apis.sendMessage(
                          widget.user, _textcontroller.text, Type.text);
                }
              }
              _textcontroller.text = '';
              _textcontroller.clear();
            },
            shape: CircleBorder(),
            minWidth: 0,
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
            color: Colors.redAccent,
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }

// chat screen  custom appbar
// Widget _appBar(){
//   return InkWell(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(builder: (_)=>ViewProfile(user: widget.user)));
//       },
//       child: StreamBuilder(stream: Apis.getUserInfo(widget.user),builder: (context, snapshot) {
//         final data=snapshot.data?.docs;
//         final list=data?.map((e) => ChatUser.fromJson(e.data())).toList()?? [];
//         return Row(
//           children: [
//             IconButton(onPressed: (){
//               Navigator.pop(context);
//             },
//                 icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
//             ClipRRect(
//               // profile pic
//               borderRadius: BorderRadius.circular(mq.height *.3),
//               child: CachedNetworkImage(
//                 width: mq.height * .045,
//                 height: mq.height *.045,
//                 imageUrl:list.isNotEmpty?list[0].image:widget.user.image,
//                 errorWidget: (context, url, error) => CircleAvatar(child: Icon(CupertinoIcons.person),),
//               ),
//             ),
//             SizedBox(width: mq.width * .03,),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // user name
//                 Text(list.isNotEmpty?list[0].name:widget.user.name,style: GoogleFonts.balooBhai2(
//                     color: Colors.white,fontSize: 20,fontWeight: FontWeight.w300),),
//                 // SizedBox(height: .005,),
//                 // last seen status
//                 Text(list.isNotEmpty?list[0].isOnline?'Online':
//                 MyDate.getLastActiveTime(context: context, lastActive: list[0].lastActive):
//                 MyDate.getLastActiveTime(context: context, lastActive: widget.user.lastActive),
//                   style: GoogleFonts.balooBhai2(color: Colors.white,fontSize: 13),)
//
//               ],)
//           ],
//         );
//       },)
//   );
// }
}
