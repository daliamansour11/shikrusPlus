import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:readmore/readmore.dart';
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
  GroupMessageTile groupMessageTile;

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
  CollectionReference groupCollection = FirebaseFirestore.instance.collection('groups');
  List<GroupMessageTile> groupMessage = [];

  String admin = "";
  Stream<QuerySnapshot>? chats;
  String logedInUser = '';
  int logedInUserId = 0;

  gettingUserData() async {
    await SharedPreferencesInfo.getUserNameFromSF().then((value) {
      setState(() {
        logedInUser = value ?? "";
      });
      print("nameeeeeeeeeeeeee22222222222 ${logedInUser}");
    });
    await SharedPreferencesInfo.getUserIdFromSF().then((senderId) {
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
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
    child: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: Row(
            children: [
              ClipRRect(
                borderRadius:
                BorderRadius.circular(
                    mq.height * .3),
                child: CachedNetworkImage(
                  width: mq.height * .051,
                  height: mq.height * .051,
                  // imageUrl: groupModel!.groupImage??"",
                  errorWidget: (context, url,
                      error) =>
                      CircleAvatar(
                        radius: 21.0,
                        backgroundColor: Colors
                            .white,
                        child: Icon(
                          CupertinoIcons.person_3,
                          color: Colors.grey,),),
                  imageUrl: '${widget.groupImage}',
                ),
              ),            SizedBox(
                width: 3,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  Text("  ${widget.groupName}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      )),
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
                          builder: (context) => GroupInfo(
                                groupName: '${widget.groupName}',
                                groupId: '${widget.groupId}',
                                adminName: admin,
                              )));
                },
                icon: Icon(
                  Icons.info,
                  color: Colors.grey,
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(child: _listMessagesWidget()),
            if (_isUploading)
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )),
            // _chatInput(),
            _inputMessagesTextField(),
            // emoji select window
            if (_showEmoji)
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
      ),
    ));
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
          final data = snapshot.data?.docs;
          groupMessage = data
                  ?.map((e) => GroupMessageTile.fromJson(e.data()))
                  .toList()
                  .cast<GroupMessageTile>() ??
              [];
          print("we are here");
          return snapshot.hasData
              ? Container(

                child: WillPopScope(

                    onWillPop: () {
                      if (_isUploading) {
                        setState(() {
                          _isUploading = false;
                        });
                      } else {
                        Navigator.pop(context);
                      }
                      return Future.value(false);

                  },
                  child: Stack(
                    children:[ ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          GroupMessageTile groupMessageTile = groupMessage[index];
                          print("${snapshot.data.docs[index]['message']}");
                          if (groupMessageTile.sender == logedInUser) {
                            return Stack(
                              children:[ Align(
                                  alignment: Alignment.centerRight,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                     maxWidth: MediaQuery.of(context).size.width -45,
                                    ),
                                    child: Card(
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      color: Color(0xffdcf8c6),
                                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5.0,top: 2),
                                            child: Text(
                                              logedInUser.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[600],
                                                  letterSpacing: -0.5),
                                            ),
                                          ),
                                              // SizedBox(height:3),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 30,
                                              top: 20,
                                              bottom: 20,
                                            ),
                                            child:widget.groupMessageTile.type== Type.text?
                                            ReadMoreText(
                                              '${snapshot.data.docs[index]['message']}',
                                              trimLines: 2,
                                              preDataText: "",
                                              preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                                              style: TextStyle(color: Colors.black,fontSize: 20),
                                              colorClickableText: Colors.blue,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: '...Show more',
                                              trimExpandedText: ' show less',
                                            ):
                                            Container(
                                              width: 200,
                                            height: 200,
                                            padding: EdgeInsets.all(widget.groupMessageTile.type==Type.image?mq.width* .03:mq.width * .05),margin: EdgeInsets.symmetric(vertical: mq.height * .02,horizontal: mq.width *.03),
                                            decoration: BoxDecoration(color: Color(0xD2D4CFB2),
                                                border: Border.all(color: Colors.grey[100]!),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomLeft: Radius.circular(30))),

                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                      ),
                                                    ),
                                                imageUrl:"${snapshot.data.docs[index]['message']}",
                                                errorWidget: (context, url, error) =>
                                                    Icon(Icons.image),
                                              ),
                                            ),
                                          )),
                                          Positioned(
                                            bottom: 4,
                                            right: 2,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5.0),
                                                  child: Text(
                                                      "${readTimestamp("${snapshot.data.docs[index]['time'] == null ? null : (snapshot.data.docs[index]['time'] as Timestamp).toDate()}")}",
                                                      style: TextStyle( fontSize:13,color: Colors.black54),
                                                    ),
                                                ),

                                                // SizedBox(
                                                //   width: 5,
                                                // ),
                                                // Icon(
                                                //   Icons.done_all,
                                                //   size: 20,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ]);

                          } else {
                            return Align(
                                alignment: Alignment.topLeft,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width-45 ,
                                  ),
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    color: Color(0xD2D5D2DC),
                                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5.0,top: 2),
                                          child: Text(
                                           " ${snapshot.data.docs[index]['sender']}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                                letterSpacing: -0.5),
                                          ),
                                        ),
                                        SizedBox(height: 4,),
                                        widget.groupMessageTile.type == Type.text
                                            ?Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 30,
                                            top: 20,
                                            bottom: 20,
                                          ),
                                          child:
                                   ReadMoreText("${snapshot.data.docs[index]['message']}",
                                    trimLines: 2,
                                    preDataText: "",
                                    preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                                    style: TextStyle(color: Colors.black,fontSize: 20),
                                    colorClickableText: Colors.blue,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '...Show more',
                                    trimExpandedText: ' show less',
                                  ),

                                        )
                                            : ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 200,
                                                    height: 200,
                                                    // width: MediaQuery.of(context).size.width/2,
                                                    // height:  MediaQuery.of(context).size.height/2.5,
                                                  )
                                                ),
                                            imageUrl:"${snapshot.data.docs[index]['message']
                                                !='' ?Image.network("${snapshot.data.docs[index]['message']}")
                                                :CircularProgressIndicator()
                                            }",
                                           
                                            errorWidget: (context, url, error) =>
                                                Icon(Icons.image),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 4,
                                          right: 2,
                                          child: Row(
                                            children: [
                                             Padding(
                                               padding: const EdgeInsets.only(top: 5.0),
                                               child: Text(
                                                    "${readTimestamp("${snapshot.data.docs[index]['time'] == null ? null : (snapshot.data.docs[index]['time'] as Timestamp).toDate()}")}",
                                                    style: TextStyle(fontSize: 13,color: Colors.black54,fontWeight: FontWeight.w500),
                                                  ),
                                             ),

                                              // SizedBox(
                                              //   width: 5,
                                              // ),
                                              // Icon(
                                              //   Icons.done_all,
                                              //   size: 20,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                            );
                          }
                        }),
                  ]),
                ),
              )
              : Container(
                  child: Center(
                  child: Text(
                    "Say Hii!!👋",
                    style: GoogleFonts.balooBhai2(fontSize: 30),
                  ),
                ));
          return CircularProgressIndicator();
        });
  }

  _inputMessagesTextField() {
    GroupMessageTile groupMessageTile =GroupMessageTile(message: "", time: DateTime.now(), type: Type.image,
        sender:logedInUser , senderId: logedInUserId.toString(), read: "");
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
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _showEmoji = !_showEmoji;
                        });
                      },
                      icon: Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.purple,
                        size: 23,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: TextField(
                        //  maxLines: null,
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
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          print("image path: ${image.path}");
                          setState(
                            () => _isUploading = true,
                          );
                          await Apis. sendGroupImage(widget.groupModel ,File(image.path));

                          // Apis.sendGroupImage(
                          //     widget.groupModel, File(image.path));
                          setState(
                            () => _isUploading = false,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.purple,
                        size: 30,
                      )),
                  SizedBox(
                    width: mq.width * .01,
                  ),
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final List<XFile> images =
                            await picker.pickMultiImage();
                        for (var i in images) {
                          setState(
                            () => _isUploading = true,
                          );
                          await Apis. sendGroupImage(widget.groupModel ,File(i.path));
                          setState(
                            () => _isUploading = false,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.image,
                        color: Colors.purple,
                        size: 30,
                      )),
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
                  setMessage(_messageController.text,Type.text);
                },
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
  static FirebaseStorage storage = FirebaseStorage.instance;





   // Future<void> sendGroupImage(File file) async {
   //   final ext = file.path
   //       .split('.')
   //       .last;
   //   //String fileName = Uuid().v1();
   //
   //
   //   final ref = storage.ref().child
   //    ('groupImages/${(widget.groupId)}/${DateTime
   //      .now()
   //      .millisecondsSinceEpoch}.$ext');
   //  await ref.putFile(file, SettableMetadata(contentType:
   //  'image/$ext')).then((
   //      p0) {
   //    print('data transferred: ${p0.bytesTransferred / 1000} kb');
   //  });
