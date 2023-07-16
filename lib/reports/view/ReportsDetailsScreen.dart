import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

import '../../core/Constants.dart';

class ReportsDetailsScreen extends ConsumerStatefulWidget {
  String report;
  String reason;
  String rate;
  String image;
  String project_id;
  String user_id;
  String created_At;
  String updated_At;
  String project_name;

  ReportsDetailsScreen({
    required this.report,
    required this.reason,
    required this.rate,
    required this.image,
    required this.project_id,
    required this.user_id,
    required this.created_At,
    required this.updated_At,
    required this.project_name,
  });

  @override
  ConsumerState<ReportsDetailsScreen> createState() =>
      _ReportsDetailsScreenState();
}

class _ReportsDetailsScreenState extends ConsumerState<ReportsDetailsScreen> {
  String? isEmpty;

  @override
  Widget build(BuildContext context) {
    String finalD = '';
    // double percentage;
    // final rate =  double.parse("${widget.rate}");
    // percentage =  rate/100;
    // finalD = (percentage*100).toString();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF005373),
        title: Text(
          "Report Details",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Report Name",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                      SizedBox(height: 14.h,),
                      Text(
                        widget.report,
                        style:
                        TextStyle( fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 100.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "Updated At",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        CircleAvatar(
                                          radius: 16.sp,
                                          backgroundColor:  Color(0xFF005373),
                                          child: Icon(
                                            Icons.calendar_today_outlined,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          formattedDate(widget.created_At),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                              color:  Color(0xFF005373)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 100.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "Created At",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        CircleAvatar(
                                          radius: 16.sp,
                                          backgroundColor: Color(0xFF005373),
                                          child: Icon(
                                            Icons.calendar_today_outlined,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          formattedDate(widget.created_At),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                              color:  Color(0xFF005373)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Report Reason",
                        style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 15.h,),
                      Text(
                        widget.reason,
                        style:
                        TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                      child: Text(
                        "Attachments",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(children: [
                  Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:  Color(0xFF005373),
                      ),
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: isEmpty == ""
                            ? Image.network("assets/NoData.jpg")
                            : Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                        ),
                      ))
                ]),
                Column(
                  children: [
                    Container(
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0, right: 39, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress",
                                style: TextStyle(

                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 95.0),
                                child: Text(
                                  "${widget.rate}%" ?? " ",
                                  style: TextStyle(
                                      color:  Color(0xFF005373),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    LinearPercentIndicator(
                        width: 360.0,
                        lineHeight: 8.0,
                        percent: 0.45,
                        progressColor:  Color(0xFF005373),
                        linearStrokeCap: LinearStrokeCap.round),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
