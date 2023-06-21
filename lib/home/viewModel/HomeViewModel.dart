
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';
import 'package:taskmanger/home/model/statisticsmodel.dart';
import 'package:taskmanger/home/repo/ProjectRepo.dart';
import 'package:taskmanger/home/repo/statisticRepo.dart';

class ProjectNotifier extends ChangeNotifier{
  final Ref ref;
  ProjectNotifier(this.ref);


  Future<Projectmodel>proo()async{
    var ProjectRepo=await ref.read(userrepo).getproject();
    debugPrint("repooooooooooooooooooproviderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    return ProjectRepo;
  }
}






class StatisticsNotifier extends ChangeNotifier{
  final Ref ref;
  StatisticsNotifier(this.ref);


  Future<GetStatisticsResponse>proo()async{
    var StatisticRepo=await ref.read(statisticrepo).getstatistic();
    debugPrint("repooooooooooooooooooproviderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    return StatisticRepo;
  }
}


