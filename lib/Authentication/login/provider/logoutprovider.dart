

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/Authentication/login/viewModel/LoginViewModel.dart';

import '../viewModel/Logoutviewmodel.dart';


final logedoutProvider = ChangeNotifierProvider.autoDispose<LogoutNotifier>((ref) => LogoutNotifier(ref));
