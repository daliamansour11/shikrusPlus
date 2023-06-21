




import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/Repository/SubtTaskRepo.dart';
import 'package:taskmanger/clender/model/StateModel.dart';
import 'package:taskmanger/home/model/statisticsmodel.dart';

import '../model/TasksModel.dart';
import '../viewModel/SubTaskViewModel.dart';

final SubTaskProvider = FutureProvider.family<TasksModel?,int>((ref, main_task_id) {

  var subtasks= ref.read(SubTasksRepoProvider).getEmployeeSubTasks(main_task_id);
  return subtasks;
});

//
//
// final getSubTasksNotifier = StateNotifierProvider<GetSubTask,StateModel<TasksModel>>((ref) {
//   return GetSubTask (ref,ref.watch(SubTasksRepoProvider));
// });
// final getSubTasksNotifier = StateNotifierProvider<GetSubTask,StateModel<List<TasksModel>>>((ref) {
//   return GetSubTask(ref, ref.watch(SubTasksRepoProvider));
// });


// final subTasksProvider = ChangeNotifierProvider.autoDispose<SubTaskProviderNotifier>((
//     ref) =>
//     SubTaskProviderNotifier (ref)
// );





