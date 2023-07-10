
import 'package:json_annotation/json_annotation.dart';
// part'UsersModel.dart.g.dart';
@JsonSerializable()
class UsersModel {
  bool status;
  String errNum;
  String msg;
  List<Datum> data;

  UsersModel({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
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
  String email;
  String type;
  String? phone;
  String image;
  Status status;

  Datum({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    this.phone,
    required this.image,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    type: json["type"],
    phone: json["phone"],
    image: json["image"],
    status: statusValues.map[json["status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "type": type,
    "phone": phone,
    "image": image,
    "status": statusValues.reverse[status],
  };
}

enum Status { BLOCKED, UNBLOCKED }

final statusValues = EnumValues({
  "blocked": Status.BLOCKED,
  "unblocked": Status.UNBLOCKED
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
