
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:date_time_line/date_time_line.dart';
import 'package:taskmanger/clender/Provider/AllMainTaskProvider.dart';
import 'package:taskmanger/core/utils.dart';

import '../../core/Color.dart';
import '../../popMenuItem/PopMenuItems.dart';
import '../../popMenuItem/TaskMenuItems.dart';
import '../Provider/UpdatestatusProvider.dart';
import 'SubTasksScreen.dart';

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

      if( _selectedDate == DateTime.now()){

        ref.refresh(AllMainTasksProvider);
        return  await Future.delayed(Duration(milliseconds: 300) , () =>    ref.read(AllMainTasksProvider.future));
      }


    });
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DatePickerController _datePickerController = DatePickerController();
    final userTask = ref.watch(AllMainTasksProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF005373),
          title: Text(
            "Calendar",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: 10, bottom: 15, right: 3, left: 10),
          child: Column(children: [
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(),
                child: DateTimeLine(
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF005373),
                  hintText: "10 task today",
                  onSelected: (value) {
                    setState(() {
                      _selectedDate = value;
                      setState(() {
                        _selectedDate;
                      });
                    },
                    );
                  },
                ),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 180),
              child: Text("Daily tasks",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
                height: 380,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.grey[300],
                ),

                child:_listEmployeeTask(context)
            )

          ]),
        ));
  }
  onStatusChang(String status){
    if(  status== "done"  ){
      return     Itemcolors[0];
    }else if(status== "on-going" ){
      return   Itemcolors[3];
    }
    else if(status== "to-do" ){
      return  Itemcolors[2];
    }  else if(status== "hold" ){
      return  Itemcolors[1];
    }
  }

  _listEmployeeTask(BuildContext context){
    final userTask = ref.watch(AllMainTasksProvider);
    return   RefreshIndicator(
        backgroundColor: context.appTheme.bottomAppBarColor,
        onRefresh: ()  async{
          ref.refresh(AllMainTasksProvider);
          return Future.delayed(Duration(milliseconds: 300) , () =>   ref.read(AllMainTasksProvider.future));
        },

        child:
        Container(
          child: userTask.when(data: (data) =>
          data.data.length==0?Container(
            child: Image.network('https://www.tawuniya.com/product/static/media/policy-success%20copy'
                '.33bdcbf4e0b3bd58972a06016ab561af.svg'),
            // fit: BoxFit.cover,
          )
              : ListView.builder(
              itemCount: data.data.length,
              itemBuilder: (context, index) {
                final empTask = data.data[index];
                var expectedExpiryDate= DateTime(empTask.expectedExpiryDate?.year ?? 0,empTask.expectedExpiryDate?.month ?? 0 , empTask.expectedExpiryDate?.day ?? 0);
                var startDate= DateTime(empTask.startingDate?.year ?? 0,empTask.startingDate?.month ?? 0 , empTask.startingDate?.day ?? 0);
                List<DateTime> taskRange= getDaysInBetween(startDate, expectedExpiryDate);
                print(empTask.toJson());
                _selectedDate = DateTime(_selectedDate.year , _selectedDate.month , _selectedDate.day);
                if(startDate.isAtSameMomentAs(_selectedDate)&&startDate.isAfter(_selectedDate) ||taskRange.contains(_selectedDate) ||
                    expectedExpiryDate.isAtSameMomentAs(_selectedDate)
                        &&expectedExpiryDate.isAfter(_selectedDate)){
                  var status =empTask.status;
                  return  Row(
                    children: <Widget>[
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Text("${empTask.timeFrom}", style:
                            TextStyle(fontSize: 10,
                              fontWeight: FontWeight.w400,),),
                            SizedBox(height: 30,),
                            Text("${empTask.timeTo}",
                              style: TextStyle(fontSize: 10,
                                fontWeight: FontWeight.w400,),),
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Column(
                        children: [
                          Container(
                            width: 4,
                            height: 50,
                            color: Colors.purple,
                            //  index ==0 ?Colors.purple :Colors.black,
                          ),
                          SizedBox(height: 4,),
                          Container(
                            margin: EdgeInsets.only(
                              left: 5, right: 5,),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.purple,
                                  width: 4),
                              color: index == 0 ? Colors
                                  .purple : Colors.white,
                              borderRadius: BorderRadius
                                  .circular(50),
                            ),
                          ),
                          SizedBox(height: 4,),
                          Container(
                              width: 4,
                              height: 50,
                              //  color:index == emptask.length-1 ?Colors.purple :Colors.black,
                              color: Colors.purple
                            // index ==1?Colors.purple :Colors.black,
                          ),
                        ],
                      ),
                      Expanded(
                          flex:6,
                          child:
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: InkWell(
                              onTap:(){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>SubTasksScreen(
                                      taskname:data.data[index].name ,
                                      note:data.data[index].notes ,
                                      description:data.data[index].subject ,
                                      startdate:data.data[index].startingDate ,enddate: data.data[index].expectedExpiryDate,
                                      project_id:int.parse('${data.data[index].project.id}'), main_task_id: data.data[index].id,)));
                                print("idddddd${data.data[index].id}");
                                print("idddddd${data.data[index].project.id}");
                              },
                              child: Container(
                                // width: 90,
                                  margin: EdgeInsets.only(
                                      left: 8, top: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color  : onStatusChang(status!)
                                  ),
                                  height: 100,
                                  width: 100,
                                  child:ListTile(
                                    title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${empTask.name}",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),),
                                          PopupMenuButton<PopMenuItems>(
                                              shape: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              itemBuilder:(context)=> [
                                                ...TaskMenuItems.taskFirst.map((buildItem)
                                                ).toList(),
                                              ],
                                              onSelected: (   PopMenuItems item) async {
                                                final  updateTask =ref.read(updateTaskProvider );
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
                                          child: Text(
                                            "${empTask.status}",
                                            style:
                                            TextStyle(fontSize: 12,
                                                fontWeight: FontWeight
                                                    .w500,
                                                color: Colors
                                                    .white),),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 30),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 1.0,
                                                    right: 4,
                                                    top: 4,bottom: 20),
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
                                                    top: 4,bottom: 20),
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
                                                    top: 4,bottom: 20),
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
                                                      left: 1.0, top: 4,bottom: 20),
                                                  child: Text("${empTask.timeFrom}",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .white),)
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: 2.0, top: 4,bottom: 20),
                                                  child: Text("-",style: TextStyle(color: Colors.white),)
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .only(left: 5.0,
                                                      right: 1,
                                                      top:4,bottom: 20),
                                                  child: Text("${empTask.timeTo}",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Colors.white),)
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          )
                      )],
                  );

                }
                else{
                  return Center(
                  );
                }
              }
          ),
              error: (err, _) => Text("$err"),
              loading: () =>
                  Center(child: CircularProgressIndicator(),)),
        )
    );}
  PopupMenuItem<PopMenuItems> buildItem(PopMenuItems item)=>PopupMenuItem<PopMenuItems>(
      value: item,
      child: Row(
        children: [
          Icon(item.icon,color: item.color,),
          Text(item.text),
        ],
      ));
}
