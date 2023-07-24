import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskmanger/core/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:taskmanger/screens/splashscreen.dart';
import 'FirebaseApi.dart';
import 'Notification/Notification_helper.dart';
import 'core/Constant.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

late Size mq;

final navigatorkey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: AppConst.WebKey,
            appId: AppConst.AppId,
            messagingSenderId: AppConst.projectNumber,
            projectId: AppConst.projectId));
  } else {
    await Firebase.initializeApp(
      name: "task_app",
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // var result = await FlutterNotificationChannel.registerNotificationChannel(
    //   description: 'Showing Message Notifications',
    //   id: 'chats',
    //   importance: NotificationImportance.IMPORTANCE_HIGH,
    //   name: 'Chats',
    // );
  }
  await NotificationHelper.init();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(FirebaseBackgroundHandler);
  NotificationHelper.initInfo();
  // AwesomeNotifications().initialize("resource//drawable/not", Nitification)
 // NotificationHelper.requestPermission();
  // await Firebase.initializeApp( name: 'chat-app',
  //   options:DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(ProviderScope(child: const MyApp()));
}

Future<void> FirebaseBackgroundHandler(RemoteMessage remoteMessage) async {
  print("Handling background message${remoteMessage.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(),
            home: Splashscreen(),
            // AnimatedSplashScreen(
            //      splash: Image(image:
            //      ResizeImage(AssetImage('assets/task.jpg'), width: 500, height: 400)),
            //      duration: 3000,
            //      splashTransition: SplashTransition.scaleTransition,
            //      backgroundColor: Colors.white,
            //      nextScreen:Onboarding() ,
            //    // // ),
            //  ))
          );
        });
  }
// Widget LoginScreen;
}
