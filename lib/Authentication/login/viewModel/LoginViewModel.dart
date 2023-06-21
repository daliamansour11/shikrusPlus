


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/Authentication/login/Repository/LoginRepo.dart';
import 'package:taskmanger/Authentication/login/model/LoginModel.dart';
import 'package:taskmanger/Authentication/login/model/Users.dart';

class LoginNotifier  extends ChangeNotifier {
  LoginNotifier(this.ref) :super();
  final Ref ref;

  Future<LoginModel> onLogedIn(Users_model user) async {
    var repoRes =  await ref.read(userRepoApi).logIn(user);
    return repoRes;
  }
}