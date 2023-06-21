
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/core/utils.dart';
import '../../AddNewTask/view/Addtask.dart';
import '../../core/ContainerWidget.dart';
import '../../popMenuItem/PopMenuItems.dart';
import '../../clender/Provider/ClenderMainTaskProvider.dart';
import '../../clender/Provider/UpdatestatusProvider.dart';
import '../../core/Color.dart';
import '../../popMenuItem/TaskMenuItems.dart';
import 'detailsscreen.dart';

class ProjectsTasksScreen  extends ConsumerStatefulWidget {

  int project_id;
  ProjectsTasksScreen({
    required this.project_id,
  });
  @override
  ConsumerState<ProjectsTasksScreen> createState() => _ProjectsTasksScreenState();
}
class _ProjectsTasksScreenState extends ConsumerState<ProjectsTasksScreen> {


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
    final projectMainTask = ref.watch(MainTasksProvider);

    return Scaffold(

        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen(project_id: widget.project_id)));
        },child: Icon(Icons.add),
          backgroundColor: Color(0xFF005373),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF005373),
          title: Text(
            "ProjectsTasks",
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
              await ref.refresh(MainTasksProvider);
              // ref.read(SubTaskProvider( widget.main_task_id).future);
              print("updated");
              // await ref.read(MainTasksProvider.future);
              return Future.delayed(Duration(milliseconds: 300) , () => ref.read(MainTasksProvider));
            },
            child:projectMainTask.when(data: (data)=>   ListView.builder(
                    itemCount: data.data.length??0,

                    itemBuilder: (context, index) {
                      final empTask = data.data[index];
                      print(" ptoject_id ${data.data[index].projectId}");
                      print("iddddd ${widget.project_id}");
                      return Container(

                          child:   InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => Detailsscreen(name: "${data.data[index].name}",
                                    subject: '${data.data[index].subject}', startDate: '${data.data[index].startingDate}', endDate: '${data.data[index].expectedExpiryDate}', status: '${data.data[index].status}', notes: '${data.data[index].notes}',)));
                            },
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20)
                                  ),
                                  side: BorderSide(width: 1,color: Color(0xFFD8E3E7))),
                              color: Color(0xFFD3D5D5),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 0.0),
                                        child: Container(
                                          // width: 90,
                                          //   margin: EdgeInsets.only(left: , top: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                                color  : onStatusChang(data.data[index].status!)
                                            ),
                                            height: 130,
                                            width: 100,
                                            child: ListTile(

                                              title: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    Text(" ${empTask.name}",style: TextStyle(fontSize: 20,color: Colors.black),),
                                                    PopupMenuButton<PopMenuItems>(
                                                        shape: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        itemBuilder:(context)=> [
                                                          ...TaskMenuItems.taskFirst.map((buildItem)
                                                          ).toList(),
                                                        ],
                                                        onSelected: (   PopMenuItems item) async {
                                                          final  updateTask =ref.read(updateTaskProvider);
                                                          // final  empTaskProvider =ref.read(userTaskProvider);

                                                          switch (item) {
                                                            case TaskMenuItems
                                                                .taskComplete:

                                                              print(item.text);
                                                              String status = item.text;
                                                              updateTask
                                                                  .updateTaskStatus(status,data.data[index].id);
                                                              // empTaskProvider.EmployeeTask();
                                                              break;

                                                            case TaskMenuItems
                                                                .taskInProcess:
                                                              updateTask.updateTaskStatus(item.text,data.data[index].id);
                                                              // empTaskProvider.EmployeeTask();
                                                              break;
                                                          }
                                                        }
                                                    )
                                                  ] ),
                                              subtitle:Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        left: 10, right: 10,top: 0),
                                                    child: Text("${data.data[index].status}",
                                                      // "${empTask.status}",
                                                      style:
                                                      TextStyle(fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          color: Colors
                                                              .white),),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 35),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 1.0,
                                                              right: 4,
                                                              top: 0,bottom: 20),
                                                          child: CircleAvatar(
                                                              backgroundImage: AssetImage(
                                                                "assets/personn.jpg",
                                                              ),
                                                              radius: 10,
                                                              backgroundColor: Colors
                                                                  .white60),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 1.0,
                                                              right: 4,
                                                              top: 0,bottom: 20),
                                                          child: CircleAvatar(
                                                              backgroundImage: AssetImage(
                                                                "assets/ppr.jpg",
                                                              ),
                                                              radius: 10,
                                                              backgroundColor: Colors
                                                                  .white60),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 1.0,
                                                              right: 4,
                                                              top: 0,bottom: 20),
                                                          child: CircleAvatar(
                                                              backgroundImage: AssetImage(
                                                                "assets/ppr.jpg",
                                                              ),
                                                              radius: 10,
                                                              backgroundColor: Colors
                                                                  .white60),
                                                        ),
                                                        SizedBox(width: 34,),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(left: 1.0,
                                                              right: 4,
                                                              top: 0,bottom: 20),
                                                          child: Icon(Icons
                                                              .access_time_filled,
                                                            color: Colors.white,
                                                            size: 12,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                left: 1.0, top: 0,bottom: 20),
                                                            child: Text("${empTask.timeFrom}"

                                                              ,
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  color: Colors
                                                                      .black),)
                                                        ),
                                                        Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                left: 2.0, top: 0,bottom: 20),
                                                            child: Text("-",style: TextStyle(color: Colors.white),)
                                                        ),
                                                        Padding(
                                                            padding: const EdgeInsets
                                                                .only(left: 5.0,
                                                                right: 1,
                                                                top:0 ,bottom: 20),
                                                            child: Text("${empTask.timeTo}"
                                                              // ""
                                                              ,
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  color: Colors.black),)
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          // :Container(),)
                                        ),
                                      )
                                  )],
                              ),
                            ),
                          ));
                    }
                ),

                error: (err, _) => Text("$err"),loading: () =>
                    Center(child: CircularProgressIndicator(),)
            )
        ));
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










