

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/Authentication/login/viewModel/LoginViewModel.dart';


final logedInProvider = ChangeNotifierProvider.autoDispose<LoginNotifier>((ref) => LoginNotifier(ref));
