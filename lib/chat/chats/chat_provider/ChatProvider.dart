
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/chat/chats/chatViewModel/AllUsersViewModel.dart';
import 'package:taskmanger/chat/chats/model/UsersModel.dart';

import '../chat_repo/ChatRepo.dart';





////allusers////////////////
final AllUserProvider = ChangeNotifierProvider<AllUserNotifier>((
    ref) =>
    AllUserNotifier(ref)
);


////allusers////////////////
final ListOfUsersProvider= FutureProvider<UsersModel>((ref) =>
    ref.read(allUsersRepoProvider).getAllUsers()
);



