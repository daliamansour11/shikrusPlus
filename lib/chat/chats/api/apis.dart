import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/SharedPreferenceInfo.dart';
import '../model/GroupModel.dart';
import '../model/UsersModel.dart';
import '../model/chat_msg.dart';

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static String? user = auth.currentUser?.uid;
  static String? groupId = auth.currentUser?.uid;
  static String? email = FirebaseAuth.instance.currentUser?.email;
  static String? displayName = FirebaseAuth.instance.currentUser?.displayName;
  static String? photoURL = FirebaseAuth.instance.currentUser?.photoURL;


  static late UserData me;

  // Push notifications
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  // to get message tokens
  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then((t) {
      if (t != null) {
        //me.pushToken = t;
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
  static Future<void> sendPushNotification(UserData chatuser,
      String msg) async {
    try {
      final body = {
        // "to": chatuser.pushToken,
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

  static Future <bool> UserExists() async {
    return (await firestore.collection('users').doc(user!).get()).exists;
  }

  // to get login details for profile screen
  static Future <void> getProfileInfo() async {
    await firestore.collection('users').doc(user!).get().then((user) async {
      if (user.exists) {
        me = UserData.fromJson(user.data()!);
        await getFirebaseMessagingToken();
        // for updating status of user
        Apis.updateActiveStatus(true);
      } else {
        await CreateUser().then((value) => getProfileInfo());
      }
    });
  }

// store profile pic in database
  static Future<void> updateProfilePic(File file) async {
    final ext = file.path.split('.').last;
    print('Extension: ${ext}');
    final ref = storage.ref().child('profile_pic/${user!}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((
        p0) {
      print('data transferred: ${p0.bytesTransferred / 1000} kb');
    });
    me.image = await ref.getDownloadURL();
    await firestore.collection('users').doc(user!).update({'image': me.image});
  }


  static Future <void> CreateUser() async {
    final time = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    final Chatuser = UserData(
        id: int.parse(user??""),
        name: displayName!.toString(),
        email: email!.toString(),

        image: photoURL.toString(),
        type: ''
    );
    // return (await firestore.collection('users').doc(auth.currentuser!).get()).exists;
    return await firestore.collection('users').doc(user!).set(
        Chatuser.toJson());
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
  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAlUsers(List<String> userIds) async
  {
    log('\nUserIds: $userIds');
    print("ussssssssssssssssssssss$userIds");
    return await firestore.collection('users').where('uId',isNotEqualTo: user  )
    //because empty list throws an error
        .where('email', isNotEqualTo:"mohmed112@gmail.com" )
        .snapshots();
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAdminUsers() {

    return firestore
        .collection('users')
        .where('email',isEqualTo: "mohmed112@gmail.com" ) //because empty list throws an error
    // .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUsersid(int id) {

    return firestore
        .collection('usersid')
        .where('ids',arrayContains:id  ) //because empty list throws an error
        .snapshots();
  }
  // update user is online/offline
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection("users").doc(user).update({
      'is_online': isOnline,
      'last_active': DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
      //'push_token': me.pushToken,
    });
  }

  //                      chat msgs
  // for getting a conversaton id
  static int?idduserr;
  static String? receivername;
  static getid()async
  {
    await SharedPreferencesInfo.getUserIdFromSF().then(( value){
      idduserr = value;
      print("nameeeeeeeeeeeeee$idduserr");

    });
  }


  static String getConversionId(String id) {

    return user.hashCode <= id.hashCode ? '${ auth.currentUser?.uid}_$id'
        : '${id}_${ auth.currentUser?.uid}';
  }
  static String getsendConversionId(String id,int idd) {
    return user.hashCode <= id.hashCode ? '${idd}_$id'
        : '${id}_${ idduserr}';
  }
  static String getsenduserConversionId(int idd,String id) {
    return user.hashCode <= id.hashCode ? '${id}_${idd}'
        : '${idduserr}_${ id}';
  }
  // to get all msgs from firestore database for a particular conversionId
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMesages(
      UserData user,int idUser){

    return  firestore.collection('chat/${getsendConversionId(user.id.toString(),idUser??0)}/messages')
        .orderBy('send', descending: true)
        .snapshots();
  }
  static List<String>ids=[];
  static String ik="";

  static List <dynamic>listtt=[];

  Widget methd(BuildContext context) {

    return  Container(
      width: double.infinity,
      height: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('usersid')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            var userDocument = snapshot.data?.docs[0]["ids"];
            listtt.add(userDocument);
            return Center();

          }
      ),
    );
  }
// for sending msgs
  static Future<void> sendAdminMessage(UserData chatuser, String msg, Type type) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    int iduserr=sf.getInt("USERIDKEY")??0;

    final time = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    final Messages message = Messages(
        msg: msg,
        toId: chatuser.id.toString(),
        read: 'false',
        receiverimg: chatuser.image??"",
        type: type,
        receivername:chatuser.name.toString() ,

        send:  "${DateTime.now(). millisecondsSinceEpoch}",
        fromId: idduserr.toString()??"");
    final ref = firestore.collection('chat/${getsendConversionId(chatuser.id.toString(),iduserr)}/messages');
    final  userDocRef = await firestore.collection('chat').doc('${getsendConversionId(chatuser.id.toString(),iduserr)}');
    final doc = await userDocRef.get();
    //  await firestore.collection('usersid').doc().set({"ids":FieldValue.arrayUnion([chatuser.id,iduserr])});
    //   await firestore.collection('usersid').doc().get().then((doc){
    //    print("${doc.exists}doccccccccccc");
    //   });
    var query = FirebaseFirestore.instance
        .collection('usersid')
        .where('ids',arrayContains: FieldValue.arrayUnion([chatuser.id,iduserr]));
    query.get().then((QuerySnapshot snapshot) {
      List l= snapshot.docs;

      // handle the results here
    });

    ik=doc.id;
    print("${listtt}doccccccccccccccccc");
    // if (!doc.exists ) {
    //     firestore.collection(
    //     'chat/${getsendConversionId(chatuser.id.toString(),iduserr)}/sender').add({"senderid":FieldValue.arrayUnion(["${doc}","${iduserr}"])});
    // }

    //FieldValue.arrayUnion(["${uid}_$userName"])
    await
    await ref.doc(time).set(message.toJson()).then((value) {
      value;
      ids.add(getsendConversionId(chatuser.id.toString(),iduserr));
      print("${ids}ooooooooo");
      print("${ik}doccccccccccccccccc");
    });

    // sendPushNotification(chatuser, type == Type.text ? msg : 'Image'));
  }
  static Future<void> sendMessage(UserData chatuser, String msg, Type type) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    int iduserr=sf.getInt("USERIDKEY")??0;

    final time = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    final Messages message = Messages(
        msg: msg,
        toId: chatuser.id.toString(),
        read: 'false',
        receiverimg: chatuser.image??"",
        type: type,
        receivername:chatuser.name.toString() ,

        send:  "${DateTime.now(). millisecondsSinceEpoch}",
        fromId: idduserr.toString()??"");
    final ref = firestore.collection('chat/${getsenduserConversionId(iduserr,chatuser.id.toString())}/messages');
    final  userDocRef = await firestore.collection('chat').doc('${getsendConversionId(chatuser.id.toString(),iduserr)}');
    final doc = await userDocRef.get();

    await
    await ref.doc(time).set(message.toJson()).then((value) {
      value;
      ids.add(getsendConversionId(chatuser.id.toString(),iduserr));
      print("${ids}ooooooooo");
      print("${ik}doccccccccccccccccc");
    });

    // sendPushNotification(chatuser, type == Type.text ? msg : 'Image'));
  }
//static List<String>ikid=[];

// updating status of msg read/unread
  static Future<void> updateMessageReadstatus(Messages messages) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    int iduserr=sf.getInt("USERIDKEY")??0;
    firestore.collection('chat/${getsendConversionId(messages.fromId,iduserr)}/messages')
        .doc(messages.send)
        .update({'read': DateTime
        .now()
        .millisecondsSinceEpoch
        .toString()});
  }

// to get the last msg
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      UserData user) {
    return firestore.collection('chats/${getConversionId(user.id.toString())}/messages')
        .orderBy('send', descending: true)
        .limit(1).snapshots();
  }

  // images store in database
  static Future<void> sendChatImage(UserData chatUser, File file) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    int iduserr=sf.getInt("USERIDKEY")??0;
    final ext = file.path
        .split('.')
        .last;
    final ref = storage.ref().child
      ('images/${getsendConversionId(chatUser.id.toString(),iduserr)}/${DateTime
        .now()
        .millisecondsSinceEpoch}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((
        p0) {
      print('data transferred: ${p0.bytesTransferred / 1000} kb');
    });
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }

