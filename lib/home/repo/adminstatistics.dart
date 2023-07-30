

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/apiService/DioClient.dart';

import '../model/statisticsadminmodel.dart';
import '../model/statisticsmodel.dart';


class StatisticAdminRepo {
  final DioClient dioClient;

  // final Webservice webservice;

  StatisticAdminRepo(this.dioClient);



  Future<GetStatisticsAdminResponse> getadminstatistic() async {
    var response =  await dioClient.askstatisticsadmin();
    // var static=GetStatisticsResponse.fromJson(response.toJson());
    debugPrint("${response.status}statisticssssss");
    return response;
  }


}
final statisticadminrepo=Provider<StatisticAdminRepo>((ref)=>StatisticAdminRepo(DioClient()));

