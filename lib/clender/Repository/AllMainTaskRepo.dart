


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';
import '../../apiService/DioClient.dart';
import '../model/AllMainTaskModel.dart';

class AllMainTasksRepo {
  final DioClient dioClient;
  AllMainTasksRepo( this.dioClient);

  ///////GET All EMPLOYEE MAINTASKS/////

  Future <AllMainTaskModel>getAllEmployeeMainTasks() async{
    var responseData = await dioClient.getAllEmployeeMainTasks( );
    var response= AllMainTaskModel .fromJson(responseData!.toJson());
    print("ressssssssssssssssssssssssssss${response.data}");
    return response;
  }


  // ///////GET EMPLOYEE SUBTASKS/////
  // Future <TasksModel?>getEmployeeSubTasks() async{//   var responseData = await dioClient.getEmployeeSubTasks( );
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


final AllTasksRepoProvider = Provider<AllMainTasksRepo>((ref) =>
    AllMainTasksRepo(DioClient()),
);
