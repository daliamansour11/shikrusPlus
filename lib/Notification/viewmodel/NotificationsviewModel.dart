import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/Notification/model/Notificationcountmodel.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';
import 'package:taskmanger/home/model/statisticsmodel.dart';
import 'package:taskmanger/home/repo/ProjectRepo.dart';
import 'package:taskmanger/home/repo/statisticRepo.dart';

import '../model/Notifications.dart';
import '../repo/NotificationRepo.dart';
import '../repo/NotificationsRepo.dart';

class NotificationsNotifier extends ChangeNotifier{
  final Ref ref;
  NotificationsNotifier(this.ref);


  Future<Notifications>notifications()async{
    var Not_Repo=await ref.read(notificationsrepo).getnotifications();
    debugPrint("repooooooooooooooooooproviderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    return Not_Repo;
  }
}