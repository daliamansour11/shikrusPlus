import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldHeaderWidget extends StatelessWidget{

 final String title;
  final double size;
 final Color colors;
 final FontWeight fontWeight;
  TextFieldHeaderWidget({ this.title="",this.size=20,this.colors=Colors.black,this.fontWeight=FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: size.sp, color: colors),
    );
  }
}

class TextFieldTitleWidget extends StatelessWidget{

  final String title;
  final double size;
  final Color colors;
  final FontWeight fontWeight;
  TextFieldTitleWidget({ this.title="",this.size=14,this.colors=Colors.black,this.fontWeight=FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: size.sp, color: colors,fontWeight: fontWeight),
    );
  }
}
class TextFieldTittleWidget extends StatelessWidget{

  final String title;
  final double size;
  final Color? colors;
  final FontWeight fontWeight;
  TextFieldTittleWidget({ this.title="",this.size=14,this.colors,this.fontWeight=FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: size.sp, color: colors,fontWeight: fontWeight),
    );
  }
}
class TextFieldTitle2Widget extends StatelessWidget{

  final String title;
  final double size;
  final Color colors;
  final FontWeight fontWeight;
  TextFieldTitle2Widget({ this.title="",this.size=15,this.colors=Colors.black,this.fontWeight=FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: size.sp, color: colors,fontWeight: fontWeight),
    );
  }
}