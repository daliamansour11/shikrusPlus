// To parse this JSON data, do
//
//     final projectinfoModel = projectinfoModelFromJson(jsonString);

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part'ProjectInfoModel.g.dart';
@JsonSerializable()

class ProjectinfoModel {
  bool status;
  String errNum;
  String msg;
  Data data;

  ProjectinfoModel({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });

  factory ProjectinfoModel.fromJson(Map<String, dynamic> json) => ProjectinfoModel(
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
  String nameAr;
  String nameEn;
  String subject;
  String notes;
  String status;
  DateTime startingDate;
  DateTime expectedExpiryDate;
  dynamic actualEndDate;
  Category category;
  Admin client;
  Admin admin;
  List<Employee> employees;
  List<Report> reports;

  Data({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.subject,
    required this.notes,
    required this.status,
    required this.startingDate,
    required this.expectedExpiryDate,
    required this.actualEndDate,
    required this.category,
    required this.client,
    required this.admin,
    required this.employees,
    required this.reports,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    subject: json["subject"],
    notes: json["notes"],
    status: json["status"],
    startingDate: DateTime.parse(json["starting_date"]),
    expectedExpiryDate: DateTime.parse(json["expected_expiry_date"]),
    actualEndDate: json["actual_end_date"],
    category: Category.fromJson(json["category"]),
    client: Admin.fromJson(json["client"]),
    admin: Admin.fromJson(json["admin"]),
    employees: List<Employee>.from(json["employees"].map((x) => Employee.fromJson(x))),
    reports: List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
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
    "category": category.toJson(),
    "client": client.toJson(),
    "admin": admin.toJson(),
    "employees": List<dynamic>.from(employees.map((x) => x.toJson())),
    "reports": List<dynamic>.from(reports.map((x) => x.toJson())),
  };
}

class Admin {
  int id;
  String email;
  String status;
  String name;

  Admin({
    required this.id,
    required this.email,
    required this.status,
    required this.name,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["id"],
    email: json["email"],
    status: json["status"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "status": status,
    "name": name,
  };
}

class Category {
  int id;
  String nameAr;
  String nameEn;
  String status;

  Category({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.status,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "status": status,
  };
}

class Employee {
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

  Employee({
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

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
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

class Report {
  int id;
  String report;
  String reason;
  String image;
  String projectId;
  String userId;
  String? rate;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  Report({
    required this.id,
    required this.report,
    required this.reason,
    required this.image,
    required this.projectId,
    required this.userId,
    required this.rate,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    id: json["id"],
    report: json["report"],
    reason: json["reason"],
    image: json["image"],
    projectId: json["project_id"],
    userId: json["user_id"],
    rate: json["rate"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
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
    "user": user.toJson(),
  };
}

class User {
  int id;
  String name;
  String phone;
  String image;

  User({
    required this.id,
    required this.name,
    required this.phone,
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
