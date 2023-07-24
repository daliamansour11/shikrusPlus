import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/apiService/DioClient.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';

import '../model/Notificationcountmodel.dart';

class MyRepo {
  final DioClient dioClient;
  MyRepo(this.dioClient);

  Future<NotificationCount> getnotificationcount() async {
    var response0 =  await dioClient.getnotificationscount();
    debugPrint("${response0}respok");
    return response0;
  }
}
final notificationcountrepo=Provider<MyRepo>((ref)=>MyRepo(DioClient()));
