import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class testt extends StatefulWidget{
  @override
  State<testt> createState() => _testtState();
}

class _testtState extends State<testt> {
  List <dynamic>list=[];
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('usersid')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading");
              }
              var userDocument = snapshot.data?.docs[0]["ids"];
              list.add(userDocument);
              return Center(child: new Text("${list??"klkl"}",style: TextStyle(color: Colors.black),));

            }
        ),
      ),
    );
  }
}