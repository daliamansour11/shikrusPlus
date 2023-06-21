import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanger/Authentication/login/view/Login.dart';
import 'package:taskmanger/screens/bottomnavigation.dart';

import '../core/SharedPreferenceInfo.dart';
import '../main.dart';
import 'package:google_fonts/google_fonts.dart';


class Splashscreen extends StatefulWidget{
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

   bool _isAnimate= false;
  @override
  void initState() {
    Future.delayed
      (Duration(milliseconds: 40),() async {
      checkLogedIn( context);
    });
    super.initState();
    Future.delayed(Duration(milliseconds: 500),(){
      setState(() {
        _isAnimate=true;
      });
    });
  }

 @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(title: Text('Welcome to You Chat'),),
      body:  Stack(children: [
        AnimatedPositioned(
        top: mq.height * .23,
        right:_isAnimate? mq.width * .25: -mq.width * .5,
        width: mq.width * .5,
        duration: Duration(milliseconds:1300 ),
             child: Image.asset('assets/NoData.jpg')),
          Positioned(
            bottom: mq.height * .35,
          width: mq.width,
          child: Text('Welcome to  Shikirs App ❤️',textAlign: TextAlign.center,
          style: GoogleFonts.balooBhai2(textStyle: TextStyle(fontSize: 30))),
          )

      ]),

    );
  }
 Future checkLogedIn( BuildContext context) async {
   await Future.delayed
     (Duration(seconds: 3), () async {
     SharedPreferences shared = await SharedPreferences.getInstance();
     final String? usertoken = shared.getString(
         '${SharedPreferencesInfo.userTokenKey}');
     if (usertoken != null &&
         usertoken != "") {

       print(
           "shhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh    ${usertoken}");

       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Bottomnavigation()));

     }
     else {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));

     }
   });
 }
}