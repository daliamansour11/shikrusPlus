import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';

import '../model/ProjectInfoModel.dart';
import '../repo/MainTaskRepo.dart';
import '../repo/ProjectInfoRepo.dart';

////////mainTask Provider/////
class ProjectInfoNotifier  extends ChangeNotifier {
  ProjectInfoNotifier(this.ref) :super();
  final Ref ref;
  Future<ProjectinfoModel> EmployeeMainTask(int project_id ) async {
    var repoRes =  await ref.read(ProjectInfoRepoProvider).getProjectInfo(project_id);
    return repoRes;
  }
}