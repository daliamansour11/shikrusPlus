
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

import '../../core/Constants.dart';



class ReportsDetailsScreen extends ConsumerStatefulWidget{
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
  ConsumerState<ReportsDetailsScreen> createState() => _ReportsDetailsScreenState();
}
class _ReportsDetailsScreenState extends ConsumerState<ReportsDetailsScreen> {
  String? isEmpty  ;
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
          title: Text("Report Details",style:
          TextStyle( fontSize: 25,color:  Colors.white
          ),),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                         Padding(
                              padding: const EdgeInsets.only(left: 8.0,top: 10),
                              child: Text(widget.report,
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                            ),
                                 ),   SizedBox(height: 30,),


                      Row(
                        children: [


                          Padding(
                            padding: const EdgeInsets.all( 15.0),
                            child: Container(
                              height: 130,
                              width: 170,
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
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Updated At",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(width: 20,),
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.blue,
                                                child: Icon(
                                                  Icons.calendar_today_rounded,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            formattedDate(widget.created_At),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Colors.indigo[500]),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                    ],
                                  ),


                                ),

                              ),
                            ),
                          ),

                          SizedBox(width: 4,),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 130,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Created At",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(width: 20,),
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.blue,
                                              child: Icon(
                                                Icons.calendar_today_rounded,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          formattedDate( widget.updated_At),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              color: Colors.indigo[500]),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10,),


                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                                 Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.reason,
                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),

                           ),
              SizedBox(height: 10,),

                      Container(child: Text("Attachments",style: TextStyle( fontSize: 20,fontWeight: FontWeight.bold),)),
                      SizedBox(height: 10,),
                 Container(

                  height: MediaQuery.of(context).size.height/4,
                  margin: EdgeInsets.all( 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[300],

                            ),

                  child: Column(

                    children: [
                      Container(
                          margin: EdgeInsets.all( 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[300],

                          ),
                          height: MediaQuery.of(context).size.height/5,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: isEmpty == "" ?
                            Image.network("assets/NoData.jpg"):Image.network(widget.image ,fit:BoxFit.cover,),
                          ))
                     ] ),




                 ),


                    Column(
                      children: [
                        Container(
                            child:
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 6.0, right: 39, top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Progress",
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 17,fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 95.0),
                                    child: Text(
                                      "${widget.rate}%"??
                                          " ",
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                         fontSize: 17,fontWeight: FontWeight.w700),
                                    ),
                                  ),


                                ],
                              ),
                            )

                        ),
                        SizedBox(height: 10,),
                        LinearPercentIndicator(
                            width: 360.0,
                            lineHeight: 8.0,
                            percent: 0.45,
                            progressColor: Colors.blue,
                            linearStrokeCap:
                            LinearStrokeCap.round

                        ),
                      ],
                    )
                    ],
                  ),

                ),



        );
  }




}






