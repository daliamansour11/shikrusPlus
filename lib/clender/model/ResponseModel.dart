import 'package:taskmanger/clender/model/StateModel.dart';


class ResponseModel {
  ResponseState? responseState;
  bool? isSuccess;
  String? message;
  Map? errors;
  dynamic data;

  ResponseModel({this.responseState = ResponseState.Initial,this.isSuccess = false,this.message = "",this.data,this.errors});

  factory ResponseModel.fromJson(dynamic map) {
    return ResponseModel(
      isSuccess: map['status']!= null ? ((map['status'] as bool == true) && (map['errors'] as Map?) == null) : false,
      message : ( map['msg'] != null &&  map['msg'] is String) ? map['msg'] as String : ( map['message'] != null &&  map['message'] is String) ? map['message'] as String : null,
      data : map['data'] ?? map,
      errors: map['msg'] is Map ? map["msg"] : null,
    );
  }

  @override
  String toString() {
    return '{${this.isSuccess} , ${this.message} ${this.responseState}';
  }

  String? getFullError() {

    String err = errors?.values.map((errorValue) => (errorValue as List).map((error) => "$error").join(" , ")).join("") ?? "Something Wrong !";
    print("Full Er $err");
    return err;
  }
  StateModel toState(data){
    return StateModel(state: isSuccess == true ? DataState.SUCCESS : DataState.ERROR , message: message , data: data);
  }
}

enum ResponseState {
  Initial,
  Loading,
  Loaded,
  Error
}