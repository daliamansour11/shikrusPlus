import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmanger/chat/chats/model/UsersModel.dart';
import 'package:taskmanger/chat/chats/model/chat_user.dart';
import 'package:taskmanger/chat/view/ListViewCard.dart';

import '../../../Authentication/login/model/Users.dart';
import '../../../TextFiledContainerWidget.dart';
import '../../../main.dart';
import '../../../profile/profile.dart';
import '../../GroupsScreen/GroupListScreen.dart';
import '../api/apis.dart';



class HomeChat extends StatefulWidget{
  @override
  State<HomeChat> createState() => _HomeChatState();
}
class _HomeChatState extends State<HomeChat> {
  TextEditingController searchTextController = TextEditingController();
  bool _isSearch =false;
  String? AuthEmail = FirebaseAuth.instance.currentUser?.email;
  DateTime time =DateTime.now();
  List<ChatUser> _list=[];

  // List <ChatUser> adminList= [];
  final List<ChatUser> _searchList=[];
  void iconClickEvent(){
    setState(() {
      _isSearch=!_isSearch;
      print("search");
    });
  }
  List<UsersModel> allUsers =  [];
  String? Auth = FirebaseAuth.instance.currentUser?.email;
  CollectionReference groupCollection =   FirebaseFirestore.instance.collection('groups ');
  String groupName = '';

  getUserGroups()async{
    {
      return FirebaseFirestore.instance.collection('users ')
          .where('uId',isEqualTo: FirebaseAuth.instance.currentUser?.uid);
    }
  }
  @override
  void dispose() {
    searchTextController.dispose();
  }
  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
  Widget _emptyContainer(){
    return Container(
      height: 0,width: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.grey[200],

            appBar: AppBar(
                elevation: 0.0,
                backgroundColor: _isSearch== true?Colors.transparent:Color(0xFF005373),
                title: _isSearch== true?_emptyContainer():
                Container(
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Center(
                      child: Text("Message",
                        style: TextStyle(fontSize: 25,
                            fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    ),
                  ),
                ),
                centerTitle: true,
                flexibleSpace: _isSearch ==true?_buildSearchWidget():_emptyContainer(),
                // leading:
                actions: _isSearch==true?[]:[
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0,top: 12),
                      child: Icon(Icons.search,color: Colors.white,),
                    ),onTap: (){
                    setState(() {
                      _isSearch=!_isSearch;
                    });
                  },),
                ],
                leading:_isSearch== true? Visibility(// hiding the child widget
                  visible: false,
                  child: Text("",),
                )
                    :Padding(
                  padding: const EdgeInsets.only(top: 12.0,left: 4),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>Profilescreen()));
                    },
                    child: CircleAvatar (
                      backgroundImage:  AssetImage(
                        "assets/personn.jpg",
                      ),
                      radius: 20,
                    ),
                  ),
                ),
                bottom: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey[500],
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // color: Colors.white,
                  ),
                  tabs: [
                    Text('chat',style: TextStyle(fontSize: 23),),
                    // Text('Admin',style: TextStyle(fontSize: 23),),
                    Text('Groups',style: TextStyle(fontSize: 23),),
                  ] ,
                )),
            body: TabBarView(children: [


              Center(
                child:  Container(
                    child:  StreamBuilder(
                      stream:AuthEmail=="mohmed112@gmail.com"?
                      Apis.getAdminUsers():Apis.getMyUsersId(),

                      //get id of only known users
                      builder: (context,AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                        //if data is loading
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                          // return const Center(child: CircularProgressIndicator());

                          //if some or all data is loaded then show it
                          case ConnectionState.active:
                          case ConnectionState.done:
                            return StreamBuilder(
                              stream: Apis.getAllUsers(
                                  snapshot.data?.docs.map((e) => e.id).toList().cast<String>()?? []),

                              //get only those user, who's ids are provided
                              builder: (context,AsyncSnapshot snapshot) {
                                switch (snapshot.connectionState) {
                                //if data is loading
                                  case ConnectionState.waiting:
                                  case ConnectionState.none:
                                  // return const Center(
                                  //     child: CircularProgressIndicator());

                                  //if some or all data is loaded then show it
                                  case ConnectionState.active:
                                  case ConnectionState.done:
                                    final data = snapshot.data?.docs;
                                    _list = data
                                        ?.map((e) => ChatUser.fromJson(e.data()))
                                        .toList().cast<ChatUser>() ??
                                        [];

                                    if (_list.isNotEmpty) {

                                      return ListView.builder(
                                          itemCount: _isSearch
                                              ? _searchList.length
                                              : _list.length,
                                          padding: EdgeInsets.only(top: mq.height * .01),
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return ListViewCard(
                                                user: _isSearch
                                                    ? _searchList[index]
                                                    : _list[index]);
                                          });
       // return Padding(
      //   padding: const EdgeInsets.only(bottom: 490),
      //   child: ListViewCard(
      //       user:_list[0]
      //   ),
      // );
                                    } else {
                                      return const Center(
                                        child: Text('No Connections Found!',
                                            style: TextStyle(fontSize: 20)),
                                      );
                                    }
                                }
                              },
                            );
                        }
                      },
                    ),
                ),
              ),


              Center(child:GroupListScreen(
                time: time,
              )),
            ],
            )
        ));
  }
  Widget _buildSearchWidget(){
    return Container(
      margin: EdgeInsets.only(top: 25),
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow:[
          BoxShadow(
              color: Colors.black.withOpacity(.3),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0,0.50)
          )],),
      child: TextFieldContainerWidget(
        // focusNode: focusNode,
        controller: searchTextController,
        keyboardType: TextInputType.text,
        prefixIcon:Icons.arrow_back,
        hintText: "Search here..",
        borderRadius: 0.0,
        color: Colors.white,
        iconClickEvent: (){
          setState(() {
            _isSearch=!_isSearch;
          });
        }, onChanged: (val) {  },
      ),

    );
  }
}







