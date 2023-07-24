
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';
import 'package:taskmanger/home/model/statisticsmodel.dart';
import 'package:taskmanger/home/repo/ProjectRepo.dart';
import 'package:taskmanger/home/repo/statisticRepo.dart';

import '../model/Notificationcountmodel.dart';
import '../repo/NotificationRepo.dart';

final not_countProvider = FutureProvider.autoDispose<NotificationCount>((ref) {

  return  ref.read(notificationcountrepo).getnotificationcount();});

