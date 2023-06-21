// To parse this JSON data, do
//
//     final reportResponse = reportResponseFromJson(jsonString);

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part'reportsresponse.g.dart';
@JsonSerializable()

class ReportResponse {
  bool status;
  String errNum;
  String msg;
  List<Datum> data;

  ReportResponse({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) => ReportResponse(
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
  String report;
  String reason;
  String image;
  String projectId;
  String userId;
  String? rate;
  DateTime createdAt;
  DateTime updatedAt;
  Project project;

  Datum({
    required this.id,
    required this.report,
    required this.reason,
    required this.image,
    required this.projectId,
    required this.userId,
    this.rate,
    required this.createdAt,
    required this.updatedAt,
    required this.project,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    report: json["report"],
    reason: json["reason"],
    image: json["image"],
    projectId: json["project_id"],
    userId: json["user_id"],
    rate: json["rate"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    project: Project.fromJson(json["project"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "report": report,
    "reason": reason,
    "image": image,
    "project_id": projectId,
    "user_id": userId,
    "rate": rate,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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
