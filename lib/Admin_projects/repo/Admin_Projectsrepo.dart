import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/apiService/DioClient.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';

import '../model/Admin_ProjectModel.dart';

class Admin_Projects_Repo {
  final DioClient dioClient;
  Admin_Projects_Repo(this.dioClient);

  Future<AdminProjectModel> getadminproject(int project_id) async {
    var response0 =  await dioClient.getProjectEmployees(project_id);
    debugPrint("${response0.msg}respokadmin");
    return response0;
  }
}
final adminprojectsrepo=Provider<Admin_Projects_Repo>((ref)=>Admin_Projects_Repo(DioClient()));

