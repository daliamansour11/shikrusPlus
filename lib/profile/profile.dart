import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanger/Authentication/login/view/Login.dart';
import 'package:taskmanger/core/SharedPreferenceInfo.dart';

import 'EditProfileScreen.dart';

class Profilescreen extends StatefulWidget {
  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEDED),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Color(0xFF005373),


        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0,left: 57),
              child: Center(
                child: Text("Profile", style: TextStyle(
                     fontSize: 25, color: Colors.white),),
              ),
            ),

        Padding(
          padding: const EdgeInsets.only(left: 100.0,right: 5),
          child: Icon(Icons.more_horiz,size: 20,color: Colors.black,),
        ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
            SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Row(
              children: [
            Center(
            child:Container (
            height:500,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 70,right: 30),
                    child: Container(

                     child:   CircleAvatar(
                          radius: 58,
                          backgroundImage: AssetImage("assets/personn.jpg"),
                          child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Color(0xFF775FAF),
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ]
                          ),
                        )

                    ),
                  ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70.0,right: 45),
              child: Text(
                "John Smith",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70.0,right: 45),
              child: Text(
                "UX/UI",
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 46.0,right: 10),
                  child: InkWell(
                    onTap: () async{
                      SharedPreferences prefrences = await SharedPreferences.getInstance();
                      await prefrences.remove(SharedPreferencesInfo.userTokenKey);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                    child: Container(
                      height: 60,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Color(0xFF005373),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 45,
                          ),

                          Center(
                            child: Text(
                              "Log out",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),


                ],
              ),
            )
            ),
          ]),
        ),
      ]),
    )));
  }
}