/*
       final imageUrl = await ref.getDownloadURL();
     groupCollection.doc("${widget.groupId}")
         .collection("messages").doc(ext).set({
       'message':imageUrl,
       'sender': logedInUser,
       'senderId': logedInUserId,
       'time': widget.groupMessageTile.time,
       ' type': "text",
     });
            setMessage( imageUrl,Type.image );
           print("imagggggggggggggggggggggggg$imageUrl");
     setMessage(imageUrl,Type.)*/

 // }
  setMessage(String massage,Type type) {
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = ({
        'message':_messageController.text,
        'sender': logedInUser,
        'senderId': logedInUserId,
        'time': widget.groupMessageTile.time,
      // ' type': "text",
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
    var format = new DateFormat('KK:mm' ' ' 'a');
    var date = DateTime.parse(timestamp);
    var diff = date.difference(now);
    var time = '';

    if (diff.inDays == 1) {
      time = (diff.inDays / 360).toString() + 'DAY AGO';
    } else {
      time = (diff.inDays / 360).toString() + 'DAYS AGO';
    }
    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    }

    return time;
  }
}

class GroupMessageTile {
  GroupMessageTile(
      {required this.message,
      required this.time,
      required this.type,
      required this.sender,
      required this.senderId,
      required this.read});

  late final String message;
  late final String sender;
  late final String senderId;
  late final String read;
  late final DateTime time;
  late final Type type;

  GroupMessageTile.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    sender = json['sender'].toString();
    senderId = json['senderId'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
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

enum Type { text, image }

// class OwnMessageCard extends StatelessWidget {
//   final String message;
//   final String time;
//
//   const OwnMessageCard({required Key key, required this.message, required this.time}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width - 45,
//         ),
//         child: Card(
//           elevation: 1,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           color: Color(0xffdcf8c6),
//           margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//           child: Stack(
//             children: [
//               Text(
//                 logedInUser.toUpperCase(),
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: -0.5),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 10,
//                   right: 30,
//                   top: 5,
//                   bottom: 20,
//                 ),
//                 child: Text(
//                   message,
//                   style: TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 4,
//                 right: 10,
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                           right: mq.width * .029991,
//                           top: 10,
//                           left: .07),
//                       child: Text(
//                         "${readTimestamp("${snapshot.data.docs[index]['time'] == null ? null : (snapshot.data.docs[index]['time'] as Timestamp).toDate()}")}",
//                         style: TextStyle(color: Colors.black54),
//                       ),
//                     )
//                     // SizedBox(
//                     //   width: 5,
//                     // ),
//                     // Icon(
//                     //   Icons.done_all,
//                     //   size: 20,
//                     // ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }