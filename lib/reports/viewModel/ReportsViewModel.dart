
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/reports/Repository/ReportsRepo.dart';
import 'package:taskmanger/reports/model/reportsresponse.dart';

class StatisticsNotifier extends ChangeNotifier{
  final Ref ref;
  StatisticsNotifier(this.ref);


  Future<ReportResponse>proo()async{
    var ReportRepo=await ref.read(reportRepo).getReport();
    debugPrint("repooooooooooooooooooproviderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    return ReportRepo;
  }
}


class NewReportNotifier extends ChangeNotifier{
  final Ref ref;
  NewReportNotifier(this.ref);

  Future<ReportResponse?> AddNewReport(String report, String reason,
      File image, int project_id)async{
    var ReportRepo=await ref.read(reportRepo).addNewReport(report, reason, image, project_id);
    debugPrint("repooooooooooooooooooproviderrrrrrrrrrrrrrrrrrrrrrrr");
    return ReportRepo;
  }
}

