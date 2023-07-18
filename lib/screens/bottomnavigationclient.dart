

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../chat/chats/view/HomeChat.dart';
import '../home/view/homescreen.dart';
import '../reports/view/projects_reports_screen.dart';

class Bottomnavigationclient extends StatefulWidget  {
  @override
  State<Bottomnavigationclient> createState() => _BottomnavigationState();
}
class _BottomnavigationState extends State<Bottomnavigationclient> {
  String? tittle;
  int _curvedIndex = 0;
  List<Widget>bottomnavScreen = <Widget>[
    HomeScreen(),

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
          Icon(Icons.chat,size: 25,color: Colors.white,),
          Icon(Icons.event_note_outlined,size: 25,color:Colors.white,),],
        onTap: _changeItem,
        index: _curvedIndex,),
      body:


      IndexedStack(
        index: _curvedIndex,
        children: [
          HomeScreen(),
          HomeChat(),
          ReportsPorject(),
        ],
      ),

    );
  }


}