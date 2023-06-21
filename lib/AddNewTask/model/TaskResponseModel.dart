// To parse this JSON data, do
//
//     final taskResponseModel = taskResponseModelFromJson(jsonString);

import 'dart:convert';

TaskResponseModel taskResponseModelFromJson(String str) => TaskResponseModel.fromJson(json.decode(str));

String taskResponseModelToJson(TaskResponseModel data) => json.encode(data.toJson());

class TaskResponseModel {
  bool status;
  String errNum;
  String msg;
  List<dynamic> data;

  TaskResponseModel({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) => TaskResponseModel(
    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
