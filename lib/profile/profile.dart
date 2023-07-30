import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanger/Authentication/login/view/Login.dart';
import 'package:taskmanger/core/SharedPreferenceInfo.dart';

import '../Authentication/login/provider/logoutprovider.dart';
import '../main.dart';
import 'EditProfileScreen.dart';

class Profilescreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends ConsumerState<Profilescreen> {
  String userName = '';
  String userEmail = '';
  String logedInuseType = '';

  gettingUserData() async {
    await SharedPreferencesInfo.getUserNameFromSF().then((value) {
      setState(() {
        userName = value ?? "";
      });
      print("nameeeeeeeeeeeeee22222222222 ${userName}");
    });
    await SharedPreferencesInfo.getUserTypeFromSF().then((usertype) {
      setState(() {
        logedInuseType = usertype ?? "0";
      });
      print("nameeeeeeeeeeeeee22222222222 ${logedInuseType}");
    });await SharedPreferencesInfo.getUserEmailFromSF().then((useremail) {
      setState(() {
        userEmail = useremail ?? "0";
      });
      print("nameeeeeeeeeeeeee22222222222 ${userEmail}");
    });
  }
  @override
  void initState() {
    gettingUserData();
  }

  @override
  Widget build(BuildContext context) {
    final logout=ref.watch(logedoutProvider);
    return Scaffold(
        backgroundColor: Color(0xFFEFEDED),
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Color(0xFF005373),


          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 57),
                child: Center(
                  child: Text("Profile", style: TextStyle(
                      fontSize: 25, color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,

            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: Row(
                          children: [
                            Center(
                                child: Container(
                                  height: 500,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 70, right: 30),
                                        child: Container(

                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(
                                                mq.height * .3),
                                            child: CachedNetworkImage(
                                              width: mq.height * .14,
                                              height: mq.height * .14,
                                              // imageUrl: groupModel!.groupImage??"",
                                              errorWidget: (context, url,
                                                  error) =>
                                                  CircleAvatar(
                                                    radius: 50,
                                                    backgroundColor: Colors
                                                        .white,
                                                    child: Icon(
                                                      CupertinoIcons.person,
                                                      color: Colors.grey,),),
                                              imageUrl: '',

                                            ),
                                          ),

                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 70.0, right: 45),
                                        child: Text(userName,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.indigo),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 70.0, right: 45),
                                        child: Text(userEmail,
                                          style: TextStyle(fontSize: 20,
                                              color: Colors.grey[700]),
                                        ),
                                      ), Padding(
                                        padding: const EdgeInsets.only(
                                            left: 70.0, right: 45),
                                        child: Text(logedInuseType,
                                          style: TextStyle(fontSize: 20,
                                              color: Colors.grey[700]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 60,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 46.0, right: 10),
                                            child: InkWell(
                                              onTap: () async {
                                                SharedPreferences prefrences = await SharedPreferences
                                                    .getInstance();
                                                setState(() {
                                                var res=  ref.read(logedoutProvider);
                                                  // prefrences.remove(
                                                  //     SharedPreferencesInfo
                                                  //         .userTokenKey);
                                                  // prefrences.clear();
                                                  // Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginScreen()));
                                                });
                                              },
                                              child: Container(
                                                height: 60,
                                                width: 180,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF005373),
                                                  borderRadius: BorderRadius
                                                      .circular(15),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 45,
                                                    ),

                                                    Center(
                                                      child: Text(
                                                        "Log out",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),


                                    ],
                                  ),
                                )
                            ),
                          ]),
                    ),
                  ]),
            )));
  }

  Future toggleUserLogin(String UserId, String userName,
      String userToken) async {
    //doc

    SharedPreferences prefrences = await SharedPreferences
        .getInstance();

    setState(() {
      prefrences.remove(
          SharedPreferencesInfo
              .userTokenKey);
      prefrences.clear();
    });

  }
}