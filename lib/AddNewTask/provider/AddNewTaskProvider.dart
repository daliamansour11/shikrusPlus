



import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewModel/AddNewTaskViewModel.dart';

final NewMainTaskProvider = ChangeNotifierProvider.autoDispose<PostNewMainTaskNotifier>((
    ref) =>
    PostNewMainTaskNotifier(ref)
);

final NewSubTaskProvider = ChangeNotifierProvider.autoDispose<AddNewSubTaskNotifier>((
    ref) =>
    AddNewSubTaskNotifier(ref)
);

