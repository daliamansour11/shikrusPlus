
import 'dart:convert';

class Notifications {
  List<Datum> data;

  Notifications({
    required this.data,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String titleEn;
  String bodyEn;
  String titleAr;
  String bodyAr;
  int read;
  dynamic sender;
  String createdAt;

  Datum({
    required this.id,
    required this.titleEn,
    required this.bodyEn,
    required this.titleAr,
    required this.bodyAr,
    required this.read,
    this.sender,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    titleEn: json["title_en"],
    bodyEn: json["body_en"],
    titleAr: json["title_ar"],
    bodyAr: json["body_ar"],
    read: json["read"],
    sender: json["sender"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title_en": titleEn,
    "body_en": bodyEn,
    "title_ar": titleAr,
    "body_ar": bodyAr,
    "read": read,
    "sender": sender,
    "created_at": createdAt,
  };
}
