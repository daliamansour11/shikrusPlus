import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanger/chat/chats/model/UsersModel.dart';
import 'package:taskmanger/chat/chats/model/chat_user.dart';
import 'package:taskmanger/chat/view/ListViewCard.dart';

import '../../../Authentication/login/model/Users.dart';
import '../../../TextFiledContainerWidget.dart';
import '../../../core/SharedPreferenceInfo.dart';
import '../../../main.dart';
import '../../../profile/profile.dart';
import '../../GroupsScreen/GroupListScreen.dart';
import '../api/apis.dart';
import '../chat_provider/ChatProvider.dart';
import 'ChatScreen.dart';

class HomeChat extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends ConsumerState<HomeChat> {
  TextEditingController searchTextController = TextEditingController();
  bool _isSearch = false;
  String? AuthEmail = FirebaseAuth.instance.currentUser?.email;
  DateTime time = DateTime.now();
  List<UserData> _list = [];

  // List <ChatUser> adminList= [];
  final List<UserData> _searchList = [];

  void iconClickEvent() {
    setState(() {
      _isSearch = !_isSearch;
      print("search");
    });
  }
  void filter(List<UserData>list){
    list.where((user) => user.name.toLowerCase()
        .contains(searchTextController.text)).toList();
  }
  List<UserData> results = [];
  // void _runFilter(String enteredKeyword) {
  //
  //   if (enteredKeyword.isEmpty) {
  //     // if the search field is empty or only contains white-space, we'll display all users
  //     results = _allUsers;
  //   } else {
  //     results = _allUsers
  //         .where((user) =>
  //         user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //     // we use the toLowerCase() method to make it case-insensitive
  //   }
  //
  // }
  List<UsersModel> allUsers = [];
  String? Auth = FirebaseAuth.instance.currentUser?.email;
  CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups ');
  String groupName = '';

  getUserGroups() async {
    {
      return FirebaseFirestore.instance
          .collection('users ')
          .where('uId', isEqualTo: FirebaseAuth.instance.currentUser?.uid);
    }
  }

  @override
  void dispose() {
    searchTextController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Apis.getid();
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }

