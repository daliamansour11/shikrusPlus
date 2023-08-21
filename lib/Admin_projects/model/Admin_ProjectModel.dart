// To parse this JSON data, do
//
//     final adminProjectModel = adminProjectModelFromJson(jsonString);

import 'dart:convert';
class AdminProjectModel {
  bool status;
  String errNum;
  String msg;
  List<Projects> data;

  AdminProjectModel({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });

  factory AdminProjectModel.fromJson(Map<String, dynamic> json) => AdminProjectModel(
    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
    data: List<Projects>.from(json["data"].map((x) => Projects.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Projects {
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
  List<EmployeeProject> employeeProjects;

  Projects({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.subject,
    required this.notes,
    required this.status,
    required this.startingDate,
    required this.expectedExpiryDate,
    required this.actualEndDate,
    required this.specializationId,
    required this.clientId,
    required this.adminId,
    required this.createdAt,
    required this.updatedAt,
    required this.employeeProjects,
  });

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
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
    employeeProjects: List<EmployeeProject>.from(json["employee_projects"].map((x) => EmployeeProject.fromJson(x))),
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
    "employee_projects": List<dynamic>.from(employeeProjects.map((x) => x.toJson())),
  };
}

class EmployeeProject {
  int id;
  String name;
  String email;
  String phone;
  String image;
  dynamic emailVerifiedAt;
  String password;
  String type;
  String status;
  String adminId;
  String specializationId;
  String fcmToken;
  dynamic rememberToken;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  EmployeeProject({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.emailVerifiedAt,
    required this.password,
    required this.type,
    required this.status,
    required this.adminId,
    required this.specializationId,
    required this.fcmToken,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory EmployeeProject.fromJson(Map<String, dynamic> json) => EmployeeProject(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    emailVerifiedAt: json["email_verified_at"],
    password: json["password"],
    type: json["type"],
    status: json["status"],
    adminId: json["admin_id"],
    specializationId: json["specialization_id"],
    fcmToken: json["fcm_token"],
    rememberToken: json["remember_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "email_verified_at": emailVerifiedAt,
    "password": password,
    "type": type,
    "status": status,
    "admin_id": adminId,
    "specialization_id": specializationId,
    "fcm_token": fcmToken,
    "remember_token": rememberToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  String projectId;
  String userId;

  Pivot({
    required this.projectId,
    required this.userId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    projectId: json["project_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "project_id": projectId,
    "user_id": userId,
  };
}
