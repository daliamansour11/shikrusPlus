import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDate {
  // for getting formatted send & receive time of msgs
  static String getFormattedtime({required BuildContext context,required DateTime time}){
    // final date=DateTime.fromMicrosecondsSinceEpoch(int.parse(time !=null?time:""));
    // print(time);
    return TimeOfDay.fromDateTime(time).format(context);

  }
  // to get last msg send time
  static String getLastMsgTime({required BuildContext
  context,required DateTime time,bool showyear=false}){
   // final DateTime sent=DateTime.parse(time);
    final DateTime now=DateTime.now();

    if(now.day==time.day && now.month==time.month && now.year==time.year){
      return TimeOfDay.fromDateTime(time).format(context);
    }

    return showyear?'${time.day} ${_getMonth(time)} ${time.year}':'${time.day} ${_getMonth(time)}';
  }


  ///////////message time///////////////


  static String readTimestamp(String timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('KK:mm' ' ' 'a');
    var date = DateTime.parse(timestamp);
    var diff = date.difference(now);
    var time = '';

    if (diff.inDays == 1) {
      time = (diff.inDays / 360).toString() + 'DAY AGO';
    } else {
      time = (diff.inDays / 360).toString() + 'DAYS AGO';
    }
    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    }

    return time;
  }
  // for getting formatted time for sent & read
  static String getMessageTime(
      {required BuildContext context, required String time}) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    final formattedTime = TimeOfDay.fromDateTime(sent).format(context);
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return formattedTime;
    }

    return now.year == sent.year
        ? '$formattedTime - ${sent.day} ${_getMonth(sent)}'
        : '$formattedTime - ${sent.day} ${_getMonth(sent)} ${sent.year}';
  }
  static String getMessageTimepersonalchat(
      {required BuildContext context, required DateTime time}) {
 //   final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    final formattedTime = TimeOfDay.fromDateTime(time).format(context);
    if (now.day == time.day &&
        now.month == time.month &&
        now.year == time.year) {
      return formattedTime;
    }

    return now.year == time.year
        ? '$formattedTime - ${time.day} ${_getMonth(time)}'
        : '$formattedTime - ${time.day} ${_getMonth(time)} ${time.year}';
  }
  //get formatted last active time of user
  static String getLastActiveTime(
      {required BuildContext context, required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;

    //if time is not available then return below statement
    if (i == -1) return 'Last seen not available';

    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    String formattedTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == time.year) {
      return 'Last seen today at $formattedTime';
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return 'Last seen yesterday at $formattedTime';
    }

    String month = _getMonth(time);

    return 'Last seen on ${time.day} $month on $formattedTime';
  }

  // get month name from month no. or index
  static String _getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sept';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return 'NA';
  }
}

