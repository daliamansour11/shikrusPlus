import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Repository/AddNewAdminTaskRepo.dart';
import '../Repository/AddNewTaskRepo.dart';

class PostNewMainTaskAdminNotifier  extends ChangeNotifier {
  PostNewMainTaskAdminNotifier(this.ref) :super();
  final Ref ref;
  Future AddNewMainAdminTask( String name,String subject,String note,
      String start_date,String end_date,String time_from,String time_to,String type, int project_id,int employeeid) async {
    var repoRes =  await ref.read(AddNewTasksAdminRepoProvider).addNewMainAdminTask(name,subject,note,start_date,end_date,
        time_from,time_to,type,project_id,employeeid);
    print("${repoRes}");

    return repoRes;
  }
}