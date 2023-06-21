
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/AddNewTask/view/AddNewSubTask.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';
import 'package:taskmanger/core/utils.dart';
import '../../popMenuItem/PopMenuItems.dart';
import '../../clender/Provider/ClenderMainTaskProvider.dart';
import '../../clender/Provider/UpdatestatusProvider.dart';
import '../../core/Color.dart';
import '../../popMenuItem/TaskMenuItems.dart';
import '../Provider/SubTaskProvider.dart';
import '../viewModel/SubTaskViewModel.dart';

class SubTasksScreen  extends ConsumerStatefulWidget {

  int project_id;
  int main_task_id;

  SubTasksScreen({
    required this.project_id,
    required this.main_task_id,
  });
  @override
  ConsumerState<SubTasksScreen> createState() => _SubTasksScreenState();
}
class _SubTasksScreenState extends ConsumerState<SubTasksScreen> {

bool  hasData  = false ;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) async {
      Future.delayed(Duration(seconds: 1));

   ref.read(SubTaskProvider(widget.project_id));


    });
  }

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
    final subTask = ref.watch(SubTaskProvider( widget.main_task_id));
    return
    Scaffold(
      backgroundColor: Colors.grey[00],
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewSubTask(project_id: widget.project_id, main_task_id: widget.main_task_id,)));
     print("widget_iiiiiiiiiiiii ${widget.project_id}");
     print("widget_mmmmmmiiiiiiiiiiiii ${widget.main_task_id}");
      },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF005373),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF005373),
        title: Text(
          "SubTasks",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body:Container(
          margin: EdgeInsets.only(bottom: 4,left: 5,right: 5,top: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: RefreshIndicator(
    backgroundColor: context.appTheme.bottomAppBarColor,
    onRefresh: ()  async{
      await ref.refresh(SubTaskProvider( widget.main_task_id).future);
                print("updated");
    // await ref.read(MainTasksProvider.future);
    return Future.delayed(Duration(milliseconds: 300) , () => ref.read(SubTaskProvider(( widget.main_task_id))));

    },
              child:subTask.when(data: (data)=>
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(

                      color:  Color(0xFFDDE3E5),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        topLeft: Radius.circular(35),
                      ),),
                    child: ListView.builder(
                      itemCount: data!.data.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final eSubTask = data.data[index];
                        return Container(
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

                                    Text(" ${eSubTask.name}",style: TextStyle(fontSize: 20,color: Colors.black),),
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
                                            child: Text("${eSubTask.timeFrom}"

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
                                            child: Text("${eSubTask.timeTo}"
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
                        );
                      },

                    ),
                  ),
            //           :
            // Column(
            //     // mainAxisAlignment: MainAxisAlignment.center,
            //     children:[
            //       Padding(
            //         padding: const EdgeInsets.only(top: 68.0,bottom: 10),
            //         child: Text("No Sub Task Found ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            //       ),
            //        Center(
            //          child: Container(
            //        height: MediaQuery.of(context).size.width*1.5,
            //        width: MediaQuery.of(context).size.width,
            //       child: Image.asset("assets/NoData.jpg",)),
            //        ),
            //     ]),
            //


              error: (err, _) => Text("$err"),
          loading: () =>
              Center(child: CircularProgressIndicator(),)


    ))));
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










