import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:taskmanger/Authentication/login/model/LoginModel.dart';
import 'package:taskmanger/Authentication/login/model/Users.dart';

import 'package:taskmanger/clender/model/TasksModel.dart';

part 'ApiService.g.dart';

@RestApi(baseUrl: "https://shapi.webautobazaar.com/api/")

abstract class ApiService {

  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
  // @GET("users")
  // Future<List<User>> getUsers();
  //
  //
  @GET("employee/tasks/{id}")
  Future<TasksModel>getemployeeTask(@Path("id") @Header("Authrization") String userId);
  //
  @POST("app-login")
  Future<LoginModel>logingIn(@Body() Users_model newUser,@Header('Content-Type') String content_type);
}




