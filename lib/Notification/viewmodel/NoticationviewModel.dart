import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/Notification/model/Notificationcountmodel.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';
import 'package:taskmanger/home/model/statisticsmodel.dart';
import 'package:taskmanger/home/repo/ProjectRepo.dart';
import 'package:taskmanger/home/repo/statisticRepo.dart';

import '../repo/NotificationRepo.dart';

class NotificationcountNotifier extends ChangeNotifier{
  final Ref ref;
  NotificationcountNotifier(this.ref);


  Future<NotificationCount>notcount()async{
    var Not_CountRepo=await ref.read(notificationcountrepo).getnotificationcount();
    debugPrint("repooooooooooooooooooproviderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    return Not_CountRepo;
  }
}