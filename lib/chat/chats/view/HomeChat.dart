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
        .where((user) => user.name?.toLowerCase().contains(searchTextController.text)??false)
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
String type="";
  gettingUserType() async {
    await SharedPreferencesInfo.getUserTypeFromSF().then((value) {
      setState(() {
        type = value!;
        print("nameeeeeeeeeeeeee$type");
      });
    });
  }
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
    gettingUserType();
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
                            title: "Contact", colors: Colors.white),
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
              type=="admin"?
              Visibility(
                visible: true,
                child: IconButton(
                  onPressed: ()async {


                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchUser()));

                  },
                  icon: Icon(Icons.search_sharp),
                ),
              ):Visibility(
                visible: false,
                child: IconButton(
                  onPressed: ()async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchUser()));

                  },
                  icon: Icon(Icons.search_sharp),
                ),
              )
            ],

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
                  child:type=="admin"?
                  StreamBuilder<QuerySnapshot>(
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


                                if (listt[0] != idt||listt[0] !="null") {
                                  id.add(listt[0]);
                                }
                                else {
                                  if (listt[1] != idt||listt[1] !="null") {
                                    id.add(listt[1]);
                                  }
                                }

                                // FirebaseFirestore.instance.collection('usersid').doc()
                                //     .get().then((DocumentSnapshot) =>
                                //     print("${DocumentSnapshot.data()?.length}docccc")
                                // );
                                List<int>id2=[];
                                id2.add(id.single);
                                print("${id2.toSet().toList()}insidestream");
                                return   userslist.when(
                                    data: (dataapi) => ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: dataapi.data.where((element) =>element.id==id[0]).where((element) => element.type !="admin").toList().length,
                                        padding: EdgeInsets.only(
                                            top: mq.height * .01),
                                        //   physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {

                                          List<UserData>userdatalist=dataapi.data.where((element) =>element.id==id[0]).where((element) => element.type !="admin").toList();
                                          // List<UserData>userdatalistclient=dataapi.data.where((element) => element.type=="admin").toList();

                                          print("${dataapi.data.where((element) =>element.id==id[0]).toList().length}iddd");
                                          print("${id}iddd*");
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                                            child: Card(
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
                                                    child: ListTile(

                                                      leading: InkWell(
                                                        onTap: () {
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
                                                    ))),
                                          );

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
                      }):
                  userslist.when(data:(datax)=> ListView.builder(
                    itemBuilder: (context,index){
                      List<UserData>userdata=datax.data.where((element) => element.type=="admin").toList();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Card(
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
                                              '${userdata[index]
                                                  .id}',
                                              userImage:
                                              '${userdata[index]
                                                  .image}',
                                              UserName:
                                              '${
                                                  userdata[index]
                                                      .name}',
                                              user: userdata[index],
                                            )));
                              },
                              child: ListTile(
                                leading: InkWell(
                                  onTap: () {
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
                                      imageUrl:userdata[index].image??"",
                                      errorWidget: (context, url, error) =>
                                          CircleAvatar(
                                            child: Icon(CupertinoIcons.person),
                                          ),
                                    ),
                                  ),
                                ),

                                title: TextFieldTitleWidget(
                                  title: "${userdata[index].name}" ??
                                      "",
                                  fontWeight:
                                  FontWeight.bold,
                                ),

                              ))),
                    );
                  },itemCount:datax.data.where((element) => element.type=="admin").toList().length ,), error: (err, _) => Center(
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
                      ))),
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
extension ListExtensions<T> on List<T> {
  Iterable<T> whereWithIndex(bool test(T element, int index)) {
    final List<T> result = [];
    for (var i = 0; i < this.length; i++) {
      if (test(this[i], i)) {
        result.add(this[i]);
      }
    }
    return result;
  }
}
