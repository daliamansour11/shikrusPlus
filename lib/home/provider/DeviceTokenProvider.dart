


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/home/repo/DeviceTokenRepo.dart';

import '../viewModel/DeviceTokenViewModel.dart';



final deviceTokenProvider = ChangeNotifierProvider.autoDispose<DeviceTokenNotifier>((
    ref) =>
    DeviceTokenNotifier(ref)
);
