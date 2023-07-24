import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanger/chat/chats/model/UsersModel.dart';
import 'package:taskmanger/chat/chats/view/users.dart';
import 'package:taskmanger/chat/view/ListViewCard.dart';
import '../../../Authentication/login/model/Users.dart';
import '../../../TextFiledContainerWidget.dart';
import '../../../core/SharedPreferenceInfo.dart';
import '../../../main.dart';
import '../../../profile/profile.dart';
import '../../../widgets/TextFieldWidget.dart';
import '../../GroupsScreen/GroupListScreen.dart';
import '../api/apis.dart';
import '../chat_provider/ChatProvider.dart';
import 'ChatScreen.dart';
import 'SearchUser.dart';

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

  void filter(List<UserData> list) {
    list
        .where((user) =>
            user.name.toLowerCase().contains(searchTextController.text))
        .toList();
  }

  List<UserData> results = [];


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
  void initState() {
    super.initState();
    Apis.getid();
    gettingUserData();
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
  List<UserData> searchlist = [];
  // String ik="";
  //  Future<String> get_data() async {
  //   DocumentReference doc_ref=FirebaseFirestore.instance.collection("chat").doc();
  //   DocumentSnapshot docSnap = await doc_ref.get();
  //   ik = docSnap.reference.id;
  //   return ik;
  // }

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
            title: Container(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Center(
                        child: TextFieldHeaderWidget(
                            title: "Home", colors: Colors.white),
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
                  )
                : _emptyContainer(),
            // leading:
            actions: [
              IconButton(
                onPressed: ()async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Users()));

                },
                icon: Icon(Icons.search_sharp),
              )
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
                      //  print("${Apis.ik}proo");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Users()));
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
                TextFieldTittleWidget(
                  title: 'Chat',
                  size: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                // Text('Admin',style: TextStyle(fontSize: 23),),
                TextFieldTittleWidget(
                  title: 'Group',
                  size: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            )),
        body: TabBarView(
          children: [
            Center(
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
            Center(
                child: GroupListScreen(
              time: time,
            )),
          ],
        ),
      ),
    );
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
