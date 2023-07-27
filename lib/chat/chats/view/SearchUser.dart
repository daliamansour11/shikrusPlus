import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskmanger/chat/chats/view/HomeChat.dart';

import '../../../core/SharedPreferenceInfo.dart';
import '../../../main.dart';
import '../../../widgets/TextFieldWidget.dart';
import '../chat_provider/ChatProvider.dart';
import '../model/UsersModel.dart';
import 'ChatScreen.dart';

class SearchUser extends ConsumerStatefulWidget {
  @override
  ConsumerState<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends ConsumerState<SearchUser> {
  TextEditingController searchcontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchcontroller.dispose();
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
    gettingUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userslist = ref.watch(ListOfUsersProvider);
    List<UserData> searchlist = [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF005373) ,
        centerTitle: true,
        title: TextFieldHeaderWidget(title: "Users",colors: Colors.white,),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: userslist.when(
              data: (data) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: searchcontroller,
                          obscureText: false,
                          onChanged: (value) {
                            setState(() {
                              value = searchcontroller.text;
                              // searchlist=  data.data.where((element) => element.name == "sam").toList();
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor:  CupertinoColors.white,
                            focusColor:  CupertinoColors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:Color(0xFF005373),
                                   width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF005373),
                                // width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF005373),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            // labelText: "UserEmail", //babel text
                            hintText: "Search here...",

                            contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                            //hint text
                            prefixIcon: Icon(Icons.search,color: Color(0xFF005373),),
                            //prefix iocn
                            hintStyle: TextStyle(color: Color(0xFF005373)),
                            //hint text style
                            labelStyle: TextStyle(
                                fontSize: 13, color: Colors.redAccent), //label style
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.data
                                .where((element) => element.name
                                    ?.toLowerCase()
                                    .contains(searchcontroller.text)??false).where((element) => element.id != idt)
                                .toList()
                                .length,
                            itemBuilder: (context, index) {
                              List<UserData> searchuser = data.data
                                  .where((element) => element.name
                                      ?.toLowerCase()
                                      .contains(searchcontroller.text)??false)
                                  .toList();

                              return data.data[index].id !=idt? Card(
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
                                                          '${searchuser[index].id}',
                                                      userImage:
                                                          '${searchuser[index].image}',
                                                      UserName:
                                                          '${searchuser[index].name}',
                                                      user: searchuser[index],
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
                                                  data.data[index].image??"",
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
                                        title: TextFieldTitleWidget(
                                          title: searchuser[index].name??"",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        // last msg show
                                        subtitle: TextFieldTitleWidget(
                                          title: searchuser[index].type??"",
                                          colors: Colors.grey,
                                        ),

                                        //  trailing: Text("10:10 pm",style: TextStyle(color: Colors.black54),),
                                        // last msg time
                                        trailing: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        // show send time for read msg);
                                      ))):Text('');
                            }),
                      ),
                    ],
                  ),
              error: (err, _) => Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldTitleWidget(
                          title: "No Internet Connection",
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
              loading: () => Center(child: CircularProgressIndicator())),
        )

    );
  }
}
