





import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/model/ResponseModel.dart';
import 'package:taskmanger/clender/model/StateModel.dart';

import '../Repository/SubtTaskRepo.dart';
import '../model/TasksModel.dart';



// class EmployeeSubTaskNotifier  extends ChangeNotifier {
//   EmployeeSubTaskNotifier(this.ref) :super();
//   final Ref ref;
//   Future<TasksModel?> EmployeeMainTask(int project_id,int main_task_id ) async {
//     var repoRes =  await ref.read(SubTasksRepoProvider).getEmployeeSubTasks(project_id, main_task_id);
//     return repoRes;
//   }
// }

// class SubTaskProviderNotifier extends ChangeNotifier{
//   final Ref ref;
//   TasksModel tasksModel = TasksModel();
//   SubTaskProviderNotifier(this.ref);
//
//
//   Future<TasksModel?>subTasksNotifier()async{
//
//     var subTasksProvider=await ref.read(SubTasksRepoProvider).getEmployeeSubTasks();
//     debugPrint("repooooooooooooooooooproviderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${subTasksProvider?.status}");
//     return subTasksProvider;
//   }
// }




//
// class GetSubTask extends StateNotifier<StateModel<List<TasksModel>>> {
//   final Ref ref;
//   final SubTasksRepo subTasksRepo;
//   GetSubTask(this.ref, this.subTasksRepo): super(StateModel());
//
//   void getSubTask( int main_task_id,) async {
//     state = StateModel(state: DataState.LOADING);
//     ResponseModel? responseModel = (await subTasksRepo.getEmployeeSubTasks(main_task_id,)) as ResponseModel?;
//     if(responseModel?.isSuccess == true){
//     List<TasksModel> tasksModel = TasksModel.fromJson(responseModel?.data) as List<TasksModel>;
//       state = StateModel(state: DataState.SUCCESS , data: tasksModel );
//        // tasksModel.data?.add(tasksModel1);
//     }else{
//       state = StateModel(state: DataState.ERROR , message: responseModel?.message);
//     }
//   }
//
// }
// class GetSubTask extends StateNotifier<StateModel<TasksModel>> {
//   final Ref ref;
//   final SubTasksRepo subTasksRepo;
//   GetSubTask(this.ref, this.subTasksRepo): super(StateModel());
//
//   void getEmployeeSubTasks(int mainTask_id , ) async {
//     state = StateModel(state: DataState.LOADING);
//     ResponseModel responseModel = (await subTasksRepo.getEmployeeSubTasks(mainTask_id)) as ResponseModel ;
//     if(responseModel.isSuccess == true){
//       TasksModel? subTask ;
//       // //TasksModel.fromJson(responseModel.data);
//       if(subTask?.status==false){
//         state = StateModel(state: DataState.EMPTY);
//       }else{
//         state = StateModel(state: DataState.SUCCESS,data : subTask);
//       }
//     }else{
//       state = StateModel(state: DataState.ERROR , message: responseModel.message);
//     }
//   }
// }

