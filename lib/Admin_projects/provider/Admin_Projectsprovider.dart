import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Admin_ProjectModel.dart';
import '../repo/Admin_Projectsrepo.dart';
import '../view_model/Admin_Projects_view_model.dart';


final AdminprojectsProvider = FutureProvider.autoDispose<AdminProjectModel>((
    ref) { return  ref.read(adminprojectsrepo).getadminproject();}
);


// final adminprojectProvider = FutureProvider.family<AdminProjectModel?,int>((ref, projectid) {
//   var admintask= ref.read(adminprojectsrepo).getadminproject(projectid);
//   return admintask;
// });