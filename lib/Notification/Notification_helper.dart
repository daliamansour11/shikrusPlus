import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationHelper{
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static String? mToken;
  static String? token;

  static init()async{
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // await cacheToken();
  }

  static Future<void> requestPermission() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(settings.authorizationStatus ==AuthorizationStatus.authorized){
      print('user geranted permission');
    }else if (settings.authorizationStatus ==AuthorizationStatus.provisional){
      print('user geranted provisional permission');
    }else {
      print('user decline or has ot accept');
    }
    // print('User granted permission: ${settings.authorizationStatus}');

  }
  get onDidReceiveLocalNotification => null;

  static initInfo()async{
    await NotificationHelper.requestPermission();
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings iosInitialize =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (x,y,z,w){

      },
    );
    var initializationSettings = InitializationSettings(android: androidInitialize,iOS: iosInitialize);

    NotificationHelper.flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse:( payload){
        try{
          // NotificationController notificationController=NotificationController();
          // notificationController.navigate(payload.payload??"",false);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NotificationScreen(),));
        }catch(e){
          if (kDebugMode) {
            print("error on onDidReceiveNotificationResponse");
          }
        }
        // return payload;
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      // NotificationController notificationController=NotificationController();
      // notificationController.navigate(event.notification?.title??"",true);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message)async {

      BigTextStyleInformation bigTextStyleInformation =BigTextStyleInformation(
          message.notification!.body.toString(),htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),htmlFormatContentTitle: true
      );
      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'dbfood', 'dbfood',importance: Importance.high,
        styleInformation: bigTextStyleInformation,priority: Priority.high,playSound: true,
        // sound: RawResourceAndroidNotificationSound('notification'),
      );
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );
      await NotificationHelper.flutterLocalNotificationsPlugin.show(0, message.notification?.title,
        message.notification?.body,notificationDetails,payload:message.data['body'], );
      if (message.notification != null) {
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
        print('Message also contained a notification: ${message.notification}');
        // notificationController.navigate(message.notification?.title??"",false);
      }
    });
  }
}