// for adding an user to my user when first message is send
  static Future<void> sendusersMessage(UserData chatuser) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    int iduserr=sf.getInt("USERIDKEY")??0;
    await firestore.collection('usersid').doc().set({"ids":FieldValue.arrayUnion([chatuser.id,iduserr])});

  }

// getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      UserData chatUser) {
    return firestore.collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  //delete message
  static Future<void> deleteMessage(Messages message) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    int iduserr=sf.getInt("USERIDKEY")??0;
    await firestore
        .collection('chat/${getsendConversionId(message.toId.toString(),iduserr)}/messages/')
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
  static Future<void> updatemessage(Messages message, String updatedMsg) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    int iduserr=sf.getInt("USERIDKEY")??0;
    await firestore
        .collection('chat/${getsendConversionId(message.toId.toString() ,iduserr)}/messages/')
        .doc(message.send)
        .update({'msg': updatedMsg});
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


  static Future<void> sendGroupImage(GroupModel gruopModel, File file) async {
    final ext = file.path
        .split('.')
        .last;
    final ref = storage.ref().child
      ('images/${getGroupChatId(gruopModel.groupId)}/${DateTime
        .now()
        .millisecondsSinceEpoch}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((
        p0) {
      print('data transferred: ${p0.bytesTransferred / 1000} kb');
    });
    final imageUrl = await ref.getDownloadURL();
    await sendGroupMessage(gruopModel, imageUrl, Type.image);
  }

  static String getGroupChatId(String id)=>
      groupId.hashCode <= id.hashCode? '${groupId}_$id':'${id}_${groupId}';



  static Future<void> sendGroupMessage(GroupModel? groupModel, String msg,
      Type type) async {
    final time = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    final Messages mssage = Messages(
        msg: msg,
        toId: groupModel!.groupId,
        read: '',
        type: type,
        send: time,
        fromId: groupModel.groupId);
    final ref = firestore.collection(
        'groups/${getGroupChatId(groupModel.groupId)}/messages');
    // await ref.doc(time).set(message.toJson()).then((value) => sendgroupPushNotification(groupModel,type==Type.text?msg:'Image'));
  }


}
