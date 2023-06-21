import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';
class NoDataPlaceHolder extends StatelessWidget {
  final Widget? widget;
  final String? img;
  final String? text;
  const NoDataPlaceHolder({Key? key, this.widget, this.img, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget??SvgIcons.NoDataIcon(),
        const SizedBox(height: 9,),
         Text("no_data"),
      ],
    ),);
  }
}


class SvgIcons {
  static Widget NoDataIcon() {
    return SvgPicture.asset(
      noDataImage,
      color: Color(0xFF005373),
      width: 40,
      height: 40,
    );
  }
}

