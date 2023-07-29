
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Repository/AllMainTaskRepo.dart';


///////updateStatus/////////////////////////////////
class UpdateEmployeeTaskStatusNotifier  extends ChangeNotifier {
  UpdateEmployeeTaskStatusNotifier(this.ref) :super();
  final Ref ref;
  updateTaskStatus(String status ,int? id) async {
    var repoRes =  await ref.read(AllTasksRepoProvider).updateEmpTaskStatus(status,id);
    return repoRes;
  }
}