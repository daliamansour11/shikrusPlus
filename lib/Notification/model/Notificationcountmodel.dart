
import 'dart:convert';


class NotificationCount {
  bool status;
  String errNum;
  String msg;
  int data;

  NotificationCount({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });

  factory NotificationCount.fromJson(Map<String, dynamic> json) => NotificationCount(
    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
    "data": data,
  };
}
