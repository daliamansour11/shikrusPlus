import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Admin_ProjectModel.dart';
import '../repo/Admin_Projectsrepo.dart';
import '../view_model/Admin_Projects_view_model.dart';

final AdminprojectsProvider = ChangeNotifierProvider.autoDispose<AdminProjectNotifier>((
    ref) =>
    AdminProjectNotifier(ref)
);


final adminprojectProvider = FutureProvider.family<AdminProjectModel?,int>((ref, main_task_id) {
  var subtasks= ref.read(adminprojectsrepo).getadminproject(main_task_id);
  return subtasks;
});