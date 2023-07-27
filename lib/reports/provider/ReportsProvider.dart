




import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/reports/Repository/ReportsRepo.dart';

import '../model/reportsresponse.dart';
import '../viewModel/ReportsViewModel.dart';

final reportProvider = FutureProvider.autoDispose<ReportResponse>((ref) {

  return  ref.read(reportRepo).getReport();});


// final NewReportProvider = FutureProvider.autoDispose<ReportResponse?>((ref) {
//   String report="" , reason="",image =""; int project_id=0;
//   return  ref.read(reportRepo).addNewReport(report, reason, image, project_id);});


final NewReportProvider = ChangeNotifierProvider.autoDispose<NewReportNotifier>((
    ref) => NewReportNotifier(ref)
);


