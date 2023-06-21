

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/apiService/DioClient.dart';

import '../model/statisticsmodel.dart';


class StatisticRepo {
  final DioClient dioClient;

  // final Webservice webservice;

  StatisticRepo(this.dioClient);



  Future<GetStatisticsResponse> getstatistic() async {
    var response =  await dioClient.gettaskestatistics();
   // var static=GetStatisticsResponse.fromJson(response.toJson());
    debugPrint("${response}");
    return response;
  }


}
final statisticrepo=Provider<StatisticRepo>((ref)=>StatisticRepo(DioClient()));

