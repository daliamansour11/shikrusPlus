class Messages {
  Messages({
    required this.msg,
    required this.toId,
    required this.read,
    required this.type,
    required this.send,
    required this.fromId,
    this.receiverimg="",
     this.receivername=""
  });
  late final String msg;
  late final String toId;
  late final String read;
  late final String receivername;
  late final String receiverimg;
  late final Type type;
  late final DateTime send;
  late final String fromId;
  
  Messages.fromJson(Map<String, dynamic> json){
    msg = json['msg'].toString();
    toId = json['toId'].toString();
    read = json['read'].toString();
    type = json['type'].toString()==Type.image.name?Type.image:Type.text;
    send = json['send'].toDate();
    receiverimg=json['receiverimg'].toString();
    fromId = json['fromId'].toString();
    receivername=json['receivername'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    _data['toId'] = toId;
    _data['read'] = read;
    _data['type'] = type.name;
    _data['send'] = send;
    _data['receiverimg']=receiverimg;
    _data['fromId'] = fromId;
    _data['receivername']=receivername;
    return _data;
  }
}
enum Type{text,image}