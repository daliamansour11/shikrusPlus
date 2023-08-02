import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:taskmanger/home/model/statisticsmodel.dart';
import 'package:taskmanger/home/provider/HomeProvider.dart';
import 'package:taskmanger/home/view/detailsscreen.dart';
import 'package:taskmanger/home/view/homescreen.dart';

import '../../core/SharedPreferenceInfo.dart';
import '../../profile/profile.dart';
import '../../screens/bottomnavigation.dart';
import '../../widgets/TextFieldWidget.dart';
import '../model/statisticsadminmodel.dart';


class ProjectsProgress extends ConsumerStatefulWidget {
  //List<Task>?tasks;

  @override
  ConsumerState<ProjectsProgress> createState() => _ProjectsProgressState();
}

class _ProjectsProgressState extends ConsumerState<ProjectsProgress> {
  String type="";
  gettingUserType() async {
    await SharedPreferencesInfo.getUserTypeFromSF().then((value) {
      setState(() {
        type = value!;
        print("nameeeeeeeeeeeeee$type");
      });
    });
  }
  @override
  void initState() {
    gettingUserType();
  }

  @override
  Widget build(BuildContext context) {
    final statitic = ref.watch(statisticProvider);
    final statiticadmin = ref.watch(statisticadminProvider);
    return DefaultTabController(
        length: 4,
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
                    child: TextFieldHeaderWidget(title:"Progress", colors: Colors.white),
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
            labelPadding: EdgeInsets.only(right: 10),
                //  padding: EdgeInsets.symmetric(horizontal: 10),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[400],

                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                tabs: [
                  //size:23
                  TextFieldTittleWidget(title: 'To-Do',fontWeight: FontWeight.bold,size: 13.sp,),
                  TextFieldTittleWidget(title: 'Done',fontWeight: FontWeight.bold,size: 13.sp,),
                  TextFieldTittleWidget(title: 'Hold',fontWeight: FontWeight.bold,size: 13.sp,),
                  TextFieldTittleWidget(title: 'On_Going',size: 13.sp,fontWeight: FontWeight.bold,),
                ] ,

              )),
          body: TabBarView(
            children: [
           type=="admin"? Container(
             child: Padding(
                 padding: const EdgeInsets.only(top: 15.0, left: 12, right: 12),
                 child: statiticadmin.when(
                     data: (data) => ListView.builder(
                       shrinkWrap: true,
                       scrollDirection: Axis.vertical,
                       itemBuilder: (context, index) {
                         List<Projectstatistis> todolist = data.data[0].projects;
                         return  InkWell(
                           onTap: () {
                             Navigator.of(context).pushReplacement(
                                 MaterialPageRoute(
                                     builder: (context) =>
                                         Detailsscreen(name: data.data[0].projects[index].nameEn, subject: data.data[0].projects[index].subject, notes: data.data[0].projects[index].notes, startDate: data.data[0].projects[index].startingDate, endDate: data.data[0].projects[index].expectedExpiryDate, status: '',)));
                           },
                           child: Container(
                             margin: EdgeInsets.only(bottom: 14),
                             height: 110.h,
                             width: 120.w,
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
                                         child: TextFieldTitle2Widget(fontWeight:FontWeight.bold,
                                           title: todolist[index].nameEn,
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
                                             top: 10),
                                         child: Row(
                                           children: [
                                             TextFieldTitleWidget(
                                               title: "Progress", colors: Colors.grey,

                                             ),
                                             Padding(
                                               padding:
                                               const EdgeInsets.only(
                                                   left: 95.0),
                                               child:  TextFieldTitleWidget(
                                                 title: "45%",
                                                 colors: Colors.grey,
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
                                   Column(
                                     children: [
                                       Row(
                                         children: [
                                           Padding(
                                             padding:
                                             const EdgeInsets
                                                 .only(

                                                 right: 10,
                                                 top: 5),
                                             child: LinearPercentIndicator(
                                                 width: 200.0,
                                                 lineHeight: 8.0,
                                                 percent: 0.45,
                                                 progressColor:
                                                 Colors.blue,
                                                 linearStrokeCap:
                                                 LinearStrokeCap
                                                     .round),
                                           ),
                                         ],
                                       ),
                                       Row(
                                         children: [
                                           Padding(
                                             padding:
                                             const EdgeInsets
                                                 .only(
                                                 left: 10.0,
                                                 right: 10,
                                                 top: 5),
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
                                               TextFieldTitleWidget(title:"10:00 AM")),
                                           Padding(
                                               padding:
                                               const EdgeInsets
                                                   .only(
                                                   left: 5.0,
                                                   top: 10),
                                               child: TextFieldTitleWidget(title: "-")),
                                           Padding(
                                               padding:
                                               const EdgeInsets
                                                   .only(
                                                   left: 5.0,
                                                   right: 6,
                                                   top: 10),
                                               child:
                                               TextFieldTitleWidget(title: "12:00 pM")),
                                         ],
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         );
                       },
                       itemCount: data.data[0].projects.length,
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
           ):  Container(
                child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 12, right: 12),
                    child: statitic.when(
                        data: (data) => ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            List<Task> todolist = data.data[0].tasks;
                            return  InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Detailsscreen(name: data.data[0].tasks[index].name, subject: data.data[0].tasks[index].subject, notes: data.data[0].tasks[index].notes, startDate: data.data[0].tasks[index].startingDate, endDate: data.data[0].tasks[index].expectedExpiryDate, status: '',)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 14),
                                height: 110.h,
                                width: 120.w,
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
                                            child: TextFieldTitle2Widget(fontWeight:FontWeight.bold,
                                             title: todolist[index].name,
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
                                                top: 10),
                                            child: Row(
                                              children: [
                                                TextFieldTitleWidget(
                                                 title: "Progress", colors: Colors.grey,

                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 95.0),
                                                  child:  TextFieldTitleWidget(
                                                   title: "45%",
                                                    colors: Colors.grey,
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
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(

                                                    right: 10,
                                                    top: 5),
                                                child: LinearPercentIndicator(
                                                    width: 200.0,
                                                    lineHeight: 8.0,
                                                    percent: 0.45,
                                                    progressColor:
                                                    Colors.blue,
                                                    linearStrokeCap:
                                                    LinearStrokeCap
                                                        .round),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 5),
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
                                                  TextFieldTitleWidget(title:"10:00 AM")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      top: 10),
                                                  child: TextFieldTitleWidget(title: "-")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      right: 6,
                                                      top: 10),
                                                  child:
                                                  TextFieldTitleWidget(title: "12:00 pM")),
                                            ],
                                          ),
                                        ],
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
              type=="admin"?Container(
                child: Padding(
                    padding:
                    const EdgeInsets.only(top: 15.0, left: 12, right: 12),
                    child: statiticadmin.when(
                        data: (data) =>data.data.isEmpty?Text(""): ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            List<Projectstatistis> todolist = data.data[1].projects;
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Detailsscreen(name: data.data[1].projects[index].nameEn, subject: data.data[1].projects[index].subject, notes: data.data[1].projects[index].notes, startDate: data.data[1].projects[index].startingDate, endDate: data.data[1].projects[index].expectedExpiryDate, status: '',)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 14),
                                height: 110.h,
                                width: 120.w,
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
                                            child: TextFieldTitle2Widget(fontWeight:FontWeight.bold,
                                              title: todolist[index].nameEn,
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
                                                top: 10),
                                            child: Row(
                                              children: [
                                                TextFieldTitleWidget(
                                                  title: "Progress", colors: Colors.grey,

                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 95.0),
                                                  child:  TextFieldTitleWidget(
                                                    title: "45%",
                                                    colors: Colors.grey,
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
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(

                                                    right: 10,
                                                    top: 5),
                                                child: LinearPercentIndicator(
                                                    width: 200.0,
                                                    lineHeight: 8.0,
                                                    percent: 0.45,
                                                    progressColor:
                                                    Colors.blue,
                                                    linearStrokeCap:
                                                    LinearStrokeCap
                                                        .round),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 5),
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
                                                  TextFieldTitleWidget(title:"10:00 AM")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      top: 10),
                                                  child: TextFieldTitleWidget(title: "-")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      right: 6,
                                                      top: 10),
                                                  child:
                                                  TextFieldTitleWidget(title: "12:00 pM")),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: data.data[1].projects.length,
                        ),
                        error: (err, _) => Text(
                          "$err",
                          style: TextStyle(color: Colors.red),
                        ),
                        loading: () =>
                            Center(child: CircularProgressIndicator()))),
              ):   Container(
                child: Padding(
                    padding:
                    const EdgeInsets.only(top: 15.0, left: 12, right: 12),
                    child: statitic.when(
                        data: (data) =>data.data.isEmpty?Text(""): ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            List<Task> todolist = data.data[1].tasks;
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Detailsscreen(name: data.data[1].tasks[index].name, subject: data.data[1].tasks[index].subject, notes: data.data[1].tasks[index].notes, startDate: data.data[1].tasks[index].startingDate, endDate: data.data[1].tasks[index].expectedExpiryDate, status: '',)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 14),
                                height: 110.h,
                                width: 120.w,
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
                                            child: TextFieldTitle2Widget(fontWeight:FontWeight.bold,
                                              title: todolist[index].name,
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
                                                top: 10),
                                            child: Row(
                                              children: [
                                                TextFieldTitleWidget(
                                                  title: "Progress", colors: Colors.grey,

                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 95.0),
                                                  child:  TextFieldTitleWidget(
                                                    title: "45%",
                                                    colors: Colors.grey,
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
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(

                                                    right: 10,
                                                    top: 5),
                                                child: LinearPercentIndicator(
                                                    width: 200.0,
                                                    lineHeight: 8.0,
                                                    percent: 0.45,
                                                    progressColor:
                                                    Colors.blue,
                                                    linearStrokeCap:
                                                    LinearStrokeCap
                                                        .round),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 5),
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
                                                  TextFieldTitleWidget(title:"10:00 AM")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      top: 10),
                                                  child: TextFieldTitleWidget(title: "-")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      right: 6,
                                                      top: 10),
                                                  child:
                                                  TextFieldTitleWidget(title: "12:00 pM")),
                                            ],
                                          ),
                                        ],
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
              type=="admin"? Container(
                child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 12, right: 12,bottom: 10),
                    child: statiticadmin.when(
                        data: (data) =>data.data.isEmpty?Text(""): ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            List<Projectstatistis> todolist = data.data[2].projects;
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Detailsscreen(name: todolist[index].nameEn, subject: todolist[index].subject, notes: todolist[index].notes, startDate: todolist[index].startingDate ,endDate: todolist[index].expectedExpiryDate, status: '',)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 14),
                                height: 110.h,
                                width: 120.w,
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
                                            child: TextFieldTitle2Widget(fontWeight:FontWeight.bold,
                                              title: todolist[index].nameEn,
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
                                                top: 10),
                                            child: Row(
                                              children: [
                                                TextFieldTitleWidget(
                                                  title: "Progress", colors: Colors.grey,

                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 95.0),
                                                  child:  TextFieldTitleWidget(
                                                    title: "45%",
                                                    colors: Colors.grey,
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
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(

                                                    right: 10,
                                                    top: 5),
                                                child: LinearPercentIndicator(
                                                    width: 200.0,
                                                    lineHeight: 8.0,
                                                    percent: 0.45,
                                                    progressColor:
                                                    Colors.blue,
                                                    linearStrokeCap:
                                                    LinearStrokeCap
                                                        .round),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 5),
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
                                                  TextFieldTitleWidget(title:"10:00 AM")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      top: 10),
                                                  child: TextFieldTitleWidget(title: "-")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      right: 6,
                                                      top: 10),
                                                  child:
                                                  TextFieldTitleWidget(title: "12:00 pM")),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: data.data.isEmpty?0:data.data[2].projects.length,
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
              ): Container(
                child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 12, right: 12,bottom: 10),
                    child: statitic.when(
                        data: (data) =>data.data.isEmpty?Text(""): ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            List<Task> todolist = data.data[2].tasks;
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Detailsscreen(name: data.data[2].tasks[index].name, subject: data.data[0].tasks[index].subject, notes: data.data[2].tasks[index].notes, startDate: data.data[2].tasks[index].startingDate, endDate: data.data[2].tasks[index].expectedExpiryDate, status: '',)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 14),
                                height: 110.h,
                                width: 120.w,
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
                                            child: TextFieldTitle2Widget(fontWeight:FontWeight.bold,
                                              title: todolist[index].name,
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
                                                top: 10),
                                            child: Row(
                                              children: [
                                                TextFieldTitleWidget(
                                                  title: "Progress", colors: Colors.grey,

                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 95.0),
                                                  child:  TextFieldTitleWidget(
                                                    title: "45%",
                                                    colors: Colors.grey,
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
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(

                                                    right: 10,
                                                    top: 5),
                                                child: LinearPercentIndicator(
                                                    width: 200.0,
                                                    lineHeight: 8.0,
                                                    percent: 0.45,
                                                    progressColor:
                                                    Colors.blue,
                                                    linearStrokeCap:
                                                    LinearStrokeCap
                                                        .round),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 5),
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
                                                  TextFieldTitleWidget(title:"10:00 AM")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      top: 10),
                                                  child: TextFieldTitleWidget(title: "-")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      right: 6,
                                                      top: 10),
                                                  child:
                                                  TextFieldTitleWidget(title: "12:00 pM")),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: data.data.isEmpty?0:data.data[2].tasks.length,
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
              type=="admin"? Container(
                child: Padding(
                    padding:
                    const EdgeInsets.only(top: 15.0, left: 12, right: 12),
                    child: statiticadmin.when(
                        data: (data) => data.data.isEmpty?Text(""):ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            List<Projectstatistis> todolist = data.data[3].projects;
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Detailsscreen(name: data.data[3].projects[index].nameEn, subject: data.data[3].projects[index].subject, notes: data.data[3].projects[index].notes, startDate: data.data[3].projects[index].startingDate, endDate: data.data[3].projects[index].expectedExpiryDate, status: '',)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 14),
                                height: 110.h,
                                width: 120.w,
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
                                            child: TextFieldTitle2Widget(fontWeight:FontWeight.bold,
                                              title: todolist[index].nameEn,
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
                                                top: 10),
                                            child: Row(
                                              children: [
                                                TextFieldTitleWidget(
                                                  title: "Progress", colors: Colors.grey,
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 95.0),
                                                  child:  TextFieldTitleWidget(
                                                    title: "45%",
                                                    colors: Colors.grey,
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
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(

                                                    right: 10,
                                                    top: 5),
                                                child: LinearPercentIndicator(
                                                    width: 200.0,
                                                    lineHeight: 8.0,
                                                    percent: 0.45,
                                                    progressColor:
                                                    Colors.blue,
                                                    linearStrokeCap:
                                                    LinearStrokeCap
                                                        .round),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 5),
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
                                                  TextFieldTitleWidget(title:"10:00 AM")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      top: 10),
                                                  child: TextFieldTitleWidget(title: "-")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      right: 6,
                                                      top: 10),
                                                  child:
                                                  TextFieldTitleWidget(title: "12:00 pM")),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: data.data[3].count,
                        ),
                        error: (err, _) => Text(
                          "$err",
                          style: TextStyle(color: Colors.red),
                        ),
                        loading: () =>
                            Center(child: CircularProgressIndicator()))),
              ): Container(
                child: Padding(
                    padding:
                    const EdgeInsets.only(top: 15.0, left: 12, right: 12),
                    child: statitic.when(
                        data: (data) => data.data.isEmpty?Text(""):ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            List<Task> todolist = data.data[3].tasks;
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Detailsscreen(name: data.data[3].tasks[index].name, subject: data.data[3].tasks[index].subject, notes: data.data[3].tasks[index].notes, startDate: data.data[3].tasks[index].startingDate, endDate: data.data[3].tasks[index].expectedExpiryDate, status: '',)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 14),
                                height: 110.h,
                                width: 120.w,
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
                                            child: TextFieldTitle2Widget(fontWeight:FontWeight.bold,
                                              title: todolist[index].name,
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
                                                top: 10),
                                            child: Row(
                                              children: [
                                                TextFieldTitleWidget(
                                                  title: "Progress", colors: Colors.grey,
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 95.0),
                                                  child:  TextFieldTitleWidget(
                                                    title: "45%",
                                                    colors: Colors.grey,
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
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(

                                                    right: 10,
                                                    top: 5),
                                                child: LinearPercentIndicator(
                                                    width: 200.0,
                                                    lineHeight: 8.0,
                                                    percent: 0.45,
                                                    progressColor:
                                                    Colors.blue,
                                                    linearStrokeCap:
                                                    LinearStrokeCap
                                                        .round),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 5),
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
                                                  TextFieldTitleWidget(title:"10:00 AM")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      top: 10),
                                                  child: TextFieldTitleWidget(title: "-")),
                                              Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      right: 6,
                                                      top: 10),
                                                  child:
                                                  TextFieldTitleWidget(title: "12:00 pM")),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: data.data[3].count,
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
