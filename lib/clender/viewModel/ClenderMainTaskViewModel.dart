


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/Repository/ClenderMainTaskRepo.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';

////////mainTask Provider/////
class EmployeeMainTaskNotifier  extends ChangeNotifier {
  EmployeeMainTaskNotifier(this.ref) :super();
  final Ref ref;
  Future<TasksModel> EmployeeMainTask( ) async {
    var repoRes =  await ref.read(TasksRepoProvider).getEmployeeMainTasks();
    return repoRes;
  }
}
