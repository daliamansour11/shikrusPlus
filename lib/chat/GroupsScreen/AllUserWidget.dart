import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/chat/GroupsScreen/CreateNewGroup.dart';
import 'package:taskmanger/chat/chats/view/HomeChat.dart';
import 'package:taskmanger/core/utils.dart';
import '../chats/api/apis.dart';
import '../../main.dart';
import '../../profile/profile.dart';
import '../chats/chat_provider/ChatProvider.dart';
import '../chats/model/UsersModel.dart';
import '../chats/view/ChatScreen.dart';
import '../chats/view/SearchUser.dart';
import '../services/database_service.dart';


class AllUsersScreen extends ConsumerStatefulWidget {
  String groupName;
  bool isSelected ;

  AllUsersScreen({
    required this.groupName,
    this.isSelected=false,
  });
  @override
  ConsumerState<AllUsersScreen> createState() => _AllUsersScreenState();
}
List<UserData> _userList=[];
UserData _userData=UserData();

late TextEditingController searchTextController = TextEditingController();
bool _isSearch =false;
class _AllUsersScreenState extends ConsumerState<AllUsersScreen> {
  existsInselectedUsersList(UserData usersModel) => selectedUsersList.contains(usersModel);
  List<UserData> selectedUsersList = [];
  UserData user = UserData();

  List<bool> selectedItem  = [];
  Widget _emptyContainer(){
    return Container(
      height: 0,width: 0,
    );
  }
  var mycolor=Colors.white;

