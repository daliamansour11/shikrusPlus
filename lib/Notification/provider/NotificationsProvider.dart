
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';
import 'package:taskmanger/home/model/statisticsmodel.dart';
import 'package:taskmanger/home/repo/ProjectRepo.dart';
import 'package:taskmanger/home/repo/statisticRepo.dart';

import '../model/Notificationcountmodel.dart';
import '../model/Notifications.dart';
import '../repo/NotificationRepo.dart';
import '../repo/NotificationsRepo.dart';

final notificationprovider = FutureProvider.autoDispose<Notifications>((ref) {

  return  ref.read(notificationsrepo).getnotifications();});

