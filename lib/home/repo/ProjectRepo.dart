

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/apiService/DioClient.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';


class MyRepo {
  final DioClient dioClient;

  // final Webservice webservice;

  MyRepo(this.dioClient);

  // Future<Usermodel> loginUser(Users_model user) async {
  //
  //     var response =  await webservice.checkUser(user);
  //      return response;
  // }

  Future<Projectmodel> getproject() async {

    var response0 =  await dioClient.getAllProjects();
    debugPrint("${response0}");
    return response0;
  }

// Future<Projectmodel> getprojects() async {
//
//   var response =  await webservice.getAllProjects("Bearer Ws0nyRlKh7RJpPxXrhBojKEobkWjDJq4W2ORrUVG");
//   debugPrint("${response}");
//
//   return response;
// }
}
final userrepo=Provider<MyRepo>((ref)=>MyRepo(DioClient()));

