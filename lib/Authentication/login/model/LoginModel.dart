
import 'package:json_annotation/json_annotation.dart';
part'LoginModel.g.dart';

@JsonSerializable()
class LoginModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  LoginModel({
     this.status,
     this.errNum,
     this.msg,
     this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(

    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  String token;
  PersonalInformation personalInformation;

  Data({
    required this.token,
    required this.personalInformation,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    personalInformation: PersonalInformation.fromJson(json["personal_information"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "personal_information": personalInformation.toJson(),
  };
}

class PersonalInformation {
  int id;
  String name;
  String email;
  String type;
  String? status;
  dynamic ?phone;
  String ? image;


  PersonalInformation({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
   this.status,
    this.phone,
     this.image,

  });

  factory PersonalInformation.fromJson(Map<String, dynamic> json) => PersonalInformation(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    type: json["type"],
    status: json["status"],
    phone: json["phone"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "type": type,
    "status": status,
    "phone": phone,
    "image": image,

  };
}

class AdminId {
  int id;
  String name;
  String email;
  String image;
  String type;

  AdminId({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.type,
  });

  factory AdminId.fromJson(Map<String, dynamic> json) => AdminId(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "type": type,
  };
}

class Category {
  int id;
  String nameAr;
  String nameEn;
  DateTime createdAt;
  DateTime updatedAt;

  Category({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Project {
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
  Pivot pivot;

  Project({
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
    required this.pivot,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
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
    pivot: Pivot.fromJson(json["pivot"]),
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
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  String userId;
  String projectId;

  Pivot({
    required this.userId,
    required this.projectId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    userId: json["user_id"],
    projectId: json["project_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "project_id": projectId,
  };
}

