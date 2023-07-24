import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/SharedPreferenceInfo.dart';
import '../../../main.dart';
import '../../../widgets/TextFieldWidget.dart';
import '../../view/MessageCard.dart';
import '../api/apis.dart';
import '../chat_provider/ChatProvider.dart';
import '../model/UsersModel.dart';
import '../model/chat_msg.dart';
import 'ChatScreen.dart';

class Users extends ConsumerStatefulWidget {
  const Users({

    super.key,
  });

  @override
  ConsumerState<Users> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<Users> {
  List<Messages> _list = [];

  // _ private var
  final _textcontroller = TextEditingController();

  @override
  void initState() {
    gettingUserData();
  } // emoji var           image uploading

  bool _showEmoji = false,
      _isUploading = false;
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
    // List<String>listofid=Apis.ik.split('_');
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.red));
    final userslist = ref.watch(ListOfUsersProvider);
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
                      backgroundColor: Colors.grey[300], title: Text("users")),
                  body: Center(
                    child: Container(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('usersid')
                            // .where('ids', arrayContains: idt)
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                case ConnectionState.none:
                                  return SizedBox();
                                case ConnectionState.active:
                                case ConnectionState.done:
                              //    final data = snapshot.data?.docs;
                                  return ListView.builder(

                                    itemBuilder:(context,indexx){
                                    List<dynamic>addd=[];
                                 //  for(int i=0;i<snapshot.data.docs.length;i++){
                                     addd.add(snapshot.data.docs[indexx]["ids"] );
                                     print("${addd}listt");
                                  // }

                                    List<dynamic>listt = snapshot.data.docs[indexx]["ids"] ?? [];
                                    List<int>id = [];


                                    if (listt[0] != idt) {
                                      id.add(listt[0]);
                                    }
                                    else {
                                      if (listt[1] != idt) {
                                        id.add(listt[1]);
                                      }
                                    }
                                    id.toSet().toList();
                                    print("${id}insidestream");
                                    return   userslist.when(
                                        data: (dataapi) => ListView.builder(
                                          shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            itemCount: dataapi.data.where((element) =>element.id==id[0]).toList().length,
                                            padding: EdgeInsets.only(
                                                top: mq.height * .01),
                                         //   physics: const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              int idapi=dataapi.data[index].id ;
                                              dataapi.data.toSet().toList();

                                              //  List<dynamic>listtt= LinkedHashSet<dynamic>.from(listt).toList()??[];
                                              //   listt.where((element) => element[0].toString()==idt||element[1].toString()==idt).toList();
                                              //List<UserData>userdatalist=   data.data.where((element) => element.id==listt[0]||element.id==listt[1]).toList();

                                              //  listt.toSet().toList()
                                              //   listtt.where((element) => element[index]!=idt).toList();
                                              List<UserData>userdatalist=dataapi.data.where((element) =>element.id==id[0]).toList();
                                              print("${dataapi.data.where((element) =>element.id==id[0]).toList().length}iddd");
                                              print("${id}iddd*");

                                              // print("${data.data.where((
                                              //     element) =>
                                              // element.id == id[0])
                                              //     .toList()[index]
                                              //     .name}snnnnnn");
                                              //      List<int>id2=id[0];
                                              // List<String> id=[];
                                              // for(int i=0;i<listt.length;i++){
                                              // if(listt[index].toString()!=idt){
                                              //   id.add(listt[index].toString());
                                              // }}
                                              //  print("${id[index]}iddd");
                                              List<int>idd = [];
                                              // idd.add(id[0]);
                                              //print("${idd}iddd");
                                              //  List<UserData>userss=data.data.where((element) =>element.id==id[0]).toList();
                                          //    return Text("${userdatalist[index].name}");
                                            return  Card(
                                                  margin: EdgeInsets
                                                      .symmetric(
                                                      horizontal: mq.width *
                                                          .03,
                                                      vertical: 5),
                                                  color: Colors.grey[300],
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                                  elevation: 2,
                                                  child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    _) =>
                                                                    ChatScreen(
                                                                      userId:
                                                                      '${userdatalist[index]
                                                                          .id}',
                                                                      userImage:
                                                                      '${userdatalist[index]
                                                                          .image}',
                                                                      UserName:
                                                                      '${
                                                                          userdatalist[index]
                                                                          .name}',
                                                                      user: userdatalist[index],
                                                                    )));
                                                      },
                                                      // profile pic + list of chat users
                                                      child: ListTile(

                                                        leading: InkWell(
                                                          onTap: () {
                                                            // showDialog(context: context, builder: (_)=>DialogProfile(user: widget.user));
                                                          },
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        mq.height *
                                                                            .3),
                                                            child: CachedNetworkImage(
                                                              width: mq.height * .050,
                                                              height: mq.height * .050,
                                                              imageUrl:userdatalist[index].image??"",
                                                              errorWidget: (context, url, error) =>
                                                                  CircleAvatar(
                                                                child: Icon(CupertinoIcons.person),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        title: TextFieldTitleWidget(
                                                          title: "${userdatalist[index].name}" ??
                                                              "",
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                        // last msg show
                                                        // subtitle:
                                                        //     TextFieldTitleWidget(
                                                        //   title: "${listt[index]}"??"",
                                                        //   colors: Colors.grey,
                                                        // ),
                                                      )));
                                            }),
                                        error: (err, _) => Center(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              TextFieldTitleWidget(
                                                title:
                                                "No Internet Connection",
                                                fontWeight: FontWeight.normal,
                                                size: 20.sp,
                                              ),
                                              SizedBox(width: 5.sp),
                                              CircleAvatar(
                                                child: Image.asset(
                                                  "assets/sad.jpg",
                                                ),
                                                radius: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                        loading: () => Center(
                                            child: CircularProgressIndicator(
                                            )
                                        ));
                                  },itemCount: snapshot.data.docs.length,);


                              }
                            })),
                  ),
                ))));
  }
// if no users available
}
