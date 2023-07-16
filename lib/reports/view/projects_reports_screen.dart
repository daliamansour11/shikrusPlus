import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:taskmanger/core/utils.dart';
import 'package:taskmanger/home/provider/HomeProvider.dart';
import '../../popMenuItem/PopMenuItems.dart';
import 'Reports.dart';


class ReportsPorject extends ConsumerStatefulWidget{
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
          title: Text(
            " Project Reports",
            style: TextStyle(
              fontSize: 25,

            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body:  RefreshIndicator(
          backgroundColor: context.appTheme.bottomAppBarColor,
          onRefresh: ()  async{
            await ref.refresh(proProvider);
            // ref.read(SubTaskProvider( widget.main_task_id).future);
            print("updated");
            // await ref.read(MainTasksProvider.future);
            return Future.delayed(Duration(milliseconds: 300) , () => ref.read(proProvider));
          },
          child:projects.when(
              data: (data) => ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final usersData = data.data[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Reports(report: '', reason: '', image: '', id:data.data[index].id ,)));

                    },

                    child: Container(

                      margin: EdgeInsets.all(7),
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  usersData.name ?? " ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
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
                                        const EdgeInsets.only(
                                            left: 15.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                          color:  Color(0xFF005373),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Row(

                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Text(
                                    "Progress",
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 95.0),
                                  child: Text(
                                    "45%"??
                                        " ",
                                    style: TextStyle(
                                        color:  Color(0xFF005373),
                                        fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 8.h,),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    LinearPercentIndicator(
                                        width: 200.0,
                                        lineHeight: 8.0,
                                        percent: 0.45,
                                        progressColor:  Color(0xFF005373),
                                        linearStrokeCap:
                                        LinearStrokeCap.round

                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 5.0,
                                              right: 10),
                                          child: Icon(
                                            Icons.date_range_rounded,
                                            color:  Color(0xFF005373),
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                            const EdgeInsets.only(
                                              left: 5.0,
                                            ),
                                            child: Text(usersData.startingDate!.year.toString() +
                                                "-" + usersData.startingDate!.month.toString() +
                                                "-" + usersData.startingDate!.day.toString())),
                                        Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text("_")),
                                        Padding(
                                            padding:
                                            const EdgeInsets.only(
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
                itemCount: data.data.length,
              ),
              error: (err, _) => Text(
                "$err",
                style: TextStyle(color: Colors.red),
              ),
              loading: () => Center(child: CircularProgressIndicator())),
        )
    );
  }
}


PopupMenuItem<PopMenuItems> buildItem(PopMenuItems item)=>PopupMenuItem<PopMenuItems>(
    value: item,
    child: Row(
      children: [
        Icon(item.icon,color: item.color,),
        Text(item.text),
      ],
    ));










