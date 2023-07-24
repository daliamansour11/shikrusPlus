import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/apiService/DioClient.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';

class MyRepo {
  final DioClient dioClient;
  MyRepo(this.dioClient);

  Future<Projectmodel> getproject() async {
    var response0 =  await dioClient.getAllProjects();
    debugPrint("${response0}respok");
    return response0;
  }
}
final userrepo=Provider<MyRepo>((ref)=>MyRepo(DioClient()));

