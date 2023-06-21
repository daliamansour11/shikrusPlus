import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
        title: Text("Details",style: TextStyle(fontSize: 25),),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [



              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  children: [
                    Text(
                      "${widget.name}",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.subject,
                      style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/personn.jpg",
                          ),
                          radius: 20,
                          backgroundColor: Colors.white60,
                        ),
                        CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/ppr.jpg",
                            ),
                            radius: 20,
                            backgroundColor: Colors.white60),
                        CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/personn.jpg",
                            ),
                            radius: 20,
                            backgroundColor: Colors.white60),
                        CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/ppr.jpg",
                            ),
                            radius: 20,
                            backgroundColor: Colors.white60),
                        CircleAvatar(
                          backgroundColor: Colors.indigo[3],
                          child: Text(
                            "+3",
                            style: TextStyle(color: Colors.white),
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
                      progressColor: Colors.blue,
                      backgroundColor: Colors.blue.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        "70%",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ]),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.indigo),
                  ),
                  Text(
                    "Edit description",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Container(
                        height: 130,
                        width: 200,
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
                                          "Due Date",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(width: 10,),

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
                                      formattedDate(widget.startDate),
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
                  ),
                  SizedBox(width: 4,),
                   Expanded(
                     flex: 1,
                     child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 130,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:  Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Due Date",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(width: 5,),
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
                                        formattedDate( widget.endDate),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.indigo[500]),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Column(
                                    children: [

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),


                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "List of Activities",
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Card(
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularPercentIndicator(
                                    radius: 30,
                                    animation: true,
                                    animationDuration: 1000,
                                    lineWidth: 5,
                                    percent: .7,
                                    progressColor: Colors.blue,
                                    backgroundColor: Colors.blue.shade100,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    center: Text(
                                      "70%",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "looking for refernces",
                                          style: TextStyle(
                                              color: Colors.indigo,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "4 Feb 2022",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.power_input_outlined)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
