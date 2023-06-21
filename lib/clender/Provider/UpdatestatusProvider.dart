



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/viewModel/UpdateMainTaskStatus.dart';

final updateTaskProvider = ChangeNotifierProvider.autoDispose<UpdateEmployeeTaskStatusNotifier>((
    ref) =>
    UpdateEmployeeTaskStatusNotifier(ref)
);

