// To parse this JSON data, do
//
//     final logoutresponse = logoutresponseFromJson(jsonString);

import 'dart:convert';

class Logoutresponse {
  bool status;
  String errNum;
  String msg;

  Logoutresponse({
    required this.status,
    required this.errNum,
    required this.msg,
  });

  factory Logoutresponse.fromJson(Map<String, dynamic> json) => Logoutresponse(
    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
  };
}
