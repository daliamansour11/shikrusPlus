import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../TextFiledContainerWidget.dart';
import '../../main.dart';
import '../../profile/profile.dart';
import '../chats/chat_provider/ChatProvider.dart';
import '../chats/model/UsersModel.dart';
import '../view/ListViewCard.dart';

class AllUsersWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllUsersWidgetState();
}
  class _AllUsersWidgetState extends ConsumerState<AllUsersWidget> {
    TextEditingController searchTextController = TextEditingController();
    bool _isSearch =false;
    List<UsersModel> _list=[];
    DateTime time =DateTime.now();
    final List<UsersModel> _searchList=[];
    void iconClickEvent(){
      setState(() {
        _isSearch=!_isSearch;
        print("search");
      });
    }
    List<UsersModel> allUsers =  [];
    Widget _emptyContainer(){
      return Container(
        height: 0,width: 0,
      );
    }

    @override
  Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      final usersList = ref.watch(ListOfUsersProvider);

      return Scaffold(
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
    ),
        body: usersList.when(data:(data)=>ListView.builder(
            itemCount: _isSearch
                ? _searchList.length
                : data.data.length,
            padding: EdgeInsets.only(top: mq.height * .01),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                  margin: EdgeInsets.symmetric(horizontal: mq.width *.03,vertical: 5),
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 2,
                child: ListTile(
                  leading:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height *.3),

                    child: CachedNetworkImage(
                      width: mq.height * .050,
                      height: mq.height * .050,
                      // imageUrl: groupModel!.groupImage??"",
                      errorWidget: (context, url, error) =>
                          CircleAvatar(
                            child: Icon(CupertinoIcons.person),
                          ),
                      imageUrl: '${data.data[index].image}'),
                  ),
                  title: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${data.data[index].name}"),
                      ),
                    ],
                  ),
                  subtitle: Text("${data.data[index].type}"),
                ),
              );
            },
          ),
              error: (err,_)=>Text("$err"), loading:
              ()=>Center(child: CircularProgressIndicator(),)),
      );
  }
    Widget _buildSearchWidget(){
      return Container(
        margin: EdgeInsets.only(top: 35),
        height: 80,
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
        child:
             TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: InkWell(child: Icon(Icons.arrow_back),onTap: iconClickEvent,),
                  hintText: "serech here...",


                  hintStyle: TextStyle(color: Colors.grey),
                ))

      );
    }
}