//
// import 'package:tasksapp/model/TasksModel.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'StateModel.freezed.dart';
//
// abstract class StateModel {
//   const StateModel();
//   ///Initial
//   const factory StateModel.initial() = _$StateModelInitial();
//
//   ///Loading
//   const factory StateModel.loading() = _StateModelLoading;
//
//   ///Data
//   const factory StateModel.data({required TasksModel task}) = _StateModelData;
//
//   ///Error
//   const factory StateModel.error([String? error]) = _StateModelE;
// }
//
// ///Extension Method for easy comparison
// extension TasksGetters on StateModel {
//   bool get isLoading => this is _TasksStateLoading;
// }
//
//
// class StateModelInitial extends StateModel {
//   const StateModelInitial();
// }