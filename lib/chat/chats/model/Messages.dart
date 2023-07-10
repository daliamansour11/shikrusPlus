
class messages_model{
   String? senderId;
   String? sender;
  String? msg;
  String? reciverId;
  String? time;
  String? type;
       String? read;




  // , key;

  messages_model( {
    this.senderId,
    this.sender,
     this.msg,
     this.time,
    this.type,
    this.read,
     this.reciverId,
  });
  messages_model.fromJson(Map<String, dynamic>json)
  {
     senderId = json["senderId"];
     sender = json["sender"];
     msg  = json["msg"];
    time = json["time"];
    type = json["type"];
     read = json["read"];
    reciverId = json["reciverId"];



  }
  Map<String, dynamic> toMap()
  {
  return{
   'senderId':senderId,
   'sender':sender,
  "msg":msg,
  "time":time,
    "type": type,
    "read": read,

  };


  }

}