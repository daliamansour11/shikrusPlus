
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';
import 'package:taskmanger/home/model/statisticsmodel.dart';
import 'package:taskmanger/home/repo/ProjectRepo.dart';
import 'package:taskmanger/home/repo/statisticRepo.dart';

final proProvider = FutureProvider.autoDispose<Projectmodel>((ref) {

  return  ref.read(userrepo).getproject();});



final statisticProvider = FutureProvider.autoDispose<GetStatisticsResponse>((ref) {
//
   return  ref.read(statisticrepo).getstatistic();});