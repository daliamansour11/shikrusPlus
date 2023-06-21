import 'package:flutter/material.dart';



class ContainerWidget extends StatelessWidget{

  final EdgeInsets? margin ;
  final double? width ;
  final double? height ;
  final BoxDecoration?decoration ;
  // final String?hintText ;
  final Color?color ;
  final double?borderRadius ;
  final VoidCallback isClickEvent;

  const ContainerWidget({
    Key? key,
    this.margin,
    this.width,
    this.borderRadius=10,
    this.decoration,
    this.height,
    this.color,
    required this.isClickEvent(), required ListView child,

  });






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 4,left: 5,right: 5,top: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
    borderRadius: BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
          // boxShadow:[
          //   BoxShadow(
          //       color: Colors.black.withOpacity(.2),
          //       blurRadius: 2,
          //       spreadRadius: 1,
          //       offset: Offset(0,0.50)
          //   )],),

      ))),
    );
  }
}
