
import 'package:json_annotation/json_annotation.dart';
part'reportdetailresponse.g.dart';
@JsonSerializable()

class ReportDetailResponse {
  bool status;
  String errNum;
  String msg;
  Data data;
  ReportDetailResponse({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });

  factory ReportDetailResponse.fromJson(Map<String, dynamic> json) => ReportDetailResponse(
    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  int id;
  String report;
  String image;
  String reason;
  String rate;
  DateTime createdAt;
  Project project;
  User user;

  Data({
    required this.id,
    required this.report,
    required this.image,
    required this.reason,
    required this.rate,
    required this.createdAt,
    required this.project,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    report: json["report"],
    image: json["image"],
    reason: json["reason"],
    rate: json["rate"],
    createdAt: DateTime.parse(json["created_at"]),
    project: Project.fromJson(json["project"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "report": report,
    "image": image,
    "reason": reason,
    "rate": rate,
    "created_at": createdAt.toIso8601String(),
    "project": project.toJson(),
    "user": user.toJson(),
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

class User {
  int id;
  String name;
  dynamic phone;
  String image;

  User({
    required this.id,
    required this.name,
    this.phone,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "image": image,
  };
}
