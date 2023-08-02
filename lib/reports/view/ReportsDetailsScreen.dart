import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

import '../../core/Constants.dart';
import '../../widgets/TextFieldWidget.dart';

class ReportsDetailsScreen extends ConsumerStatefulWidget {
  String report;
  String reason;
  String rate;
  String image;
  String project_id;
  String user_id;
  DateTime created_At;
  DateTime updated_At;
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
    double rat=0.0;


    if(widget.rate==null||widget.rate=="null"){
      rat=0.0;
    }
    else{
      rat=  double.parse(widget.rate??"${0.0}")/100.0;
    }

    // double percentage;
    // final rate =  double.parse("${widget.rate}");
    // percentage =  rate/100;
    // finalD = (percentage*100).toString();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF005373),
        title:TextFieldHeaderWidget(title: "Report Details",colors: Colors.white,),
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
                      TextFieldTitleWidget(title: "Report Name",fontWeight: FontWeight.bold,),
                      SizedBox(height: 14.h,),
                      TextFieldTitle2Widget(title: widget.report,),
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
                                          child:TextFieldTitleWidget(title: "Updated At",fontWeight: FontWeight.bold,colors: Colors.grey,),


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
                                        TextFieldTitle2Widget(
                                            title:formattedDate(widget.updated_At),
                                            fontWeight: FontWeight.bold, size: 12.sp,
                                            colors:  Color(0xFF005373)
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
                                          child: TextFieldTitleWidget(
                                            title: "Created At",
                                              fontWeight: FontWeight.bold,

                                                colors: Colors.grey
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
                                        TextFieldTitle2Widget(title:
                                          formattedDate(widget.created_At),

                                              fontWeight: FontWeight.bold,
                                              size: 12.sp,
                                              colors:  Color(0xFF005373),
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
                      TextFieldTitleWidget(
                       title: "Report Reason",
                      fontWeight: FontWeight.w600),

                      SizedBox(height: 15.h,),
                      TextFieldTitle2Widget(
                       title: widget.reason,


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
                      child: TextFieldTitleWidget(title:
                        "Attachments",
                       fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:  Color(0xFF005373),
                      ),
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: widget.image ==""
                            ? Image.asset("assets/reporr.png",fit: BoxFit.fill,)
                            : Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                        ),
                      ))
                ]),
             SizedBox(height: 10.h,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar.builder(
                    itemSize: 30,
                    // itemPadding:
                    //     EdgeInsets.all(20),
                    minRating:widget.rate=="null"?0.2: rat,
                    itemBuilder: (context, _) {
                      return Icon(
                        Icons.star,
                        color: Color(0xFF005373),
                      );
                    }, onRatingUpdate: (double value) {
                      value=.2;
                  },
                    // onRatingUpdate: (double value) {
                    //   setState(() {
                    //     rate = value;
                    //   });
                    // },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
