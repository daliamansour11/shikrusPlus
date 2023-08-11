



import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewModel/AddNewTaskViewModel.dart';
import '../viewModel/PostNewMainAdminTaskNotifier.dart';

final NewMainTaskProvider = ChangeNotifierProvider.autoDispose<PostNewMainTaskNotifier>((
    ref) =>
    PostNewMainTaskNotifier(ref));
final NewMainTaskAdminProvider = ChangeNotifierProvider.autoDispose<PostNewMainTaskAdminNotifier>((
    ref) =>
    PostNewMainTaskAdminNotifier(ref));

final NewSubTaskProvider = ChangeNotifierProvider.autoDispose<AddNewSubTaskNotifier>((
    ref) =>
    AddNewSubTaskNotifier(ref)
);

