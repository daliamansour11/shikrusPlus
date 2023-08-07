import 'dart:math';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taskmanger/core/utils.dart';
import 'package:taskmanger/reports/view/ReportsDetailsScreen.dart';

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
          title: Text("Report",
              style: TextStyle(
                fontSize: 20.sp,
              )),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: RefreshIndicator(
          backgroundColor: context.appTheme.bottomAppBarColor,
          onRefresh: () async {
            ref.refresh(reportProvider.future);

            print("updted");
            return Future.delayed(Duration(milliseconds: 300),
                () => ref.read(reportProvider.future));
          },
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: reports.when(
                  data: (data) => ListView.separated(
                      itemBuilder: (context, index) {
                      double rate=  double.parse(data.data[index].rate??"${0.0}")/100.0;
                        String finalD = '';
                        double percentage;
                        var progress = data.data[index].rate;
                        checkNullProgress(String value) {
                          if (progress != null && progress != "") {
                            double rate = double.parse('${progress}');
                            percentage = rate / 100;
                            print("percentageeeeeeeeeeeeee$percentage");
                          } else {
                            print("Null value");
                          }
                        }
                        //  Here you get your percentage and the assign it to the percentage

                        // finalD = (percentage*100).toString();
                        //
                        // checkNullProgress(percentage);

                        // rate =  ("${rate!/100}")!;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportsDetailsScreen(
                                          report: '${data.data[index].report}',
                                          reason: '${data.data[index].reason}',
                                          rate: '${data.data[index].rate}',
                                          image: '${data.data[index].image}',
                                          project_id:
                                              '${data.data[index].projectId}',
                                          user_id: '${data.data[index].userId}',
                                          created_At:
                                              data.data[index].createdAt,
                                          updated_At: data.data[index].updatedAt,
                                          project_name:
                                              '${data.data[index].project.nameEn}',
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: 7.h, top: 5.h, left: 7.w, right: 7.w),
                            height: 110.h,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              "${data.data[index].report}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              "${data.data[index].reason}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      Padding(
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
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                    CircleAvatar(backgroundImage: AssetImage("assets/reporr.png",),radius: 25.sp,)
                                  ],)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            width: double.infinity,
                            height: 1.h,
                          ),
                        );
                      },
                      itemCount: data.data.length),
                  error: (err, _) => Text(
                        "$err",
                        style: TextStyle(color: Colors.red),
                      ),
                  loading: () => Center(child: CircularProgressIndicator()))),
        ));
  }

  checkNullProgress(double value) {
    if (value != null && value != 0) {
      return value;
    } else {
      value = 10.0;
    }
  }
}
