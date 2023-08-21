

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/ProjectInfoModel.dart';
import '../repo/ProjectInfoRepo.dart';

final ProjectinfoProvider= FutureProvider.family<ProjectinfoModel,int>((ref,project_id) {

  return ref.read(ProjectInfoRepoProvider).getProjectInfo(project_id);
}
);