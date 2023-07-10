import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/chat/chats/model/UsersModel.dart';
import 'package:taskmanger/clender/Repository/ClenderMainTaskRepo.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';

import '../chat_repo/ChatRepo.dart';

////////mainTask Provider/////
class AllUserNotifier  extends ChangeNotifier {
  AllUserNotifier(this.ref) :super();
  final Ref ref;
  Future<UsersModel> getAllUsers( ) async {
    var repoRes =  await ref.read(allUsersRepoProvider).getAllUsers();
    return repoRes;
  }
}