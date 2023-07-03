import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';

import '../model/chat_msg.dart';
import '../model/chat_user.dart';
import '../model/group_model.dart';

class Apis{
  static FirebaseAuth auth=FirebaseAuth.instance;
  static FirebaseFirestore firestore=FirebaseFirestore.instance;
  static FirebaseStorage storage=FirebaseStorage.instance;
  static  String? user =FirebaseAuth.instance .currentUser?.uid;
  static String? groupId = auth.currentUser?.uid;
  static String? email = FirebaseAuth.instance.currentUser?.email;
  static String? displayName = FirebaseAuth.instance.currentUser?.displayName;
  static String? photoURL = FirebaseAuth.instance.currentUser?.photoURL;


  static late ChatUser me;

  // Push notifications
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  // to get message tokens
  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;
        print('Push Token: $t');
      }
    });
    // for handling foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });
  }
  // sending push notifications
  static Future<void> sendPushNotification(ChatUser chatuser , String msg) async {
    try {
      final body = {
        "to": chatuser.pushToken,
        "notification": {
          "title": me.name, //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
      };
      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
            'key=AAAA0SN85Fw:APA91bEPau7CCeJvIPJZf7c9EGdbA3NWEzdUUzy5vNTiT-i27Cea3SGgyTxnVg5wo8bmHnd2Y7-JL5XJ73RRFmhoB0ME96rAfi2WVDTBnQPJL0_4ICKdRN1iMLEY_X3bT9YI7pZJfqRp',
          },
          body: jsonEncode(body));
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    } catch (e) {
      print('\nsendPushNotificationE: $e');
    }
  }

  static Future<void> sendgroupPushNotification(GroupModel groupModel , String msg) async {
    try {
      final body = {
        "to": groupModel.pushToken,
        "notification": {
          "title": me.name, //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
      };
      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
            'key=AAAA0SN85Fw:APA91bEPau7CCeJvIPJZf7c9EGdbA3NWEzdUUzy5vNTiT-i27Cea3SGgyTxnVg5wo8bmHnd2Y7-JL5XJ73RRFmhoB0ME96rAfi2WVDTBnQPJL0_4ICKdRN1iMLEY_X3bT9YI7pZJfqRp',
          },
          body: jsonEncode(body));
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    } catch (e) {
      print('\nsendPushNotificationE: $e');
    }
  }

  static Future <bool> UserExists() async{
    return (await firestore.collection('users').doc(user!).get()).exists;
  }
  // to get login details for profile screen
  static Future <void> getProfileInfo() async{
    await firestore.collection('users').doc(user!).get().then((user) async {
      if(user.exists){
        me=ChatUser.fromJson(user.data()!);
        await getFirebaseMessagingToken();
        // for updating status of user
        Apis.updateActiveStatus(true);
      }else{
        await CreateUser().then((value) => getProfileInfo());
      }
    });
  }

// store profile pic in database
  static Future<void> updateProfilePic(File file) async{
    final ext=file.path.split('.').last;
    print('Extension: ${ext}');
    final ref=storage.ref().child('profile_pic/${user!}.$ext');
    await ref.putFile(file,SettableMetadata(contentType: 'image/$ext')).then((p0) {
      print('data transferred: ${p0.bytesTransferred/1000} kb');
    });
    me.image=await ref.getDownloadURL();
    await firestore.collection('users').doc(user!).update({'image':me.image});
  }


  static Future <void> CreateUser() async{
    final time=DateTime.now().millisecondsSinceEpoch.toString();
    final Chatuser=ChatUser(
        id: user!,
        name: displayName!.toString(),
        email: email!.toString(),
        about: "Hello, I'm using  chatk",
        image: photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: ''
    );
    // return (await firestore.collection('users').doc(auth.currentuser!).get()).exists;
    return await firestore.collection('users').doc(user!).set(Chatuser.toJson());
  }
  // for getting id's of known users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    print("ussssssssssssssssssssss");
    return firestore
        .collection('users')
        .doc(user)
       .collection('my_users')
       .snapshots();

    print("ussssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
  }

  // for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    log('\nUserIds: $userIds');
    print("ussssssssssssssssssssss$userIds");


    return firestore
        .collection('users')
        .where('id',
        whereIn: userIds.isEmpty
            ? ['nnnnnnnnnnnnn']
            : userIds) //because empty list throws an error
    // .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
  // update user is online/offline
  static Future<void> updateActiveStatus(bool isOnline)async {
    firestore.collection("users").doc(user).update({
      'is_online':isOnline,
      'last_active':DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token':me.pushToken,
    });
  }
  //                      chat msgs
  // for getting a conversaton id
  static String getConversionId(String? id)=>
      user.hashCode <= id.hashCode? '${user}_$id':'${id}_${user}';


  // to get all msgs from firestore database for a particular conversionId
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(ChatUser user){
    return firestore.collection('chat/${getConversionId(user.id)}/messages')
        .orderBy('send',descending: true)
        .snapshots();
  }
// for sending msgs//
  static Future<void> sendMessage(ChatUser chatuser,String msg,Type type)async {
    final time=DateTime.now().millisecondsSinceEpoch.toString();
    final Messages message=Messages(
        msg: msg, toId: chatuser.id, read: '',
        type: type, send: time, fromId: user!);
    final ref=firestore.collection('chat/${getConversionId(chatuser.id)}/messages');
    await ref.doc(time).set(message.toJson()).then((value) => sendPushNotification(chatuser,type==Type.text?msg:'Image'));
  }