  var isSelected = false;
  List<UserData> searchlist = [];
  void toggleSelection() {
    setState(() {
      if (isSelected) {
        mycolor=Colors.white;
        isSelected = false;
      } else {
        mycolor=Colors.grey[300]!;
        isSelected = true;
      }
    });
  }


//   void onResultTap(){
//     bool isAlreadyExist = false;
//     for(int i =0;i<selectedUsersList.length;i++){
// if(_userList[i].id== selectedUsersList[i].id){
//   isAlreadyExist= true;
// }
// if(!isAlreadyExist){
//   _userList.add(selectedUsersList[i]);}}
//   }
  List<UserData> selectedmember=[];
  @override
  Widget build(BuildContext context) {
    final usersList = ref.watch(ListOfUsersProvider);
    return
      Scaffold(
          appBar: selectedUsersList.isEmpty
              ? AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: _isSearch == true ? Colors.transparent : Color(
                0xFF005373),
            title: _isSearch == true ? _emptyContainer() :
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Center(
                  child: Text("Users",
                    style: TextStyle(fontSize: 25,
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            centerTitle: true,
            flexibleSpace: _isSearch == true
                ? _buildSearchWidget(context)
                : _emptyContainer(),
            // leading:
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  SearchUser()));
                },
                icon: Icon(Icons.search_sharp),
              )
            ],
            leading: _isSearch == true ? Visibility( // hiding the child widget
              visible: false, child: Center(),
            )
                : Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 4),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profilescreen()));
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/personn.jpg",
                  ),
                  radius: 20,
                ),
              ),
            ),
          )
              : AppBar(
            backgroundColor: Colors.grey.shade800,
            leading: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  selectedUsersList.clear();
                });
              },
            ),
            title: Text(selectedUsersList.length.toString()),
            actions: <Widget>[
              selectedUsersList.length < 2
                  ? Container()
                  : InkWell(
                  onTap: () {
                    int i ;
                    setState(() {
                      for (i=0 ; i < _userList.length; i++) {
                        if (selectedUsersList.contains(_userList[i])) {
                          selectedmember.add(selectedUsersList[i]);}}

                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>CreateNewGroup(member: selectedUsersList)));
                    });},
                  child: const Icon(Icons.check))],),
          body:  RefreshIndicator(
            backgroundColor: context.appTheme.bottomAppBarColor,
            onRefresh: ()  async{
              print("we are hereeeeeeeeeeeeeeeee222222222222222200002111111100${ref.read(AllUserProvider).getAllUsers()}");
              var data1= ref.refresh(AllUserProvider).getAllUsers();
              print("we are hereeeeeeeeeeeeeeeee2222222222222222000000data1${data1}");//

              return Future.delayed(Duration(milliseconds: 300) , () =>   ref.read(AllUserProvider.notifier).getAllUsers());
            },
            child:ListView(
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(height: 30),
                usersList.when(data: (data) =>  ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.data.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 3),
                  itemBuilder: (BuildContext context, int index) {


                    return
                      UserCard(
                        name: "${data.data[index].name}",
                        isSelected: existsInselectedUsersList(data.data[index]),
                        selectedUsersList: selectedUsersList,


                        onTap: () {

                          Apis. addChatUser("${data.data[index].email}");
                          Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (context) => ChatScreen(user: _userData, userId: '${data.data[index].id}',
                                  userImage: '${data.data[index].image}', UserName: '${data.data[index].name} ',
                                ),
                              ));

                        },
                        onSave: () {
                          // selectedUsersList.add(userSelected);
                          setState(() {
                            if (isSelected) {
                              mycolor=Colors.white;

                              isSelected = false;
                            } else {

                              selectedUsersList.add(data.data[index]);

                              isSelected = true;
                            }
                          });
                        }, imgUrl: '${data.data[index].image}', subTitle: '${data.data[index].type}',


                      );},
                ), error: (err, _) => Text("$err"), loading:
                    () => Center(child: CircularProgressIndicator(),)),
              ],
            ),
          ));

  }
  Widget _buildSearchWidget(BuildContext context) {
    // final userList = ref.read(AllUserProvider);
    return Container(
        margin: EdgeInsets.only(top: 35),
        // height: 80,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 0.50)
            )
          ],),
        child:
        TextField(
            controller: searchTextController,
            onChanged: (val) {
              // searchTextController.clear();

              // userList.getAllUsers();
              // String searchText = '';
              // searchText = val;
              // if (val.isEmpty) {
              //   _searchList.addAll(_userlist);
              // } else {
              //   _userlist.addAll(_userlist.where((element) =>
              //       element.toLowerCase().contains(val)).toList());
              // }
              // setState(() {
              // _searchList;
              // });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: InkWell(child: Icon(Icons.arrow_back),
                onTap: () {
                  setState(() {
                    _isSearch = !_isSearch;
                  });
                  searchTextController.clear();
                },
              ),
              hintText:"serech here...",
              hintStyle: TextStyle(color: Colors.grey),
            ))
    );
  }

}



class UserCard extends StatelessWidget {
  final String name;
  final String subTitle;
  final String imgUrl;
  final bool isSelected;
  final void Function()? onSave;
  final void Function()? onTap;
  final List selectedUsersList;

  const UserCard(
      {Key? key,
        required this.name,
        required this.subTitle,
        required this.imgUrl,
        required this.isSelected,
        this.onSave,
        this.onTap,
        required this.selectedUsersList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: mq.width * .01, vertical: 1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)),
        elevation: 2,
        surfaceTintColor: isSelected ? Colors.black : null,
        color: Colors.blueGrey,
        child: ListTile(
          dense: true,
          selected: isSelected,
          onTap: selectedUsersList.isNotEmpty ? onSave : onTap,
          onLongPress: onSave,
          tileColor: Colors.grey[300],
          selectedColor: Colors.white,
          selectedTileColor: Colors.cyan.shade900,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .3),
            child: CachedNetworkImage(
              width: mq.height * .050,
              height: mq.height * .050,
              // imageUrl: groupModel!.groupImage??"",
              errorWidget: (context, url, error) =>
                  CircleAvatar(
                    child: Icon(CupertinoIcons.person),
                  ),
              imageUrl: imgUrl,
            ),
          ),
          title: Text(name),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.cyan.shade50,
                  width: 3,
                  style: isSelected ? BorderStyle.solid : BorderStyle.none)),
          subtitle: Text(subTitle),
        ),
      ),
    );
  }
}