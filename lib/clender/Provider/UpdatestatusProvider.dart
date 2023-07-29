



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/clender/viewModel/UpdateAllMainTaskStatus.dart';

final updateTaskProvider = ChangeNotifierProvider.autoDispose<UpdateEmployeeTaskStatusNotifier>((
    ref) =>
    UpdateEmployeeTaskStatusNotifier(ref)
);

