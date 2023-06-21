import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:taskmanger/home/model/statisticsmodel.dart';
import 'package:taskmanger/home/provider/HomeProvider.dart';
import 'package:taskmanger/home/view/detailsscreen.dart';
import 'package:taskmanger/home/view/homescreen.dart';

import '../../profile/profile.dart';
import '../../screens/bottomnavigation.dart';


class ProjectsProgress extends ConsumerStatefulWidget {
  //List<Task>?tasks;

  @override
  ConsumerState<ProjectsProgress> createState() => _ProjectsProgressState();
}

class _ProjectsProgressState extends ConsumerState<ProjectsProgress> {
  @override
  Widget build(BuildContext context) {
    final statitic = ref.watch(statisticProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor:Color(0xFF005373),
            title:
            Container(
              width :MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Center(
                  child: Text("Progress",
                    style: TextStyle(fontSize: 25,
                       color: Colors.white),
                  ),
                ),
              ),
            ),
            centerTitle: true,

            // leading:



            leading: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Bottomnavigation()));
              },
                child: Icon(Icons.arrow_back)),
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[500],
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                // color: Colors.white,
              ),
              tabs: [
                Text('To-Do',style: TextStyle(fontSize: 23),),
                Text('Hold',style: TextStyle(fontSize: 23),),

              ] ,

            )),
        body: TabBarView(
          children: [
            Container(
              child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 12, right: 12),
                  child: statitic.when(
                      data: (data) => ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          List<Task> todolist = data.data[0].tasks;
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Detailsscreen(name: '', subject: '', notes: '', startDate: '', endDate: '', status: '',)));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 14),
                              height: 130,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0),
                                          child: Text(
                                            todolist[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              right: 10,
                                              top: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Progress",
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 95.0),
                                                child: Text(
                                                  "45%",
                                                  style: TextStyle(
                                                      color:
                                                      Colors.grey[700],
                                                      fontSize: 13),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 39.0),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundImage:
                                                        AssetImage(
                                                          "assets/personn.jpg",
                                                        ),
                                                        radius: 12,
                                                        backgroundColor:
                                                        Colors.white60),
                                                    CircleAvatar(
                                                        backgroundImage:
                                                        AssetImage(
                                                          "assets/ppr.jpg",
                                                        ),
                                                        radius: 12,
                                                        backgroundColor:
                                                        Colors.white60),
                                                    CircleAvatar(
                                                        backgroundImage:
                                                        AssetImage(
                                                          "assets/ppr.jpg",
                                                        ),
                                                        radius: 12,
                                                        backgroundColor:
                                                        Colors.white60),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 15.0),
                                                      child: Icon(
                                                        Icons
                                                            .arrow_forward_ios,
                                                        size: 20,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0, top: 3),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              LinearPercentIndicator(
                                                  width: 200.0,
                                                  lineHeight: 8.0,
                                                  percent: 0.45,
                                                  progressColor:
                                                  Colors.blue,
                                                  linearStrokeCap:
                                                  LinearStrokeCap
                                                      .round),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 5.0,
                                                        right: 10,
                                                        top: 10),
                                                    child: Icon(
                                                      Icons
                                                          .access_time_filled,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                        left: 5.0,
                                                        top: 10,
                                                      ),
                                                      child:
                                                      Text("10:00 AM")),
                                                  Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 5.0,
                                                          top: 10),
                                                      child: Text("-")),
                                                  Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 5.0,
                                                          right: 6,
                                                          top: 10),
                                                      child:
                                                      Text("12:00 pM")),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: data.data[0].tasks.length,
                      ),
                      error: (err, _) => InkWell(
                          onTap: () {
                            debugPrint(
                                "errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror${err}");
                          },
                          child: Text("$err",style: TextStyle(color: Colors.red),
                          )),
                      loading: () =>
                          Center(child: CircularProgressIndicator()))),
            ),
            Container(
              child: Padding(
                  padding:
                  const EdgeInsets.only(top: 15.0, left: 12, right: 12),
                  child: statitic.when(
                      data: (data) => ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          List<Task> todolist = data.data[1].tasks;
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Detailsscreen(name: '', subject: '', notes: '', startDate: '', endDate: '', status: '',)));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 14),
                              height: 130,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0),
                                          child: Text(
                                            todolist[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              right: 10,
                                              top: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Progress",
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 95.0),
                                                child: Text(
                                                  "45%",
                                                  style: TextStyle(
                                                      color:
                                                      Colors.grey[700],
                                                      fontSize: 13),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 39.0),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundImage:
                                                        AssetImage(
                                                          "assets/personn.jpg",
                                                        ),
                                                        radius: 12,
                                                        backgroundColor:
                                                        Colors.white60),
                                                    CircleAvatar(
                                                        backgroundImage:
                                                        AssetImage(
                                                          "assets/ppr.jpg",
                                                        ),
                                                        radius: 12,
                                                        backgroundColor:
                                                        Colors.white60),
                                                    CircleAvatar(
                                                        backgroundImage:
                                                        AssetImage(
                                                          "assets/ppr.jpg",
                                                        ),
                                                        radius: 12,
                                                        backgroundColor:
                                                        Colors.white60),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 15.0),
                                                      child: Icon(
                                                        Icons
                                                            .arrow_forward_ios,
                                                        size: 20,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0, top: 3),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              LinearPercentIndicator(
                                                  width: 200.0,
                                                  lineHeight: 8.0,
                                                  percent: 0.45,
                                                  progressColor:
                                                  Colors.blue,
                                                  linearStrokeCap:
                                                  LinearStrokeCap
                                                      .round),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 5.0,
                                                        right: 10,
                                                        top: 10),
                                                    child: Icon(
                                                      Icons
                                                          .access_time_filled,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                        left: 5.0,
                                                        top: 10,
                                                      ),
                                                      child:
                                                      Text("10:00 AM")),
                                                  Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 5.0,
                                                          top: 10),
                                                      child: Text("-")),
                                                  Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 5.0,
                                                          right: 6,
                                                          top: 10),
                                                      child:
                                                      Text("12:00 pM")),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: data.data[1].tasks.length,
                      ),
                      error: (err, _) => Text(
                        "$err",
                        style: TextStyle(color: Colors.red),
                      ),
                      loading: () =>
                          Center(child: CircularProgressIndicator()))),
            ),
          ],
        ),
      ),
    );
  }
}
