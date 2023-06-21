
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/core/utils.dart';
import 'package:taskmanger/home/view/ProjectsTasksScreen.dart';
import '../../popMenuItem/PopMenuItems.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../core/Color.dart';
import '../provider/HomeProvider.dart';

class ProjectsScreen  extends ConsumerStatefulWidget {


  @override
  ConsumerState<ProjectsScreen> createState() => _ProjectsScreenState();
}
class _ProjectsScreenState extends ConsumerState<ProjectsScreen> {


  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPersistentFrameCallback((_) async {
  //     Future.delayed(Duration(seconds: 1));
  //
  //  / ref.read(MainTasksProvider);
  //
  //
  //   });
  // }

  onStatusChang(String status) {
    if (status == "done") {
      return Itemcolors[0];
    } else if (status == "on-going") {
      return Itemcolors[3];
    }
    else if (status == "to-do") {
      return Itemcolors[2];
    } else if (status == "hold") {
      return Itemcolors[1];
    }
  }
  @override
  Widget build(BuildContext context) {
    final projects = ref.watch(proProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF005373),
          title: Text(
            "All Projects",
            style: TextStyle(
              fontSize: 25,

            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProjectsTasksScreen(project_id: data.data[index].id,)));
                   print("pro_idddd${data.data[index].id}");

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
                                    padding:
                                    const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      usersData.name ?? " ",
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
                                        left: 10.0, right: 10, top: 0),
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
                                          child: Text(
                                            "45%"??
                                                " ",
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 15),
                                          ),
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
                                            percent: 0.45,
                                            progressColor: Colors.blue,
                                            linearStrokeCap:
                                            LinearStrokeCap.round
                                          // LinearPercentIndicator(
                                          //   width: 200.0,
                                          //
                                          //   lineHeight: 14.0,
                                          //   percent: 0.5,
                                          //   center: Text(
                                          //     "",
                                          //     style: new TextStyle(fontSize: 12.0),
                                          //   ),
                                          //   // trailing: Icon(Icons.mood),
                                          //   linearStrokeCap: LinearStrokeCap.roundAll,
                                          //   backgroundColor: Colors.grey,
                                          //   progressColor: Colors.blue,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 5.0,
                                                  right: 10),
                                              child: Icon(
                                                Icons.access_time_filled,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Text(usersData
                                                    .startingDate!.year
                                                    .toString() +
                                                    "-" +
                                                    usersData.startingDate!
                                                        .month
                                                        .toString() +
                                                    "-" +
                                                    usersData
                                                        .startingDate!.day
                                                        .toString())),
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










