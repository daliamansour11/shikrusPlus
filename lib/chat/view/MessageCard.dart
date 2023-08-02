import 'dart:developer';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/Dialogs.dart';
import '../../core/SharedPreferenceInfo.dart';
import '../../main.dart';
import '../chats/api/MyDate.dart';
import '../chats/api/apis.dart';
import '../chats/model/chat_msg.dart';

class MessageCard extends StatefulWidget {
  final Messages messages;
final  String userId;

  const MessageCard({super.key, required this.messages, required this.userId});

  @override
  State<MessageCard> createState() => _MessageCardState();
}
class _MessageCardState extends State<MessageCard> {
  String type = "";
  int idt = 0;

  gettingUserType() async {
    await SharedPreferencesInfo.getUserTypeFromSF().then((value) {
      setState(() {
        type = value!;
        print("nameeeeeeeeeeeeee$type");
      });
    });
  }
//child: widget.userid == widget.messages.fromId? _greenMessage():_redMessage(),
  gettingUserData() async{
    await SharedPreferencesInfo.getUserIdFromSF().then((value) {
      setState(() {
        idt = value!;
        print("nameeeeeeeeeeeeee$idt");
      });
    });
  }

  @override
  void initState() {
    gettingUserType();
    gettingUserData();
    print("${idt}yyyyyyyyyyyyyyyy");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool isMe = widget.userId == widget.messages.fromId ;
    print("IFFFFFFFFFFFFFFFFFF${widget.messages.fromId}");
    print("IFFFFFFFFFFFFFFFFF2222222222222dddddddddddd$idt");
    // if (idt == widget.messages.fromId) {
      return
        widget.userId == widget.messages.fromId?
          Align(
            alignment: Alignment.topLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width -45,
              ),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight:Radius.circular(8)
                    ,topLeft: Radius.circular(8),bottomLeft: Radius.circular(8))),
                color: Color(0xD2D5D2DC),
                //0xD2D5D2DC
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Stack(
                  children: [
                    widget.messages.type == Type.text
                        ? Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 30,
                        top: 20,
                        bottom: 20,),
                      child: Text(
                        widget.messages.msg,
                        style: GoogleFonts.balooBhai2(fontSize: 20),
                      ),
                    )
                    //
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                        imageUrl: widget.messages.msg,
                        errorWidget: (context, url, error) =>
                            Icon(Icons.image),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(

                                top: 10,
                                left: .08),
                            child: Text(MyDate.getFormattedtime(context: context, time: widget.messages.send),
                              style: TextStyle( fontSize:13,color: Colors.black54),
                            ),
                          )
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
          ):Align(
            alignment: Alignment.topRight,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width -45,
              ),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight:Radius.circular(10)
                    ,topLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                color: Color(0xffdcf8c6),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Stack(
                  children: [
                    SizedBox(height:3),
                    widget.messages.type == Type.text
                        ? Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 30,
                            top: 20,
                            bottom: 20,
                          ),
                          child: Text(
                      widget.messages.msg,
                      style: GoogleFonts.balooBhai2(fontSize: 20),
                    ),
                        )
                        : Container(
                      padding: EdgeInsets.all(widget.messages.type==Type.image?mq.width* .03:mq.width * .05),margin: EdgeInsets.symmetric(vertical: mq.height * .02,horizontal: mq.width *.03),
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
                          imageUrl: widget.messages.msg,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.image),
                      ),
                    ),
                        ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(

                                top: 10,
                                left: .08),
                            child: Text(MyDate.getFormattedtime(context: context, time: widget.messages.send),
                              style: TextStyle( fontSize:13,color: Colors.black54),
                            ),
                          )
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

  // sender msgs
  Widget _redMessage() {
    print("${widget.messages.fromId}iddt");
    // update the read msg status when sender sends a msg
    if (widget.messages.read.isEmpty) {
      Apis.updateMessageReadstatus(widget.messages);
      // print('msg updated');
    }
    return Row(
      children: [
        Align(
          alignment: Alignment.topRight,
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
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 5.0,top: 2),
                  //   child: Text(
                  //     logedInUser.toUpperCase(),
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         fontSize: 13,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.grey[600],
                  //         letterSpacing: -0.5),
                  //   ),
                  // ),
                  // SizedBox(height:3),
                  widget.messages.type == Type.text
                      ? Text(
                    widget.messages.msg,
                    style: GoogleFonts.balooBhai2(fontSize: 20),
                  )
                  //
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                      imageUrl: widget.messages.msg,
                      errorWidget: (context, url, error) =>
                          Icon(Icons.image),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(

                              top: 10,
                              left: .08),
                          child: Text(MyDate.getFormattedtime(context: context, time: widget.messages.send),
                            style: TextStyle( fontSize:13,color: Colors.black54),
                          ),
                        )
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
        )
      ],
    );
  }

  // user/my msgs
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [

            // SizedBox(
            //   width: mq.width * .04,
            // ),
            // Flexible(
            //   child: Container(
            //     padding: EdgeInsets.all(widget.messages.type == Type.image
            //         ? mq.width * .03
            //         : mq.width * .05),
            //     margin: EdgeInsets.symmetric(
            //         vertical: mq.height * .02, horizontal: mq.width * .03),
            //     decoration: BoxDecoration(
            //         color: Color.fromARGB(255, 130, 223, 135),
            //         border: Border.all(color: Colors.green),
            //         borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(30),
            //             topRight: Radius.circular(30),
            //             bottomLeft: Radius.circular(30))),
            //     child:
            //     // to send images
            //     widget.messages.type == Type.text
            //         ? Text(
            //       widget.messages.msg,
            //       style: GoogleFonts.balooBhai2(fontSize: 20),
            //     )
            //         : ClipRRect(
            //       borderRadius: BorderRadius.circular(15),
            //       child: CachedNetworkImage(
            //         placeholder: (context, url) => Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: CircularProgressIndicator(
            //             strokeWidth: 2,
            //           ),
            //         ),
            //         imageUrl: widget.messages.msg,
            //         errorWidget: (context, url, error) =>
            //             Icon(Icons.image),
            //       ),
            //     ),
            //   ),
            // ),
            // // blue tick icon for read messages
            // if (widget.messages.read.isNotEmpty)
            //   Icon(
            //     Icons.done_all_rounded,
            //     color: Colors.blue,
            //     size: 20,
            //   ),
            // SizedBox(
            //   width: mq.width * .01,
            // ),
            //
            // // msg send time
            // Text(
            //   MyDate.getFormattedtime(
            //       context: context, time: widget.messages.send),
            //   style:
            //       GoogleFonts.balooBhai2(fontSize: 15, color: Colors.black54),
            // ),

          ],
        ),

      ],
    );
  }

  void _showbottomsheet(bool isMe) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: mq.height * .015, horizontal: mq.width * .4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),

              // copy text
              widget.messages.type == Type.text
                  ? _OptionItem(
                      icon: Icon(
                        Icons.copy,
                        color: Colors.blue,
                        size: 26,
                      ),
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
                  : _OptionItem(
                      icon: Icon(
                        Icons.download_rounded,
                        color: Colors.blue,
                        size: 26,
                      ),
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
              if (isMe)
                Divider(
                  color: Colors.black54,
                  endIndent: mq.width * .04,
                  indent: mq.width * .04,
                ),

              //edit msg
              if (widget.messages.type == Type.text && isMe)
                _OptionItem(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                      size: 26,
                    ),
                    name: 'Edit Message',
                    onTap: () {
                      Navigator.pop(context);
                      _showMessageUpdateDialog();
                    }),

              // del msg
              if (isMe)
                _OptionItem(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 26,
                    ),
                    name: 'Delete Message',
                    onTap: () async {
                      // UploadTask uploadTask = await storageReference.putFile(mFileImage);
                      if (mounted)
                        await Apis.deleteMessage(widget.messages).then((value) {
                          Navigator.pop(context);
                        });
                    }),
              Divider(
                color: Colors.black54,
                endIndent: mq.width * .04,
                indent: mq.width * .04,
              ),

              // sent time
              _OptionItem(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.blue,
                    size: 26,
                  ),
                  name:
                      'Send At:  ${MyDate.getMessageTimepersonalchat(context: context, time: widget.messages.send)}',
                  onTap: () {}),

              // read time
              _OptionItem(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.green,
                    size: 26,
                  ),
                  name: widget.messages.read.isEmpty
                      ? "Read at:  Not seen yet"
                      : 'Read at: ${MyDate.getMessageTime(context: context, time: widget.messages.read)}',
                  onTap: () {}),
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

  const _OptionItem(
      {required this.icon, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: mq.width * .05,
            top: mq.height * .015,
            bottom: mq.height * .015),
        child: Row(
          children: [
            icon,
            Flexible(
                child: Text(
              '    $name',
              style: TextStyle(
                  fontSize: 16, letterSpacing: .5, color: Colors.black87),
            )),
          ],
        ),
      ),
    );
  }
}
