


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';

import '../repo/MainTaskRepo.dart';

////////mainTask Provider/////
class EmployeeMainTaskNotifier  extends ChangeNotifier {
  EmployeeMainTaskNotifier(this.ref) :super();
  final Ref ref;
  Future<TasksModel> EmployeeMainTask(int project_id ) async {
    var repoRes =  await ref.read(TasksRepoProvider).getEmployeeMainTasks(project_id);
    return repoRes;
  }
}
