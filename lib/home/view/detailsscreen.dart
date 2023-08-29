import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:taskmanger/core/utils.dart';
import 'package:taskmanger/widgets/TextFieldWidget.dart';
import '../../core/SharedPreferenceInfo.dart';
import '../provider/MainTaskProvider.dart';
import '../../clender/Provider/UpdatestatusProvider.dart';
import '../../clender/model/TasksModel.dart';
import '../../clender/view/SubTasksScreen.dart';
import '../../core/Color.dart';
import '../../core/Constants.dart';
import '../../popMenuItem/PopMenuItems.dart';
import '../../popMenuItem/TaskMenuItems.dart';
import '../provider/ProjectInfoProvider.dart';

class Detailsscreen extends ConsumerStatefulWidget {
  String name;
  String subject;
  String notes;
  DateTime? startDate;
  DateTime? endDate;
  String status;
  int project_id;

  Detailsscreen({
    required this.name,
    required this.subject,
    required this.notes,
    required this.startDate,
    required this.endDate,
    required this.status,
     required this.project_id ,
  });

  @override
  ConsumerState<Detailsscreen> createState() => _DetailsscreenState();
}

class _DetailsscreenState extends ConsumerState<Detailsscreen> {
  onStatusChang(String status) {
    if (status == "done") {
      return Itemcolors[0];
    }
    else if (status == "on-going") {
      return Itemcolors[3];
    } else if (status == "to-do") {
      return Itemcolors[2];
    } else if (status == "hold") {
      return Itemcolors[1];
    }
  }

  String type = "";

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
    super.initState();
  }

  RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);


  @override
  Widget build(BuildContext context) {
    final userTask = ref.watch(MainTasksProvider(widget.project_id));
    final tasks=ref.watch(MainTasksProvider(widget.project_id));
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
              Expanded(
                flex: 7,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        title: widget.subject.replaceAll(exp,  ' '),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ref.watch(ProjectinfoProvider(widget.project_id)).when(
                          data: (dataa)=>Column(
                            children: [
                              // Expanded(child : ListView.builder(shrinkWrap: true,itemBuilder: (context,index){return Text("jihuih");},itemCount: 2,)),
                              CircleAvatar(child: Image.network(dataa.data.employees[0].image),),
                            ],
                          ),
                          error: (err, _) { return  Center(child: Text("${err}"));
                          // print("${err}errrr");
                          },
                          loading: () => Center(child: CircularProgressIndicator())),
                      // Row(
                      //   children: [
                      //     CircleAvatar(
                      //       backgroundImage: AssetImage(
                      //         "assets/personn.jpg",
                      //       ),
                      //       radius: 10.sp,
                      //       backgroundColor: Colors.white60,
                      //     ),
                      //     CircleAvatar(
                      //         backgroundImage: AssetImage(
                      //           "assets/ppr.jpg",
                      //         ),
                      //         radius: 10.sp,
                      //         backgroundColor: Colors.white60),
                      //     CircleAvatar(
                      //         backgroundImage: AssetImage(
                      //           "assets/personn.jpg",
                      //         ),
                      //         radius: 10.sp,
                      //         backgroundColor: Colors.white60),
                      //     CircleAvatar(
                      //         backgroundImage: AssetImage(
                      //           "assets/ppr.jpg",
                      //         ),
                      //         radius: 10.sp,
                      //         backgroundColor: Colors.white60),
                      //     CircleAvatar(
                      //       backgroundColor: Colors.indigo[3],
                      //       child: TextFieldTitle2Widget(
                      //         title: "+3",
                      //         colors: Colors.white,
                      //         fontWeight: FontWeight.normal,
                      //         size: 10.sp,
                      //       ),
                      //     ),
                      //   ],
                      // ),

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
              ),
              SizedBox(
                height: 9.h,
              ),
              Expanded(
                flex: 4,
                child: Column(
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
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Container(
                          child: ReadMoreText(
                          widget.notes
                            ,trimLines: 2,trimMode: TrimMode.Line,trimCollapsedText: "Show More",textAlign: TextAlign.justify,
                              trimExpandedText: "Show less",
                            lessStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                            moreStyle: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.sp,
              ),
              Expanded(
                flex: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 100.h,
                        width: 140.w,
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
                                            title: "Start Date",
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
                        height: 100.h,
                        width: 140.w,
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
                                            title: "End Date",
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
              ),
              SizedBox(
                height: 10.h,
              ),
             type !="client"? Expanded(
                flex: 2,
                child: Row(
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
              ):Text(""),
              type !="client"?  Expanded(
              flex: 15,
              child: Container(
                  child:
                 tasks.when(
                    data: (data) =>data.data.where((element) =>element.projectId==widget.project_id.toString()).toList().isEmpty?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(radius:40.sp,backgroundImage: AssetImage("assets/placeholder.png",),),
                            SizedBox(height: 5.h,),
                            Text(
                              "No Tasks Found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),),
                          ],
                        ),
                      ],
                    ) : ListView.builder(

                        shrinkWrap: true,
                          itemCount: data.data.where((element) =>element.projectId==widget.project_id.toString()).toList().length,
                          itemBuilder: (context, index) {
                            List<Datum>tasks=data.data.where((element) =>element.projectId==widget.project_id.toString()).toList()??[];
                            var status = tasks[index].status;
                            var startdate=tasks[index].startingDate;
                            return Padding(
                              padding: const EdgeInsets.only(top: 1.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SubTasksScreen(
                                                taskname:tasks[index].name??"" ,
                                                note:tasks[index].notes??"" ,
                                                description:tasks[index].subject??"" ,
                                                startdate: tasks[index].startingDate??DateTime.parse(""),
                                                  enddate:tasks[index].expectedExpiryDate ??DateTime.parse(""),
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
                                    height: MediaQuery.of(context).size.height/6,
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
                                          SizedBox(height: 5.h,),
                                          Row(
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
                                          SizedBox(height: 20.h,),
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          }),
                    error: (err, _) => Center(
                          child: Text(""),
                        ),
                    loading: () => Center(
                          child: CircularProgressIndicator(),
                        )),
              ),
            ):Text(""),

            ],
          ),
        ),
      ),

    );
  }
}
