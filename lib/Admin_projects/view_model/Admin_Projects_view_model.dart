
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/Admin_projects/model/Admin_ProjectModel.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';
import 'package:taskmanger/home/model/statisticsmodel.dart';
import 'package:taskmanger/home/repo/ProjectRepo.dart';
import 'package:taskmanger/home/repo/statisticRepo.dart';

import '../repo/Admin_Projectsrepo.dart';

class AdminProjectNotifier extends ChangeNotifier{
  final Ref ref;
  AdminProjectNotifier(this.ref);


  Future<AdminProjectModel>proo(int project_id)async{
    var AdminProjectRepo=await ref.read(adminprojectsrepo).getadminproject(project_id);
    debugPrint("repooooooooooooooooooproviderrradmin");
    return AdminProjectRepo;
  }
}








