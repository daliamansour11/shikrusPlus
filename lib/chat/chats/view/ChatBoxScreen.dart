import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanger/Authentication/login/model/Users.dart';

import '../../../main.dart';
import '../../GroupsScreen/GroupInfo.dart';
import '../../view/MessageCard.dart';
import '../api/apis.dart';
import '../model/chat_msg.dart';
import '../model/chat_user.dart';
import '../model/group_model.dart';


TextEditingController _messageController = TextEditingController();

class ChatBoxScreen extends StatefulWidget {
GroupModel groupModel;

ChatBoxScreen({
  required this.groupModel,
});

  @override
  State<ChatBoxScreen> createState() => _ChatBoxScreenState();
}

class _ChatBoxScreenState extends State<ChatBoxScreen> {
  final _textcontroller =TextEditingController();
   ChatUser? user;
   List<Messages>_list =[];
   bool _showEmoji=false,
      _isUploading=false;

  @override
  CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  // void dispose() {
  //   _messageController.dispose();
  // }
  Users_model users_model = Users_model(
      "", "email", "phone", "password", "", true, "image", "status", []);

  @override
  void initState() {
    _messageController.addListener(() {
      setState(() {});
    });
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('groups').doc(groupId);
    DocumentSnapshot d = await documentReference.get();

    return d['admin'];

    // DocumentReference documentReference = groupCollection.doc(groupId);
    // DocumentSnapshot documentSnapshot = await documentReference.get();
    // return documentSnapshot['admin'];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.red));

    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: SafeArea(
        // backbutton -> emoji win off
        child: WillPopScope(
            onWillPop: (){
              if (_showEmoji) {
                setState(() {
                  _showEmoji=!_showEmoji;
                });
                return Future.value(false);
              }else{
                return Future.value(true);
              }
            },

    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Expanded(
          flex: 1,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[400],
                radius: 21.0,
                backgroundImage: NetworkImage('${widget.groupModel.groupImage}'),
              ),
              SizedBox(
                width: 3,
              ),
              Column(
                children: [
                  Text("  ${widget.groupModel.groupName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,)),
                  SizedBox(
                    height: 4,
                  ),
                  Text("  ${widget.groupModel.groupId}",
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
                              groupName: '${widget.groupModel.groupName}',
                              groupId: '${widget.groupModel.groupId}',
                              UserName: '${users_model.name}',
                              groupImage: '${widget.groupModel.groupImage}',
                              admin: '${getGroupAdmin(widget.groupModel.groupId)}',
                            )));
              },
              icon: Icon(Icons.info,color: Colors.grey,))
        ],
      ),
      body: Column(
        children: [
          Expanded(child:
          StreamBuilder(
            stream: Apis.getGroupAllMessages(widget.groupModel),
            builder:(context, AsyncSnapshot snapshot){
              switch (snapshot.connectionState) {
              // if data is loading
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return SizedBox();
              // if some/all data is loaded then show it
                case  ConnectionState.active:
                case ConnectionState.done:

                  //var data=snapshot.data?.docs;
                  _list=snapshot.data?.docs.map((e) => Messages.fromJson(e.data())).toList().cast<Messages>()?? [];
                    // _list.clear();
                   // _list.add(Messages(msg: "Fine", toId: Apis.user, read: '', type: Type.text, send: '10:10 am', fromId: "abcd"));

                  if(_list.isNotEmpty){
                    return ListView.builder(
                      // last msg to show 1st
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: mq.height *.01),
                        itemCount:_list.length,
                        itemBuilder: (context,index){
                          return MessageCard(messages: _list[index],);
                        });
                  }
                  // if no users available
                  else {
                    return Center(child: Text("Say Hii!!👋",style: GoogleFonts.balooBhai2(fontSize: 30),),);
                  }
              }
            },
          ),
          ),
          if(_isUploading)
            Align(alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 5),
                  child: CircularProgressIndicator(strokeWidth: 2,),
                )),
          _chatInput(),

          // emoji select window
          if(_showEmoji)

            SizedBox(
              height: mq.height *.35,
              child: EmojiPicker(
                textEditingController: _textcontroller,
                config: Config(
                  columns: 8,
                  emojiSizeMax: 32 * (Platform.isIOS?1.3:1.0),
                ),
              ),
            )
        ],
      ) ,
    ),
        ),
      ),
    );
  }
          //_chatInput()

          // _listMessagesWidget()),
          // _inputMessagesTextField()





  Widget _chatInput(){
    bool _showEmoji= false;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: mq.height * .01,horizontal: mq.width * .02),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  // emoji func
                  IconButton(onPressed: (){
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _showEmoji=!_showEmoji;
                    });
                  },
                      icon:
                      Icon(Icons.emoji_emotions_outlined,color: Colors.purple,size: 28,)),
                  Expanded(
                      child:TextField(
                        controller: _textcontroller,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onTap: (){
                          if(_showEmoji)
                            setState(() {
                              _showEmoji=!_showEmoji;
                            });
                        },
                        decoration: InputDecoration(
                            hintText: 'Start Chatting....',hintStyle: TextStyle(fontSize: 18),border: InputBorder.none
                        ),
                      ) ),
                  //  select gallery multiple images
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
                  //  camera button
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
                  SizedBox(width: mq.width * .01,)
                ],
              ),
            ),
          ),
          // click to send msgs
          MaterialButton(onPressed: (){
            if(_textcontroller.text.isNotEmpty){
              if(_list.isEmpty){
                // on 1st msg add the user

                    Map<String, dynamic> chatMessageMap = ({
                      'message': _messageController.text,
                      'sender': widget.groupModel.UserName,
                      'time': DateTime.now().millisecondsSinceEpoch,
                    });

                  }
                }else{

                setMessages(String groupId, Map<String, dynamic> chatMessageData) {
                  groupCollection.doc(groupId).collection("messages").add(chatMessageData);
                  groupCollection.doc(groupId).update({
                    "recentMessage": chatMessageData["message"],
                    "recentMessageSender": chatMessageData["sender"],
                    "recentMessageTime": chatMessageData["time"].toString(),
                  });
                  SetOptions(merge: true);
                }
                // Apis.sendFirstGroupMessage(widget.groupModel, _textcontroller.text,Type.text);
              }
            // else{
            //     Apis.sendGroupMessage(widget.groupModel, _textcontroller.text,Type.text);
            //   }

            _textcontroller.text='';
            },

            shape: CircleBorder(),
            minWidth: 0,
            padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 5),
            color: Colors.purple,
            child:Icon(Icons.send,
              color: Colors.white,
            ),)
        ],
      ),
    );
  }

  _listMessagesWidget() {
    List<Messages> _list=[];
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("groups")
            .doc("${widget.groupModel.groupId}")
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
              return MessageCard(messages: _list[index]);
            },
          )
              : Container(
            child: Text("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"),

          );
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
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.purple,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: TextField(
                        maxLines: null,
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "type message here...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: (){
                      },
                      child: Icon(Icons.camera_alt_outlined, color: Colors.purple)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.link, color: Colors.purple),
                  SizedBox(
                    width: 4,
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
        'sender': widget.groupModel.UserName,
        'time': DateTime.now(),
      });
      setMessages("${widget.groupModel.groupId}", chatMessageMap);
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

  final bool sendByMe;

  MessageTile(
      {required this.message, required this.sender, required this.sendByMe});

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            height: 10,
          ),
          Text(" ${ widget.message}"
           ,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          // Spacer(),
        ]),
      ),
    );
  }
}
