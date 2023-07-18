import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:taskmanger/widgets/TextFieldWidget.dart';

import '../../clender/Provider/ClenderMainTaskProvider.dart';
import '../../clender/Provider/UpdatestatusProvider.dart';
import '../../clender/model/TasksModel.dart';
import '../../clender/view/SubTasksScreen.dart';
import '../../core/Color.dart';
import '../../core/Constants.dart';
import '../../popMenuItem/PopMenuItems.dart';
import '../../popMenuItem/TaskMenuItems.dart';

class Detailsscreen extends ConsumerStatefulWidget {
  String name;
  String subject;
  String notes;
  String startDate;
  String endDate;
  String status;
  int project_id;

  Detailsscreen({
    required this.name,
    required this.subject,
    required this.notes,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.project_id = 0,
  });

  @override
  ConsumerState<Detailsscreen> createState() => _DetailsscreenState();
}

class _DetailsscreenState extends ConsumerState<Detailsscreen> {
  onStatusChang(String status) {
    if (status == "done") {
      return Itemcolors[0];
    } else if (status == "on-going") {
      return Itemcolors[3];
    } else if (status == "to-do") {
      return Itemcolors[2];
    } else if (status == "hold") {
      return Itemcolors[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    final userTask = ref.watch(MainTasksProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF005373),
        title: TextFieldHeaderWidget(
          title: "Details",
          colors: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      height: 5.h,
                    ),
                    TextFieldTitle2Widget(
                      title: widget.subject,
                    ),
                    SizedBox(
                      height: 10.h,
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
                            colors: Colors.white,
                            fontWeight: FontWeight.normal,
                            size: 10.sp,
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
                height: 10.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFieldTitleWidget(
                          title: "Description",
                          fontWeight: FontWeight.bold,
                          size: 15.sp,
                          colors: Color(0xFF005373)),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  TextFieldTitleWidget(
                    title: widget.notes,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
              SizedBox(
                height: 10.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 80.h,
                      width: 130.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
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
                                          title: "Due Date",
                                          fontWeight: FontWeight.bold,
                                          colors: Colors.grey,
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
                                      TextFieldTitle2Widget(
                                          title:
                                              formattedDate(widget.startDate),
                                          fontWeight: FontWeight.bold,
                                          size: 12.sp,
                                          colors: Color(0xFF005373)),
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
                      height: 80.h,
                      width: 130.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
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
                                          title: "Due Date",
                                          fontWeight: FontWeight.bold,
                                          colors: Colors.grey,
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
                                      TextFieldTitle2Widget(
                                          title:
                                              formattedDate(widget.endDate),
                                          fontWeight: FontWeight.bold,
                                          size: 12.sp,
                                          colors: Color(0xFF005373)),
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
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFieldTitleWidget(
                    fontWeight: FontWeight.bold,
                    title: "List of Tasks",
                    size: 15.sp,
                    colors: Color(0xFF005373),
                  ),
                ],
              ),

              userTask.when(
                  data: (data) => Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemCount: data.data.where((element) =>element.projectId==widget.project_id.toString()).toList().length,
                        itemBuilder: (context, index) {
                          List<Datum>tasks=data.data.where((element) =>element.projectId==widget.project_id.toString()).toList();
                          var status = tasks[index].status;
                          return Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SubTasksScreen(
                                              project_id: int.parse(
                                                  '${tasks[index].projectId}'),
                                              main_task_id:
                                              tasks[index].id,
                                            )));
                                print("idddddd${tasks[index].id}");
                                print("idddddd${tasks[index].projectId}");
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 8, top: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: onStatusChang(status!)),
                                  height: 90.h,
                                  width: 90.w,
                                  child: ListTile(
                                    title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextFieldTitleWidget(
                                            title: "${tasks[index].name}",
                                            fontWeight: FontWeight.bold,
                                            size: 15.sp,
                                          ),
                                          PopupMenuButton<PopMenuItems>(
                                              shape: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              itemBuilder: (context) => [
                                                    ...TaskMenuItems.taskFirst
                                                        .map((buildItem))
                                                        .toList(),
                                                  ],
                                              onSelected:
                                                  (PopMenuItems item) async {
                                                final updateTask = ref
                                                    .read(updateTaskProvider);
                                                // final  empTaskProvider =ref.read(userTaskProvider);

                                                switch (item) {
                                                  case TaskMenuItems
                                                      .taskComplete:
                                                    print(item.text);
                                                    String status = item.text;
                                                    updateTask
                                                        .updateTaskStatus(
                                                            status,
                                                            data.data[index]
                                                                .id);
                                                    // empTaskProvider.EmployeeTask();
                                                    break;

                                                  case TaskMenuItems
                                                      .taskInProcess:
                                                    updateTask
                                                        .updateTaskStatus(
                                                            item.text,
                                                            data.data[index]
                                                                .id);
                                                    // empTaskProvider.EmployeeTask();
                                                    break;
                                                }
                                              })
                                        ]),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: TextFieldTitle2Widget(
                                              title: "${tasks[index].status}",
                                              size: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              colors: Colors.white),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 30, top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 1.0,
                                                        right: 4,
                                                        top: 4,
                                                        bottom: 20),
                                                child: CircleAvatar(
                                                    backgroundImage:
                                                        AssetImage(
                                                      "assets/personn.jpg",
                                                    ),
                                                    radius: 10,
                                                    backgroundColor:
                                                        Colors.white60),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 1.0,
                                                        right: 4,
                                                        top: 4,
                                                        bottom: 20),
                                                child: CircleAvatar(
                                                    backgroundImage:
                                                        AssetImage(
                                                      "assets/ppr.jpg",
                                                    ),
                                                    radius: 10,
                                                    backgroundColor:
                                                        Colors.white60),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 1.0,
                                                        right: 4,
                                                        top: 4,
                                                        bottom: 20),
                                                child: CircleAvatar(
                                                    backgroundImage:
                                                        AssetImage(
                                                      "assets/ppr.jpg",
                                                    ),
                                                    radius: 10,
                                                    backgroundColor:
                                                        Colors.white60),
                                              ),
                                              SizedBox(
                                                width: 34,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 1.0,
                                                        right: 4,
                                                        top: 0,
                                                        bottom: 20),
                                                child: Icon(
                                                  Icons.access_time_filled,
                                                  color: Colors.white,
                                                  size: 12.sp,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 1.0,
                                                        top: 4,
                                                        bottom: 20),
                                                child: TextFieldTitle2Widget(
                                                    title:
                                                        "${tasks[index].timeFrom}",
                                                    size: 9.sp,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    colors: Colors.white),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0,
                                                          top: 4,
                                                          bottom: 20),
                                                  child:
                                                      TextFieldTitle2Widget(
                                                          title: "_",
                                                          size: 9.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          colors:
                                                              Colors.white)),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0,
                                                          right: 1,
                                                          top: 4,
                                                          bottom: 20),
                                                  child: TextFieldTitle2Widget(
                                                      title:
                                                          "${tasks[index].timeTo}",
                                                      size: 9.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      colors: Colors.white)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        }),
                  ),
                  error: (err, _) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFieldTitleWidget(
                                  title: "Oops!! \n"
                                      "Connection Lost!",
                                  fontWeight: FontWeight.bold,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 5.sp),
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    "assets/sad.jpg",
                                  ),
                                  radius: 18.sp,
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  loading: () => Center(
                        child: CircularProgressIndicator(),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
