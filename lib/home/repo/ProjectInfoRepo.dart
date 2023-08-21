

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../apiService/DioClient.dart';
import '../model/ProjectInfoModel.dart';

class ProjectInfoRepo {
  final DioClient dioClient;

  ProjectInfoRepo(this.dioClient);

  ///////GET EMPLOYEE MAINTASKS/////

  Future <ProjectinfoModel> getProjectInfo(int project_id) async {
    var responseData = await dioClient.getProjectInfo(project_id);
    var response = ProjectinfoModel.fromJson(responseData.toJson());
    return response;
  }

}
final ProjectInfoRepoProvider = Provider<ProjectInfoRepo>((ref) =>
    ProjectInfoRepo(DioClient()),
);