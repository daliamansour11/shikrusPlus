

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/Authentication/login/model/Users.dart';
import 'package:taskmanger/chat/chats/model/UsersModel.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';
import '../../../apiService/DioClient.dart';

class AllUsersRepo {
  final DioClient dioClient;
  AllUsersRepo( this.dioClient);

  ///////GET EMPLOYEE MAINTASKS/////

  Future <UsersModel>getAllUsers() async{
    var responseData = await dioClient.getAllUsers( );
    var response= UsersModel .fromJson(responseData.toJson());
    return response;
  }




}
final allUsersRepoProvider = Provider<AllUsersRepo>((ref) =>
    AllUsersRepo(DioClient()),
);