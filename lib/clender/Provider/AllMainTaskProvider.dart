
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';
import 'package:taskmanger/home/viewModel/MainTaskViewModel.dart';

import '../Repository/AllMainTaskRepo.dart';
import '../model/AllMainTaskModel.dart';




////allmainTask////////////////
final AllMainTaskProvider = ChangeNotifierProvider<EmployeeMainTaskNotifier>((
    ref) =>
    EmployeeMainTaskNotifier(ref)
);


////allmainTask////////////////
final AllMainTasksProvider= FutureProvider<AllMainTaskModel>((ref) {
  var response= ref.read(AllTasksRepoProvider).getAllEmployeeMainTasks();

  print("ressssssssssssssssssssssssssssproviderrrrrrrr${response}");

  return response;
});



