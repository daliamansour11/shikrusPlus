
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/Repository/ClenderMainTaskRepo.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';
import 'package:taskmanger/clender/viewModel/ClenderMainTaskViewModel.dart';




////mainTask////////////////
final MainTaskProvider = ChangeNotifierProvider<EmployeeMainTaskNotifier>((
    ref) =>
    EmployeeMainTaskNotifier(ref)
);


////mainTask////////////////
final MainTasksProvider= FutureProvider<TasksModel>((ref) =>
    ref.read(TasksRepoProvider).getEmployeeMainTasks()
);



