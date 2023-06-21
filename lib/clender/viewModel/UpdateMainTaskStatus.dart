
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/Repository/ClenderMainTaskRepo.dart';


///////updateStatus/////////////////////////////////
class UpdateEmployeeTaskStatusNotifier  extends ChangeNotifier {
  UpdateEmployeeTaskStatusNotifier(this.ref) :super();
  final Ref ref;
  updateTaskStatus(String status ,int? id) async {
    var repoRes =  await ref.read(TasksRepoProvider).updateEmpTaskStatus(status,id);
    return repoRes;
  }
}