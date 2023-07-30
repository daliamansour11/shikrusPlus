


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/Authentication/login/Repository/LoginRepo.dart';
import 'package:taskmanger/Authentication/login/model/LoginModel.dart';
import 'package:taskmanger/Authentication/login/model/Users.dart';
import 'package:taskmanger/Authentication/login/model/logoutmodel.dart';

import '../Repository/logoutRepo.dart';


class LogoutNotifier  extends ChangeNotifier {
  LogoutNotifier(this.ref) :super();
  final Ref ref;

  Future<Logoutresponse?> onLogedout() async {
    var repoReslogout =  await ref.read(logoutRepoApi).logout();
    return repoReslogout;
  }


}