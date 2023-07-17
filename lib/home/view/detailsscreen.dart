import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:taskmanger/widgets/TextFieldWidget.dart';

import '../../core/Constants.dart';


class Detailsscreen extends StatefulWidget {

  String name;
  String subject;
  String notes;
  String startDate;
  String endDate;
  String status;
  Detailsscreen({
    required this.name,
    required this.subject,
    required this.notes,
    required this.startDate,
    required this.endDate,
    required this.status,
});
  @override
  State<Detailsscreen> createState() => _DetailsscreenState();

}
class _DetailsscreenState extends State<Detailsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF005373),
        title: TextFieldHeaderWidget(title: "Details",colors: Colors.white,),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 7.h),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldTitleWidget(
                     title: "${widget.name}",
                          fontWeight: FontWeight.bold,
                          size: 15.sp,
                          colors: Color(0xFF005373)),
                    SizedBox(
                      height: 6.h,
                    ),
                    TextFieldTitle2Widget(
                     title: widget.subject,),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/personn.jpg",
                          ),
                          radius: 10.sp,
                          backgroundColor: Colors.white60,
                        ),
                        CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/ppr.jpg",
                            ),
                            radius: 10.sp,
                            backgroundColor: Colors.white60),
                        CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/personn.jpg",
                            ),
                            radius: 10.sp,
                            backgroundColor: Colors.white60),
                        CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/ppr.jpg",
                            ),
                            radius: 10.sp,
                            backgroundColor: Colors.white60),
                        CircleAvatar(
                          backgroundColor: Colors.indigo[3],
                          child: TextFieldTitle2Widget(
                            title: "+3",
                            colors: Colors.white,fontWeight: FontWeight.normal,size: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 40,
                      animation: true,
                      animationDuration: 1000,
                      lineWidth: 10,
                      percent: .7,
                      progressColor: Color(0xFF005373),
                      backgroundColor: Colors.blue.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: TextFieldTitleWidget(
                        title: "70%",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ]),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFieldTitleWidget(
                        title:"Description",
                            fontWeight: FontWeight.bold,
                            size: 15.sp,
                            colors:Color(0xFF005373)),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  TextFieldTitleWidget(
                    title:widget.notes,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),

              SizedBox(
                height: 15.sp,
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 100.h,
                        width: 130.w,
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
                                          child:TextFieldTitleWidget(title: "Due Date",fontWeight: FontWeight.bold,colors: Colors.grey,),


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
                                        TextFieldTitle2Widget(title:formattedDate(widget.startDate),
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

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 100.h,
                        width: 130.w,
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
                                          child:TextFieldTitleWidget(title: "Due Date",fontWeight: FontWeight.bold,colors: Colors.grey,),


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
                                        TextFieldTitle2Widget(title:formattedDate(widget.endDate),
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


                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFieldTitleWidget(
                    fontWeight: FontWeight.bold,
                    title:"List of Tasks",
                        size: 15.sp,
                        colors:Color(0xFF005373),),
                ],
              ),
              // Expanded(
              //   child: ListView.builder(
              //       shrinkWrap: true,
              //       itemCount: 5,
              //       itemBuilder: (context, index) {
              //         return Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 5.0),
              //           child: Card(
              //             child: Container(
              //               height: 80,
              //               decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   borderRadius: BorderRadius.circular(30)),
              //               child: Padding(
              //                 padding:
              //                     const EdgeInsets.only(left: 10.0, right: 10),
              //                 child: Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   // crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: [
              //                     CircularPercentIndicator(
              //                       radius: 30,
              //                       animation: true,
              //                       animationDuration: 1000,
              //                       lineWidth: 5,
              //                       percent: .7,
              //                       progressColor: Colors.blue,
              //                       backgroundColor: Colors.blue.shade100,
              //                       circularStrokeCap: CircularStrokeCap.round,
              //                       center: Text(
              //                         "70%",
              //                         style: TextStyle(fontSize: 15),
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 20,
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.only(top: 15.0),
              //                       child: Column(
              //                         children: [
              //                           Text(
              //                             "looking for refernces",
              //                             style: TextStyle(
              //                                 color: Colors.indigo,
              //                                 fontSize: 20,
              //                                 fontWeight: FontWeight.bold),
              //                           ),
              //                           SizedBox(
              //                             height: 10,
              //                           ),
              //                           Text(
              //                             "4 Feb 2022",
              //                             style: TextStyle(
              //                               color: Colors.grey,
              //                               fontSize: 15,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Icon(Icons.power_input_outlined)
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //       }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
