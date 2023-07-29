import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:date_time_line/date_time_line.dart';

import 'package:taskmanger/popMenuItem/PopMenuItems.dart';
import 'package:taskmanger/clender/Provider/UpdatestatusProvider.dart';
import 'package:taskmanger/clender/view/SubTasksScreen.dart';

import 'package:taskmanger/core/SharedPreferenceInfo.dart';
import 'package:taskmanger/core/utils.dart';

import '../../core/Color.dart';
import '../../popMenuItem/TaskMenuItems.dart';
import '../../widgets/TextFieldWidget.dart';
import '../Provider/AllMainTaskProvider.dart';
import '../../home/provider/MainTaskProvider.dart';

class Calendarpage extends ConsumerStatefulWidget {
  @override
  ConsumerState<Calendarpage> createState() => _CalendarpageState();
}

class _CalendarpageState extends ConsumerState<Calendarpage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(Duration(seconds: 1));

      if (_selectedDate == DateTime.now()) {
        ref.refresh(AllMainTaskProvider);
        return await Future.delayed(Duration(milliseconds: 300),
                () => ref.read(AllMainTaskProvider));
      }
    });
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate
        .difference(startDate)
        .inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DatePickerController _datePickerController = DatePickerController();
    final userTask = ref.watch(AllMainTaskProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF005373),
          title: TextFieldHeaderWidget(
            title: "Calendar",
            colors: Colors.white,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding:
          const EdgeInsets.only(top: 10, bottom: 15, right: 3, left: 10),
          child: Column(children: [
            Expanded(
              child:
                  Container(
                    height: 100.h,
                    decoration: BoxDecoration(),
                    child: DateTimeLine(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      color: Color(0xFF005373),
                      hintText: "today task",
                      onSelected: (value) {
                        setState(
                              () {
                            _selectedDate = value;
                            setState(() {
                              _selectedDate;
                            });
                          },
                        );
                      },
                    ),
                  ),
              ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 180),
                  child: TextFieldTitleWidget(
                    title: "Daily tasks",
                    fontWeight: FontWeight.bold,
                    size: 15.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.grey[300],
                ),
                child: _listEmployeeTask(context))
          ]),
        ));
  }

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

  _listEmployeeTask(BuildContext context) {
    final userTask = ref.watch(AllMainTasksProvider);
    return RefreshIndicator(
        backgroundColor: context.appTheme.bottomAppBarColor,
        onRefresh: () async {
          ref.refresh(AllMainTaskProvider);
          return Future.delayed(Duration(milliseconds: 300),
                  () => ref.read(AllMainTaskProvider.notifier));},
        child: userTask.when(
            data: (data) =>
                ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (context, index) {
                      final empTask = data.data[index];
                            print("taskkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$empTask");
                      var expectedExpiryDate = DateTime(
                          empTask.expectedExpiryDate.year ?? 0,
                          empTask.expectedExpiryDate.month ?? 0,
                          empTask.expectedExpiryDate.day ?? 0);
                      var startDate = DateTime(
                          empTask.startingDate.year ?? 0,
                          empTask.startingDate.month ?? 0,
                          empTask.startingDate.day ?? 0);
                      List<DateTime> taskRange =
                      getDaysInBetween(startDate, expectedExpiryDate);
                      print(empTask.toJson());
                      _selectedDate = DateTime(_selectedDate.year,
                          _selectedDate.month, _selectedDate.day);
                      if (startDate.isAtSameMomentAs(_selectedDate) &&
                          startDate.isAfter(_selectedDate) ||
                          taskRange.contains(_selectedDate) ||
                          expectedExpiryDate.isAtSameMomentAs(_selectedDate) &&
                              expectedExpiryDate.isAfter(_selectedDate)) {
                        var status = empTask.status;
                        return Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  TextFieldTitleWidget(
                                    title: "${empTask.timeFrom}",
                                    size: 8.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  TextFieldTitleWidget(
                                    title: "${empTask.timeTo}",
                                    size: 8.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5.h,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 4.w,
                                  height: 40.h,
                                  color: Colors.purple,
                                  //  index ==0 ?Colors.purple :Colors.black,
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: Colors.purple, width: 4),
                                    color:
                                    index == 0 ? Colors.purple : Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Container(
                                    width: 4.w,
                                    height: 50.h,
                                    //  color:index == emptask.length-1 ?Colors.purple :Colors.black,
                                    color: Colors.purple
                                  // index ==1?Colors.purple :Colors.black,
                                ),
                              ],
                            ),
                            Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 1.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SubTasksScreen(
                                                    project_id: int.parse(
                                                        '${data.data[index].project.id}'),
                                                    main_task_id:
                                                    data.data[index].id,
                                                  )));
                                      print("idddddd${data.data[index].id}");
                                      print("idddddd${data.data[index].project.id}");
                                    },
                                    child: Container(
                                      // width: 90,
                                        margin: EdgeInsets.only(
                                            left: 8, top: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            color: onStatusChang(status!)),
                                        height: 90.h,
                                        width: 100.w,
                                        child: ListTile(
                                          title: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                TextFieldTitleWidget(
                                                  title: "${empTask.name}",
                                                  fontWeight: FontWeight.bold,
                                                  size: 15.sp,
                                                ),
                                                PopupMenuButton<PopMenuItems>(
                                                    shape: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                    itemBuilder: (context) =>
                                                    [
                                                      ...TaskMenuItems.taskFirst
                                                          .map((buildItem))
                                                          .toList(),
                                                    ],
                                                    onSelected:
                                                        (
                                                        PopMenuItems item) async {
                                                      final updateTask = ref
                                                          .read(
                                                          updateTaskProvider);
                                                      // final  empTaskProvider =ref.read(userTaskProvider);

                                                      switch (item) {
                                                        case TaskMenuItems
                                                            .taskComplete:
                                                          print(item.text);
                                                          String status = item
                                                              .text;
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
                                                    title: "${empTask.status}",
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
                                                        Icons
                                                            .access_time_filled,
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
                                                          title: "${empTask
                                                              .timeFrom}",
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
                                                        child:TextFieldTitle2Widget(
                                                            title: "_",
                                                            size: 9.sp,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            colors: Colors.white)),
                                                    Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            right: 1,
                                                            top: 4,
                                                            bottom: 20),
                                                        child: TextFieldTitle2Widget(
                                                            title: "${empTask
                                                                .timeTo}",
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
                                ))
                          ],
                        );
                      } else {
                        return Center();
                      }
                    }),
            error: (err, _) =>
                Center(
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
            loading: () =>
                Center(
                  child: CircularProgressIndicator(),
                )));
  }

  PopupMenuItem<PopMenuItems> buildItem(PopMenuItems item) =>
      PopupMenuItem<PopMenuItems>(
          value: item,
          child: Row(
            children: [
              Icon(
                item.icon,
                color: item.color,
              ),
              Text(item.text),
            ],
          ));
}
