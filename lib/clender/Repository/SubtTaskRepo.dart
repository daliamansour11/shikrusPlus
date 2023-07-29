import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/Provider/SubTaskProvider.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';

import '../../apiService/DioClient.dart';

class SubTasksRepo {
  final DioClient dioClient;
  SubTasksRepo(this.dioClient);
  ///////GET EMPLOYEE SUBTASKS/////
  Future <TasksModel?> getEmployeeSubTasks(int main_task_id) async {
    var responseData = await dioClient.getEmployeeSubTasks(main_task_id);
    // var response = TasksModel.fromJson(responseData!.toJson());
    return responseData;
  }
}

 final SubTasksRepoProvider = Provider<SubTasksRepo>((ref) =>
     SubTasksRepo(DioClient()),
);


