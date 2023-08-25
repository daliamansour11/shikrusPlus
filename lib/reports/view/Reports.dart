import 'dart:math';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taskmanger/core/utils.dart';
import 'package:taskmanger/reports/view/ReportsDetailsScreen.dart';

import '../../home/provider/ProjectInfoProvider.dart';
import '../provider/ReportsProvider.dart';
import 'AddNewReports.dart';

class Reports extends ConsumerStatefulWidget {
  String report;
  String reason;
  String image;
  int id;

  Reports({
    required this.report,
    required this.reason,
    required this.image,
    required this.id,
  });

  @override
  ConsumerState<Reports> createState() => _ReportsState();
}

class _ReportsState extends ConsumerState<Reports> {
  bool? emptyPercent;

  String? emptyimage;

  double ratting = .01;

  @override
  Widget build(BuildContext context) {
    final reports = ref.watch(reportProvider);
    return Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('idddddddddddddddddddd${widget.id}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNewReportsScreen(
                          project_id: widget.id,
                        )));
          },
          backgroundColor: Color(0xFF005373),
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF005373),
          title: Text("Reports",
              style: TextStyle(
                fontSize: 20.sp,
              )),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ref.watch(ProjectinfoProvider(widget.id)).when(
                data: (data) => ListView.separated(
                    itemBuilder: (context, index) {
                      double rate=0.0;
                      if(data.data.reports[index].rate !=null){
                       rate =double.parse(data.data.reports[index].rate??"")??0.0;
                      }else{rate=0.0;}

                      // rate =  ("${rate!/100}")!;
                      rate=rate/100;
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportsDetailsScreen(
                                        report: '${data.data.reports[index].report}',
                                        reason: '${data.data.reports[index].reason}',
                                        rate: '${data.data.reports[index].rate}',
                                        image: '${data.data.reports[index].image}',
                                        project_id:
                                            '${data.data.reports[index].projectId}',
                                        user_id: '${data.data.reports[index].userId}',
                                        created_At:
                                            data.data.reports[index].createdAt,
                                        updated_At: data.data.reports[index].updatedAt,
                                        project_name:
                                            '${data.data.nameEn}',
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: 7.h, top: 5.h, left: 7.w, right: 7.w),
                          height: MediaQuery.of(context).size.height/6,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              "${data.data.reports[index].report}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              "${data.data.reports[index].reason}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),

                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [


                                                RatingBar.builder(
                                                  itemSize: 30,
                                                  // itemPadding:
                                                  //     EdgeInsets.all(20),
                                                  minRating: rate,
                                                  itemBuilder: (context, _) {
                                                    return Icon(
                                                      Icons.star,
                                                      color: Color(0xFF005373),
                                                    );
                                                  },
                                                  onRatingUpdate: (double value) {
                                                    setState(() {
                                                      rate = value;
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    data.data.reports[index].image !=null?CircleAvatar(backgroundImage: NetworkImage(data.data.reports[index].image),):  CircleAvatar(backgroundImage: AssetImage("assets/reporr.png",),radius: 25.sp,)
                                ],)
                              ],
                            ),
                          ),
                        ),
                      );},
                    //},
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: double.infinity,
                          height: 1.h,
                        ),
                      );
                    },
                    itemCount: data.data.reports.length),
                error: (err, _) => Text(
                      "$err",
                      style: TextStyle(color: Colors.red),
                    ),
                loading: () => Center(child: CircularProgressIndicator()))));
  }

  checkNullProgress(double value) {
    if (value != null && value != 0) {
      return value;
    } else {
      value = 10.0;
    }
  }
}
