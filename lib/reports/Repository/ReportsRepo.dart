
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../apiService/DioClient.dart';
import '../model/reportsresponse.dart';

class ReportsRepo {
  final DioClient dioClient;


  ReportsRepo(this.dioClient);



  Future<ReportResponse> getReport() async {
    var response =  await dioClient.getReport();
    // var static=GetStatisticsResponse.fromJson(response.toJson());
    debugPrint("${response}");
    return response;
  }
  Future<ReportResponse?> addNewReport(String report, String reason,
  File  image, int project_id

      ) async {
    var response =  await dioClient.addNewReport(report, reason, image, project_id);
    // var static=GetStatisticsResponse.fromJson(response.toJson());
    debugPrint("${response?.status}");
    return response
    ;
  }


}
final reportRepo=Provider<ReportsRepo>((ref)=>ReportsRepo(DioClient()));

