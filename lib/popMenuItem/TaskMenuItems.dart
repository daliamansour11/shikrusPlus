import 'package:flutter/material.dart';
import 'package:taskmanger/popMenuItem/PopMenuItems.dart';




class TaskMenuItems {
  static  const  List<PopMenuItems> taskFirst = [
    taskComplete,
    taskInProcess,
    // taskRunning,
    // taskToDo
  ];

 static  const  taskComplete =     PopMenuItems(
      text:  "done",
      icon: Icons.check_circle,
      color: Colors.green
    );

 static const  taskRunning =   PopMenuItems(
      text: "hold",
      icon: Icons.delivery_dining,
      color: Colors.blue);
static  const  taskInProcess = PopMenuItems(
      text: "on-going",
      icon: Icons.delivery_dining,
      color: Colors.orange);
  // static  const  taskToDo = PopMenuItems(
  //     text: "toDo",
  //     icon: Icons.delivery_dining,
  //     color: Colors.orange);



}


