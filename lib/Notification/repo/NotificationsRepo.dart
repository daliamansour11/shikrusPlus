import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/apiService/DioClient.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';

import '../model/Notificationcountmodel.dart';
import '../model/Notifications.dart';

class MyRepo {
  final DioClient dioClient;
  MyRepo(this.dioClient);

  Future<Notifications> getnotifications() async {
    var response0 =  await dioClient.getnotifications();
    print("${response0.data.length}respok");
    return response0;
  }
}
final notificationsrepo=Provider<MyRepo>((ref)=>MyRepo(DioClient()));
