
 import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const noDataImage = "assets/yask.PNG";
 const String TOKEN ="130|hH1Cbhcb1wbI8FNYGf18mXd9pxExXUv9n1zOj0JQ";
 const String ACCEPT ="application/json";
 const String CONTENT_TYPE ="text/plain";
 const String BASE_URL ="https://shapi.webautobazaar.com/api/app-login";


   String formattedDate (timeStamp){

  final formattedStr =DateTime.now();
  // var dateFromTimeStamp =
  // DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  return DateFormat('yyyy-MM-dd').format(formattedStr);
 }