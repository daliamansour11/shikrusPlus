// To parse this JSON data, do
//
//     final getStatisticsResponse = getStatisticsResponseFromJson(jsonString);

import 'dart:convert';

GetStatisticsResponse getStatisticsResponseFromJson(String str) => GetStatisticsResponse.fromJson(json.decode(str));

String getStatisticsResponseToJson(GetStatisticsResponse data) => json.encode(data.toJson());

class GetStatisticsResponse {
  bool status;
  String errNum;
  Msg msg;
  List<Datum> data;

  GetStatisticsResponse({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });

  factory GetStatisticsResponse.fromJson(Map<String, dynamic> json) => GetStatisticsResponse(
    status: json["status"],
    errNum: json["errNum"],
    msg: msgValues.map[json["msg"]]!,
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msgValues.reverse[msg],
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Msg key;
  int count;
  List<Task> tasks;

  Datum({
    required this.key,
    required this.count,
    required this.tasks,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    key: msgValues.map[json["key"]]!,
    count: json["count"],
    tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key": msgValues.reverse[key],
    "count": count,
    "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
  };
}

enum Msg { TO_DO, DONE, HOLD, ON_GOING }

final msgValues = EnumValues({
  "done": Msg.DONE,
  "hold": Msg.HOLD,
  "on-going": Msg.ON_GOING,
  "to-do": Msg.TO_DO
});

class Task {
  int id;
  String name;
  String subject;
  String notes;
  Msg status;
  DateTime startingDate;
  DateTime expectedExpiryDate;
  dynamic actualEndDate;
  String? timeFrom;
  String? timeTo;
  Type type;
  String? mainTaskId;
  String? projectId;
  String employeeId;
  MakerType makerType;
  String makerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Task({
    required this.id,
    required this.name,
    required this.subject,
    required this.notes,
    required this.status,
    required this.startingDate,
    required this.expectedExpiryDate,
    this.actualEndDate,
    this.timeFrom,
    this.timeTo,
    required this.type,
    this.mainTaskId,
    this.projectId,
    required this.employeeId,
    required this.makerType,
    required this.makerId,
    this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    name: json["name"],
    subject: json["subject"],
    notes: json["notes"],
    status: msgValues.map[json["status"]]!,
    startingDate: DateTime.parse(json["starting_date"]),
    expectedExpiryDate: DateTime.parse(json["expected_expiry_date"]),
    actualEndDate: json["actual_end_date"],
    timeFrom: json["time_from"],
    timeTo: json["time_to"],
    type: typeValues.map[json["type"]]!,
    mainTaskId: json["main_task_id"],
    projectId: json["project_id"],
    employeeId: json["employee_id"],
    makerType: makerTypeValues.map[json["maker_type"]]!,
    makerId: json["maker_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "subject": subject,
    "notes": notes,
    "status": msgValues.reverse[status],
    "starting_date": "${startingDate.year.toString().padLeft(4, '0')}-${startingDate.month.toString().padLeft(2, '0')}-${startingDate.day.toString().padLeft(2, '0')}",
    "expected_expiry_date": "${expectedExpiryDate.year.toString().padLeft(4, '0')}-${expectedExpiryDate.month.toString().padLeft(2, '0')}-${expectedExpiryDate.day.toString().padLeft(2, '0')}",
    "actual_end_date": actualEndDate,
    "time_from": timeFrom,
    "time_to": timeTo,
    "type": typeValues.reverse[type],
    "main_task_id": mainTaskId,
    "project_id": projectId,
    "employee_id": employeeId,
    "maker_type": makerTypeValues.reverse[makerType],
    "maker_id": makerId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

enum MakerType { ADMIN, EMPLOYEE }

final makerTypeValues = EnumValues({
  "admin": MakerType.ADMIN,
  "employee": MakerType.EMPLOYEE
});

enum Type { MAIN, SUB }

final typeValues = EnumValues({
  "main": Type.MAIN,
  "sub": Type.SUB
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
