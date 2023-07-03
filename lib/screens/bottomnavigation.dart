
import 'package:taskmanger/AddNewTask/view/Addtask.dart';
import 'package:taskmanger/home/view/homescreen.dart';
import 'package:taskmanger/reports/view/projects_reports_screen.dart';
import '../chat/chats/view/HomeChat.dart';
import '../../clender/view/ClenderScreen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../clender/model/TasksModel.dart';

class Bottomnavigation extends StatefulWidget  {

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}
class _BottomnavigationState extends State<Bottomnavigation> {
  String? tittle;
  int _curvedIndex = 0;

  List<Widget>bottomnavScreen = <Widget>[
    HomeScreen(),
    Calendarpage(),
     AddTaskScreen(project_id:1 , ),
    HomeChat(),
    ReportsPorject(),
  ];
  void _changeItem(int value) {
    print(value);
    setState(() {
      _curvedIndex = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Color(0xFF005373),
        backgroundColor: Color(0xFFE2DFDF),
        color: Color(0xFF005373),
        height: 60,
        items: [
          Icon(Icons.home,size: 25,color: Colors.white,),
          Icon(Icons.calendar_today_rounded,size: 25,color: Colors.white),
           Icon(Icons.add_circle,size: 38,color: Colors.white,),
          Icon(Icons.chat,size: 25,color: Colors.white,),
          Icon(Icons.event_note_outlined,size: 25,color:Colors.white,),],
        onTap: _changeItem,
        index: _curvedIndex,),
      body:


      IndexedStack(
        index: _curvedIndex,
        children: [
          HomeScreen(),
          Calendarpage(),
          AddTaskScreen(project_id:1 , ),
          HomeChat(),
          ReportsPorject(),
        ],
      ),

    );
  }


}






















// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:tasksapp/shikrsplus/presentation/chat/screens/detailsscreen.dart';
// import 'package:tasksapp/shikrsplus/presentation/chat/screens/profile.dart';
//
// import 'Addtask.dart';
// import 'HomeChat.dart';
// import 'homescreen.dart';
// import 'no
// tification.dart';
//
// class Bottomnavigation extends StatefulWidget{
//   @override
//   State<Bottomnavigation> createState() => _BottomnavigationState();
// }
//
// class _BottomnavigationState extends State<Bottomnavigation> {
//   final screens=[
//     HomeScreen(),
//     Chatscreen(),
//     AddTaskScreen(),
//     Notificationscreen(),
//     Profilescreen()
//   ];
//   int index=0;
//   final navigationkey=GlobalKey<CurvedNavigationBarState>();
//   @override
//   Widget build(BuildContext context) {
//     final items=<Widget>[
//       Icon(Icons.home,size: 30,),
//       Icon(Icons.chat,size: 30,),
//       Icon(Icons.add,size: 30,),
//       Icon(Icons.calendar_today_rounded,size: 30,),
//       Icon(Icons.person,size: 30,),
//     ];
//     return SafeArea(
//       top: false,
//       child: ClipRect(
//         child: Scaffold(
//           body:screens[index] ,
//           bottomNavigationBar: Theme(
//             data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Colors.white)),
//             child: CurvedNavigationBar(
//               key: navigationkey,
//               animationCurve: Curves.easeInOut,
//               animationDuration: Duration(milliseconds: 300),
//               //  backgroundColor: Colors.red,
//               color: Colors.black38,
//               //  buttonBackgroundColor: Colors.blue,
//               items: items,
//               index: index,
//               height: 60,
//               onTap: (index){this.index=index;},),
//           ),
//         ),
//       ),
//     );
//   }
// }