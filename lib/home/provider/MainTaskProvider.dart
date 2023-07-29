
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';
import 'package:taskmanger/home/viewModel/MainTaskViewModel.dart';

import '../repo/MainTaskRepo.dart';




////mainTask////////////////
final MainTaskProvider = ChangeNotifierProvider<EmployeeMainTaskNotifier>((
    ref) =>
    EmployeeMainTaskNotifier(ref)
);


////mainTask////////////////
final MainTasksProvider= FutureProvider.family<TasksModel,int>((ref,project_id) =>
    ref.read(TasksRepoProvider).getEmployeeMainTasks(project_id)
);



