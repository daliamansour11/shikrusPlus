
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/Authentication/login/model/LoginModel.dart';
import 'package:taskmanger/Authentication/login/model/Users.dart';
import 'package:taskmanger/apiService/ApiService.dart';

class LoginRepo {
  final ApiService apiService;
  LoginRepo(this.apiService,);

  ///Login////////////////////////////////

  Future<LoginModel> logIn(Users_model user,) async {
    var response = await apiService.logingIn(user, 'application/json');
    print(response.msg);
    print("the responseisssssssssssssssssssssssssssssssssssssssssssssssssssssssssss :${response.status}");
    return response;
  }
  ////////////////////////////////// Task /////////////////////


}
final userRepoApi = Provider<LoginRepo>((ref) =>
    LoginRepo(ApiService(Dio()),),
);
