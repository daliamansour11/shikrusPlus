
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:taskmanger/core/NoDataPlaceHolder.dart';
import 'package:taskmanger/core/utils.dart';
import 'package:taskmanger/reports/view/projects_reports_screen.dart';
import 'package:taskmanger/reports/view/ReportsDetailsScreen.dart';

import '../provider/ReportsProvider.dart';
import 'AddNewReports.dart';

class Reports extends ConsumerStatefulWidget {

  String report;
  String reason;
  String image;
  int id;
  Reports({
    required this.report,
    required this.reason,
    required this.image,
    required this.id,

  });
  @override
  ConsumerState<Reports> createState() => _ReportsState();

}

class _ReportsState extends ConsumerState<Reports> {
  bool? emptyPercent   ;
  String? emptyimage   ;
  @override
  Widget build(BuildContext context) {
    final reports= ref.watch(reportProvider);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>AddNewReportsScreen(project_id: widget.id,)));
        },
        backgroundColor: Color(0xFF005373),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF005373),
        title: Text("Report",style: TextStyle(
          fontSize: 25,)),
        centerTitle: true,

        automaticallyImplyLeading: true,
      ),
      body:  RefreshIndicator(
          backgroundColor: context.appTheme.bottomAppBarColor,
          onRefresh: ()  async{
            ref.refresh(reportProvider.future);

            print("updted");
            return Future.delayed(Duration(milliseconds: 300) , () =>   ref.read(reportProvider.future));

            },

        child:  Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,



    child:
          reports.when(
              data: (data) =>
                  ListView.separated(
                      itemBuilder: (context, index) {
                        String finalD = '';
                        double percentage;
                        var  progress= data.data[index].rate;


                        checkNullProgress(String value){
                          if( progress != null && progress !=""){
                            double rate =double.parse('${progress}');
                            percentage =  rate / 100;
                            print("percentageeeeeeeeeeeeee$percentage");
                          }
                          else{
                            print("Null value");

                          }
                        }
                        //  Here you get your percentage and the assign it to the percentage

                        // finalD = (percentage*100).toString();
                        //
                        // checkNullProgress(percentage);



                       // rate =  ("${rate!/100}")!;
                        return InkWell(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder:
                                    (context)=>ReportsDetailsScreen(report: '${data.data[index].report}',
                                  reason: '${data.data[index].reason}', rate: '${data.data[index].rate}',
                                      image: '${data.data[index].image}'
                                         ,
                                      project_id: '${data.data[index].projectId}',
                                      user_id: '${data.data[index].userId}',
                                      created_At: '${data.data[index].createdAt}',
                                      updated_At: '${data.data[index].updatedAt}',
                                      project_name: '${data.data[index].project.nameEn}',

                                )));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 7,top: 5,left: 7,right: 7),
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
                                        padding:
                                        const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                         "${data.data[index].report}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10, top: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Progress",
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 15),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 95.0),
                                              child: Text(" ${data.data[index].rate} %",
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 69.0,top: 10),
                                              child: Row(
                                                children: [
                                                  SizedBox(height: 15,),
                                                  CircleAvatar(

                                                      backgroundImage:emptyimage ==""?AssetImage("assets/task.jpg"):
                                                      NetworkImage("${data.data[index].image}") as ImageProvider,
                                                          // :AssetImage("assets/NoData.jpg")  as ImageProvider,
                                                      radius: 16,
                                                      backgroundColor:
                                                      Colors.grey),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 15.0),
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
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
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            LinearPercentIndicator(
                                                width: 200.0,
                                                lineHeight: 8.0,
                                                percent:.45,
                                                // checkNullProgress("$progress")??.20,
                                                progressColor: Colors.blue,
                                                linearStrokeCap:
                                                LinearStrokeCap.round

                                            )
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
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            width: double.infinity,
                            height: 1,
                          ),
                        );
                      },
                      itemCount: data.data.length),
              error: (err, _) => Text(
                "$err",
                style: TextStyle(color: Colors.red),
              ),
              loading: () => Center(child: CircularProgressIndicator()))),
    ));


  }
  checkNullProgress(double value) {
    if ( value != null&& value!=0) {
      return value;
    }else{
      value =10.0;
    }
  }
}
