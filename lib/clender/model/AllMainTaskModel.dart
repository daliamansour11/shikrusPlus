
import 'dart:convert';



class AllMainTaskModel {
  bool status;
  String errNum;
  String msg;
  List<Datum> data;

  AllMainTaskModel({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });

  factory AllMainTaskModel.fromJson(Map<String, dynamic> json) => AllMainTaskModel(
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
  String name;
  String subject;
  String notes;
  String status;
  DateTime startingDate;
  DateTime expectedExpiryDate;
  dynamic actualEndDate;
  String timeFrom;
  String timeTo;
  String type;
  Project project;

  Datum({
    required this.id,
    required this.name,
    required this.subject,
    required this.notes,
    required this.status,
    required this.startingDate,
    required this.expectedExpiryDate,
    this.actualEndDate,
    required this.timeFrom,
    required this.timeTo,
    required this.type,
    required this.project,
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
    timeFrom: json["time_from"],
    timeTo: json["time_to"],
    type: json["type"],
    project: Project.fromJson(json["project"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "subject": subject,
    "notes": notes,
    "status": status,
    "starting_date": "${startingDate.year.toString().padLeft(4, '0')}-${startingDate.month.toString().padLeft(2, '0')}-${startingDate.day.toString().padLeft(2, '0')}",
    "expected_expiry_date": "${expectedExpiryDate.year.toString().padLeft(4, '0')}-${expectedExpiryDate.month.toString().padLeft(2, '0')}-${expectedExpiryDate.day.toString().padLeft(2, '0')}",
    "actual_end_date": actualEndDate,
    "time_from": timeFrom,
    "time_to": timeTo,
    "type": type,
    "project": project.toJson(),
  };
}

class Project {
  int id;
  String nameAr;
  String nameEn;

  Project({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
  };
}