  Widget _emptyContainer() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  // String? user = auth.currentUser?.uid;
  List<UserData>searchlist=[];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final userslist = ref.watch(ListOfUsersProvider);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
                elevation: 0.0,
                backgroundColor:
                    _isSearch == true ? Colors.transparent : Color(0xFF005373),
                title: _isSearch == true
                    ? _emptyContainer()
                    :  Container(
                          width: screenWidth,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Center(
                              child: Text(
                                "Home",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                centerTitle: true,
                flexibleSpace: _isSearch == true
                    ? Container(
                  margin: EdgeInsets.only(top: 25),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: Offset(0, 0.50))
                    ],
                  ),
                  child: userslist.when(
                      data: (data) => TextFieldContainerWidget(
                      // focusNode: focusNode,
                      controller: searchTextController,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.arrow_back,
                      hintText: "Search here..",
                      borderRadius: 0.0,
                      color: Colors.white,
                      iconClickEvent: () {
                        setState(() {
                          _isSearch = !_isSearch;
                        });
                      },
                      onChanged: (val) {
                        filter(data.data);
                       searchlist= data.data.where((user) => user.name.toLowerCase()
                            .contains(searchTextController.text)).toList();
                      },
                    ),
                      error: (err, _) => Text(
                        "$err",
                        style: TextStyle(color: Colors.red),
                      ),
                      loading: () => Center(child: CircularProgressIndicator())
                  ),
                )
                    : _emptyContainer(),
                // leading:
                actions: _isSearch == true
                    ? []
                    : [
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 12),
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _isSearch = !_isSearch;
                            });
                          },
                        ),
                      ],
                leading: _isSearch == true
                    ? Visibility(
                        // hiding the child widget
                        visible: false,
                        child: Text(
                          "",
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 4),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profilescreen()));
                          },
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
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
                    Text(
                      'chat',
                      style: TextStyle(fontSize: 23),
                    ),
                    // Text('Admin',style: TextStyle(fontSize: 23),),
                    Text(
                      'Groups',
                      style: TextStyle(fontSize: 23),
                    ),
                  ],
                )),
            body: TabBarView(
              children: [
                Center(
                  child: Container(
                    child: userslist.when(
                        data: (data) => ListView.builder(
                            itemCount: _isSearch
                                ?searchlist
                                    .length
                                : data.data.length,
                            padding: EdgeInsets.only(top: mq.height * .01),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              List<UserData> search = data.data
                                  .where((user) => user.name
                                      .contains(searchTextController.text))
                                  .toList();
                              return _isSearch == true
                                  ? Card(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: mq.width * .03,
                                          vertical: 5),
                                      color: Colors.grey[300],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      elevation: 2,
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => ChatScreen(
                                                          userId:
                                                              '${searchlist[index].id}',
                                                          userImage:
                                                              '${searchlist[index].image}',
                                                          UserName:
                                                              '${searchlist[index].name}',
                                                          user: searchlist[index],
                                                        )));
                                          },
                                          // profile pic + list of chat users
                                          child: ListTile(
                                            // user profile pic
                                            leading: InkWell(
                                              onTap: () {
                                                // showDialog(context: context, builder: (_)=>DialogProfile(user: widget.user));
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        mq.height * .3),
                                                child: CachedNetworkImage(
                                                  width: mq.height * .050,
                                                  height: mq.height * .050,
                                                  imageUrl: search[index].image,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          CircleAvatar(
                                                    child: Icon(
                                                        CupertinoIcons.person),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // user name show
                                            title: Text(search[index].name,
                                                style: GoogleFonts.balooBhai2(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            // last msg show
                                            subtitle: Text(
                                              search[index].type,
                                              maxLines: 1,
                                            ),

                                            //  trailing: Text("10:10 pm",style: TextStyle(color: Colors.black54),),
                                            // last msg time
                                            trailing: Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            // show send time for read msg);
                                          )))
                                  : Card(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: mq.width * .03,
                                          vertical: 5),
                                      color: Colors.grey[300],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      elevation: 2,
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => ChatScreen(
                                                          userId:
                                                              '${data.data[index].id}',
                                                          userImage:
                                                              '${data.data[index].image}',
                                                          UserName:
                                                              '${data.data[index].name}',
                                                          user:
                                                              data.data[index],
                                                        )));
                                          },
                                          // profile pic + list of chat users
                                          child: ListTile(
                                            // user profile pic
                                            leading: InkWell(
                                              onTap: () {
                                                // showDialog(context: context, builder: (_)=>DialogProfile(user: widget.user));
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        mq.height * .3),
                                                child: CachedNetworkImage(
                                                  width: mq.height * .050,
                                                  height: mq.height * .050,
                                                  imageUrl:
                                                      data.data[index].image,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          CircleAvatar(
                                                    child: Icon(
                                                        CupertinoIcons.person),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // user name show
                                            title: Text(data.data[index].name,
                                                style: GoogleFonts.balooBhai2(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            // last msg show
                                            subtitle: Text(
                                              data.data[index].type,
                                              maxLines: 1,
                                            ),

                                            //  trailing: Text("10:10 pm",style: TextStyle(color: Colors.black54),),
                                            // last msg time
                                            trailing: Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            // show send time for read msg);
                                          )));
                            }),
                        error: (err, _) => Text(
                              "$err",
                              style: TextStyle(color: Colors.red),
                            ),
                        loading: () => Center(child: CircularProgressIndicator())),

                    // return Padding(
                    //   padding: const EdgeInsets.only(bottom: 490),
                    //   child: ListViewCard(
                    //       user:_list[0]
                    //   ),
                    // );
                  ),
                ),
                Center(
                    child: GroupListScreen(
                  time: time,
                )),
              ],
            )));
  }

  Widget _buildSearchWidget() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.3),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 0.50))
        ],
      ),
      child: TextFieldContainerWidget(
        // focusNode: focusNode,
        controller: searchTextController,
        keyboardType: TextInputType.text,
        prefixIcon: Icons.arrow_back,
        hintText: "Search here..",
        borderRadius: 0.0,
        color: Colors.white,
        iconClickEvent: () {
          setState(() {
            _isSearch = !_isSearch;
          });
        },
        onChanged: (val) {},
      ),
    );
  }
}
