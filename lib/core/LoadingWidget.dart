import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/task.jpg"),
          Text("loading",style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppColors.defaultDateColor),)
        ],
      ),);
  }
}