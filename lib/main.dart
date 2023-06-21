
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/core/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:taskmanger/screens/splashscreen.dart';
import 'core/Constant.dart';
 late Size mq;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp( name: 'chat-app',
  //   options:DefaultFirebaseOptions.currentPlatform,
  // );
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
  runApp(ProviderScope(child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
   home:Splashscreen(),
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
  }
  // Widget LoginScreen;


}
