


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';
import '../../apiService/DioClient.dart';

class MainTasksRepo {
  final DioClient dioClient;
  MainTasksRepo( this.dioClient);

  ///////GET EMPLOYEE MAINTASKS/////

  Future <TasksModel>getEmployeeMainTasks(int project_id) async{
    var responseData = await dioClient.getEmployeeMainTasks( project_id);
    var response= TasksModel .fromJson(responseData!.toJson());
    return response;
  }


  // ///////GET EMPLOYEE SUBTASKS/////
  // Future <TasksModel?>getEmployeeSubTasks() async{
  //   var responseData = await dioClient.getEmployeeSubTasks( );
  //   var response= TasksModel .fromJson(responseData!.toJson());
  //   return responseData;
  // }
  ///////POST EMPLOYEE TASKS/////

  postEmployeeTask(String name,String subject,String note,
      String start_date,String end_date,String time_from,String time_to,String type,int project_id ) async{
    var responseData = await dioClient.AddNewMainTask( name,subject,note,start_date,end_date,
        time_from,time_to,type,project_id );

    return responseData;
  }

  ///////updateTaskStatus/////////
  updateEmpTaskStatus(String status ,int? id) async{
    var responseData = await dioClient.upDateEmployeeTasksStatus(status,id);

    return responseData;
  }


}


final TasksRepoProvider = Provider<MainTasksRepo>((ref) =>
    MainTasksRepo(DioClient()),
);
