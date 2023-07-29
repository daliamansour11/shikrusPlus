import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:taskmanger/core/utils.dart';
import 'package:taskmanger/home/provider/HomeProvider.dart';
import '../../popMenuItem/PopMenuItems.dart';
import '../../widgets/TextFieldWidget.dart';
import 'Reports.dart';

class ReportsPorject extends ConsumerStatefulWidget {
  @override
  ConsumerState<ReportsPorject> createState() => _ReportsPorjectState();
}

class _ReportsPorjectState extends ConsumerState<ReportsPorject> {
  @override
  Widget build(BuildContext context) {
    final projects = ref.watch(proProvider);

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Color(0xFF005373),
          title: TextFieldHeaderWidget(
          title:  " Project Reports",
           colors: Colors.white,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: RefreshIndicator(
          backgroundColor: context.appTheme.bottomAppBarColor,
          onRefresh: () async {
            await ref.refresh(proProvider);
            // ref.read(SubTaskProvider( widget.main_task_id).future);
            print("updated");
            // await ref.read(MainTasksProvider.future);
            return Future.delayed(
                Duration(milliseconds: 300), () => ref.read(proProvider));
          },
          child: projects.when(
              data: (data) => ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final usersData = data.data[index];
                      return InkWell(
                        onTap: () {
                          print('idddddddddddddddddddd${data.data[index].id}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Reports(
                                        report: '',
                                        reason: '',
                                        image: '',
                                        id: data.data[index].id,
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: 7, top: 16, left: 5, right: 5),
                          height: MediaQuery.of(context).size.height/6,
                          width: 100.w,
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
                                      child: TextFieldTitle2Widget(
                                        title: usersData.name ?? " ",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),],
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
                                            title: "Progress",
                                            colors: Colors.grey,
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 90.0),
                                            child:
                                            TextFieldTitleWidget(
                                              title: "45%" ?? " ",
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
                                                    Colors
                                                        .white60),
                                                CircleAvatar(
                                                    backgroundImage:
                                                    AssetImage(
                                                      "assets/ppr.jpg",
                                                    ),
                                                    radius: 12,
                                                    backgroundColor:
                                                    Colors
                                                        .white60),
                                                CircleAvatar(
                                                    backgroundImage:
                                                    AssetImage(
                                                      "assets/ppr.jpg",
                                                    ),
                                                    radius: 12,
                                                    backgroundColor:
                                                    Colors
                                                        .white60),
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
                                  padding:
                                  const EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
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
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 5.0),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 5.0,
                                                      right: 10),
                                                  child: Icon(
                                                    Icons
                                                        .access_time_filled,
                                                    color:
                                                    Colors.blue,
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                      left: 5.0,
                                                    ),
                                                    child: Text(usersData
                                                        .startingDate!
                                                        .year
                                                        .toString() +
                                                        "-" +
                                                        usersData
                                                            .startingDate!
                                                            .month
                                                            .toString() +
                                                        "-" +
                                                        usersData
                                                            .startingDate!
                                                            .day
                                                            .toString())),
                                                Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left:
                                                        5.0),
                                                    child: Text("_")),
                                                Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 5.0,
                                                        right: 6),
                                                    child: Text(usersData
                                                        .expectedExpiryDate!
                                                        .year
                                                        .toString() +
                                                        "-" +
                                                        usersData
                                                            .expectedExpiryDate!
                                                            .month
                                                            .toString() +
                                                        "-" +
                                                        usersData
                                                            .expectedExpiryDate!
                                                            .day
                                                            .toString())),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      );
                    },
                    itemCount: data.data.length,
                  ),
              error: (err, _) =>Center(
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
              loading: () => Center(child: CircularProgressIndicator())),
        ));
  }
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
