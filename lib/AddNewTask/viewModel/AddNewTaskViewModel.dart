


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Repository/AddNewTaskRepo.dart';

class PostNewMainTaskNotifier  extends ChangeNotifier {
  PostNewMainTaskNotifier(this.ref) :super();
  final Ref ref;
  Future AddNewMainTask( String name,String subject,String note,
      String start_date,String end_date,String time_from,String time_to,String type, int project_id) async {
    var repoRes =  await ref.read(AddNewTasksRepoProvider).addNewMainTask(name,subject,note,start_date,end_date,
        time_from,time_to,type,project_id);

    return repoRes;
  }
}

class AddNewSubTaskNotifier  extends ChangeNotifier {
  AddNewSubTaskNotifier(this.ref) :super();
  final Ref ref;
  Future AddNewSubTask( String name,String subject,String note,
      String start_date,String end_date,
      String time_from,String time_to,
      String type,int project_id ,int main_task_id ) async {
    var repoRes =  await ref.read(AddNewTasksRepoProvider).addNewSubTask(name,subject,note,start_date,end_date,
      time_from,time_to,type, project_id,main_task_id);

    return repoRes;
  }
}