// updating status of msg read/unread
  static Future<void> updateMessageReadstatus(Messages messages)async {
    firestore.collection('chat/${getConversionId(messages.fromId)}/messages').doc(messages.send)
        .update({'read':DateTime.now().millisecondsSinceEpoch.toString()});

  }
// to get the last msg
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(ChatUser user){
    return firestore.collection('chat/${getConversionId(user.id)}/messages')
        .orderBy('send',descending: true)
        .limit(1).snapshots();
  }

  static Future<void> sendFirstMessage(
      ChatUser chatuser, String msg, Type type) async {
    await firestore
        .collection('users')
        .doc(chatuser.id)
        .collection('my_users')
        .doc(user!)
        .set({}).then((value) => sendMessage(chatuser, msg, type));
  }


  //////////////chat images store in database/////////////
  static Future<void> sendChatImage(ChatUser chatUser,File file)async {
    final ext=file.path.split('.').last;
    final ref=storage.ref().child
      ('images/${getConversionId(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
    await ref.putFile(file,SettableMetadata(contentType: 'image/$ext')).then((p0) {
      print('data transferred: ${p0.bytesTransferred/1000} kb');
    });
    final imageUrl=await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }
  ///////////////////////////////////group//////////////////////////////////////////



  //  group images store in database
  static Future<void> sendGroupChatImage(GroupModel groupModel,File file)async {
    final ext=file.path.split('.').last;
    final ref=storage.ref().child
      ('images/${getGroupChatId(groupModel.groupId)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
    await ref.putFile(file,SettableMetadata(contentType: 'image/$ext')).then((p0) {
      print('data transferred: ${p0.bytesTransferred/1000} kb');
    });
    final imageUrl=await ref.getDownloadURL();
    await sendGroupMessage(groupModel, imageUrl, Type.image);
  }

  // for getting a groupconversaton id
  static String getGroupChatId(String id)=>
      groupId.hashCode <= id.hashCode? '${groupId}_$id':'${id}_${groupId}';


  // to get all msgs from firestore database for a particular conversionId
  static Stream<QuerySnapshot<Map<String, dynamic>>> getGroupAllMessages(GroupModel group){
    return firestore.collection('groups/${getGroupChatId(group.groupId)}/messages')
        .orderBy('send',descending: true)
        .snapshots();
  }
// for sending msgs
  static Future<void> sendGroupMessage(GroupModel groupModel,String msg,Type type)async {
    final time=DateTime.now().millisecondsSinceEpoch.toString();
    final Messages message=Messages(
        msg: msg, toId: groupModel.groupId, read: '',
        type: type, send: time, fromId: user!);
    final ref=firestore.collection('groups/${getGroupChatId(groupModel.groupId)}/messages');
    await ref.doc(time).set(message.toJson()).then((value) => sendgroupPushNotification(groupModel,type==Type.text?msg:'Image'));
  }
// updating status of msg read/unread
  static Future<void> updateGroupMessageReadstatus(Messages messages)async {
    firestore.collection('groups/${getConversionId(messages.fromId)}/messages').doc(messages.send)
        .update({'read':DateTime.now().millisecondsSinceEpoch.toString()});

  }
// to get the last msg
  static Stream<QuerySnapshot<Map<String, dynamic>>> getGroupLastMessage(GroupModel group){
    return firestore.collection('groups/${getGroupChatId(group.groupId??"")}/messages')
        .orderBy('send',descending: true)
        .limit(1).snapshots();
  }

// for adding an user to my user when first message is send
  static Future<void> sendFirstGroupMessage(
      GroupModel groupModel, String msg, Type type) async {
    await firestore
        .collection('groups')
        .doc(groupModel.groupId)
        .collection('messages')
        .doc(user!)
        .set({}).then((value) => sendGroupMessage(groupModel, msg, type));
  }



  // images store in database
  static Future<void> sendGroupImage(GroupModel gruopModel,File file)async {
    final ext=file.path.split('.').last;
    final ref=storage.ref().child
      ('images/${getGroupChatId(gruopModel.groupId)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
    await ref.putFile(file,SettableMetadata(contentType: 'image/$ext')).then((p0) {
      print('data transferred: ${p0.bytesTransferred/1000} kb');
    });
    final imageUrl=await ref.getDownloadURL();
    await sendGroupMessage(gruopModel, imageUrl, Type.image);
  }
// for adding an user to my user when first message is send

// getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getGoupInfo(GroupModel groupModel){
    return firestore.collection('groups').where('id',isEqualTo: groupModel.groupId).snapshots();
  }
  //delete message
  static Future<void> deleteMessage(Messages message) async {
    await firestore
        .collection('chat/${getConversionId(message.toId)}/messages/')
        .doc(message.send)
        .delete();
    if (message.type == Type.image) {
      //   final Reference storageReference = FirebaseStorage.instance
      //     .ref();
      //     .child("products")
      //     .child("product_$productId.png");
      // String downloadURL;
      // UploadTask uploadTask = storageReference.putFile(mFileImage);
      // downloadURL = await (await uploadTask).ref.getDownloadURL();

      await storage.refFromURL(message.msg).delete();
    }
  }
  // edit msgs
  static Future<void> updatemessage(Messages message,String updatedMsg) async {
    await firestore
        .collection('chat/${getConversionId(message.toId)}/messages/')
        .doc(message.send)
        .update({'msg':updatedMsg});

  }
// for adding an chat user for our conversation
  static Future<bool> addChatUser(String email) async {
    final data = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    log('data: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != user!) {
      //user exists

      log('user exists: ${data.docs.first.data()}');

      firestore
          .collection('users')
          .doc(user!)
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      //user doesn't exists
      return false;
    }
  }
}
