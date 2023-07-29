// To parse this JSON data, do
//
//     final tasksModel = tasksModelFromJson(jsonString);


import 'package:json_annotation/json_annotation.dart';
part'TasksModel.g.dart';
@JsonSerializable()

class TasksModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Datum> data ;


  TasksModel({
     this.status,
     this.errNum,
     this.msg,
       required this.data ,
  });

  factory TasksModel.fromJson(Map<String, dynamic> json) => TasksModel(
    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String? name;
  String? subject;
  String? notes;
  String? status;
  DateTime? startingDate;
  DateTime ?expectedExpiryDate;
  dynamic ?actualEndDate;
  String? projectId;
  String ?timeFrom;
  String ?timeTo;
  String ?type;

  Datum({
    required this.id,
     this.name,
     this.subject,
     this.notes,
     this.status,
     this.startingDate,
     this.expectedExpiryDate,
    this.actualEndDate,
     this.projectId,
     this.timeFrom,
     this.timeTo,
     this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    subject: json["subject"],
    notes: json["notes"],
    status: json["status"],
    startingDate: DateTime.parse(json["starting_date"]),
    expectedExpiryDate: DateTime.parse(json["expected_expiry_date"]),
    actualEndDate: json["actual_end_date"],
    projectId: json["project_id"],
    timeFrom: json["time_from"],
    timeTo: json["time_to"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "subject": subject,
    "notes": notes,
    "status": status,
    "starting_date": "${startingDate?.year.toString().padLeft(4, '0')}-${startingDate?.month.toString().padLeft(2, '0')}-${startingDate?.day.toString().padLeft(2, '0')}",
    "expected_expiry_date": "${expectedExpiryDate?.year.toString().padLeft(4, '0')}-${expectedExpiryDate?.month.toString().padLeft(2, '0')}-${expectedExpiryDate?.day.toString().padLeft(2, '0')}",
    "actual_end_date": actualEndDate,
    "project_id": projectId,
    "time_from": timeFrom,
    "time_to": timeTo,
    "type": type,
  };
}


