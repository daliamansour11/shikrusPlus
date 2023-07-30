
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/Authentication/login/model/LoginModel.dart';
import 'package:taskmanger/Authentication/login/model/Users.dart';
import 'package:taskmanger/Authentication/login/model/logoutmodel.dart';
import 'package:taskmanger/apiService/ApiService.dart';

import '../../../apiService/DioClient.dart';

class LogoutRepo {
  final DioClient dioClient;

  LogoutRepo(this.dioClient);

  ///Login////////////////////////////////

  Future<Logoutresponse?> logout() async {
    var response = await dioClient.getlogout();
    print(response?.msg);
    print("the responseisssssssssssssssssssssssssssssssssssssssssssssssssssssssssss :${response?.msg}");
    return response;
  }
////////////////////////////////// Task /////////////////////


}
final logoutRepoApi = Provider<LogoutRepo>((ref) => LogoutRepo(DioClient()),
);
