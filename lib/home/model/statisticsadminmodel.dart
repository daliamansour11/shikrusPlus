import 'dart:convert';

class GetStatisticsAdminResponse {
  bool status;
  String errNum;
  String msg;
  List<Datum> data;

  GetStatisticsAdminResponse({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });

  factory GetStatisticsAdminResponse.fromJson(Map<String, dynamic> json) => GetStatisticsAdminResponse(
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
  String key;
  int count;
  List<Projectstatistis> projects;

  Datum({
    required this.key,
    required this.count,
    required this.projects,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    key: json["key"],
    count: json["count"],
    projects: List<Projectstatistis>.from(json["projects"].map((x) => Projectstatistis.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "count": count,
    "projects": List<dynamic>.from(projects.map((x) => x.toJson())),
  };
}

class Projectstatistis {
  int id;
  String nameAr;
  String nameEn;
  String subject;
  String notes;
  String status;
  DateTime startingDate;
  DateTime expectedExpiryDate;
  dynamic actualEndDate;
  String specializationId;
  String clientId;
  String adminId;
  DateTime createdAt;
  DateTime updatedAt;

  Projectstatistis({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.subject,
    required this.notes,
    required this.status,
    required this.startingDate,
    required this.expectedExpiryDate,
    this.actualEndDate,
    required this.specializationId,
    required this.clientId,
    required this.adminId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Projectstatistis.fromJson(Map<String, dynamic> json) => Projectstatistis(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    subject: json["subject"],
    notes: json["notes"],
    status: json["status"],
    startingDate: DateTime.parse(json["starting_date"]),
    expectedExpiryDate: DateTime.parse(json["expected_expiry_date"]),
    actualEndDate: json["actual_end_date"],
    specializationId: json["specialization_id"],
    clientId: json["client_id"],
    adminId: json["admin_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "subject": subject,
    "notes": notes,
    "status": status,
    "starting_date": "${startingDate.year.toString().padLeft(4, '0')}-${startingDate.month.toString().padLeft(2, '0')}-${startingDate.day.toString().padLeft(2, '0')}",
    "expected_expiry_date": "${expectedExpiryDate.year.toString().padLeft(4, '0')}-${expectedExpiryDate.month.toString().padLeft(2, '0')}-${expectedExpiryDate.day.toString().padLeft(2, '0')}",
    "actual_end_date": actualEndDate,
    "specialization_id": specializationId,
    "client_id": clientId,
    "admin_id": adminId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
