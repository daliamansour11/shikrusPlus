import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanger/core/SharedPreferenceInfo.dart';
import 'package:taskmanger/core/utils.dart';
import 'package:taskmanger/home/provider/HomeProvider.dart';
import 'package:taskmanger/home/view/ProjectsProgress.dart';
import 'package:taskmanger/home/view/ProjectsScreen.dart';
import '../../core/Color.dart';
import '../../profile/profile.dart';
import '../provider/DeviceTokenProvider.dart';

class HomeScreen extends  ConsumerStatefulWidget {
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends  ConsumerState<HomeScreen> {


  onStatusChang(String key) {
    if (key == "DONE") {
      return Itemcolors[0];
    } else if (key == "ON_GOING") {
      return Itemcolors[3];
    }
    else if (key == "TO_DO") {
      return Itemcolors[2];
    } else if (key == "HOLD") {
      return Itemcolors[1];
    }
  }

  String device_token = '';

  DateTime now = DateTime.now();
  String formatter = DateFormat('d-M-y').format(DateTime.now());
  late SharedPreferences sf;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;


    final projects = ref.watch(proProvider);

    final statitic = ref.watch(statisticProvider);

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(

            backgroundColor: Color(0xFF005373),
            title: Text("Home",
                style: GoogleFonts.balooBhai2(textStyle: TextStyle(fontSize: 25))),

            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(onPressed: () {}, icon: Container(
                height: 130,
                child: InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Profilescreen()));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Icon(Icons.notification_add, color: Colors.white,),
                  ),
                ),

              ), color: Colors.black,),
              IconButton(onPressed: () {}, icon: Container(
                height: 130,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Profilescreen()));
                  },
                  child: ClipRRect(

                    borderRadius: BorderRadius.circular(50),
                    child: Image(image: AssetImage(
                        "assets/personn.jpg"),

                      width: 50, height: 130, fit: BoxFit.cover,),
                  ),
                ),

              ), color: Colors.black,),

              SizedBox(width: 20, height: 20,)]),
        body:
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
              children: [

                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "My Task",
                                style: GoogleFonts.balooBhai2(textStyle: TextStyle(fontSize: 25))),



                    )
                  ],
                ),


                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFDDE3E5)
                  ),

                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 3.8,
                  width: double.infinity,
                  child: statitic.when(data: (data) =>
                      CustomScrollView(
                        primary: false,
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 10),
                            sliver: SliverGrid.count(
                              childAspectRatio: (1 / .5),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              children: List.generate(data.data.length, (
                                  index) {
                                return Container(
                                  height: 100,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: onStatusChang(
                                          "${data.data[index].key.name}")

                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProjectsProgress()));
                                    },

                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 3.0, top: 15, right: 50),
                                          child: Text(data.data[index].key.name,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ),
                                        // SizedBox(height: 7,),

                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5,
                                                  top: 7, right: 30),
                                              child: Text(
                                                  "${data.data[index]
                                                      .count} projects ",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.white)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Icon(Icons.arrow_forward,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),

                                      ],
                                    ),


                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      error: (err, _) =>
                          Text("$err", style: TextStyle(color: Colors.red),),
                      loading: () => Center(child: CircularProgressIndicator())
                  ),
                ),


                SizedBox(
                  height: 10,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [


                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Latest project",
                          style: GoogleFonts.balooBhai2(textStyle: TextStyle(fontSize: 22))),

                    ),

                    InkWell(

                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProjectsScreen()));
                      },

                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "see More",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 5,
                ),
                Expanded(
                    flex: 1,
                    child: projects.when(
                        data: (data) =>

                            RefreshIndicator(
                              backgroundColor: context.appTheme
                                  .bottomAppBarColor,
                              onRefresh: () async {
                                ref.refresh(proProvider);
                                // await ref.read(MainTasksProvider.future);
                                return Future.delayed(
                                    Duration(milliseconds: 300), () =>
                                    ref.read(proProvider.future));
                              },


                              child: Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height,
                                decoration: BoxDecoration(

                                  color: Color(0xFFDDE3E5),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(35),
                                    topLeft: Radius.circular(35),
                                  ),),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final usersData = data.data[index];
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 7,
                                          top: 16,
                                          left: 5,
                                          right: 5),
                                      height: 130,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 10.0),
                                                  child: Text(
                                                    usersData.name ?? " ",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 25),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: 10.0,
                                                      right: 10,
                                                      top: 0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Progress",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[700],
                                                            fontSize: 15),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            left: 90.0),
                                                        child: Text(
                                                          "45%" ??
                                                              " ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[700],
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            left: 39.0),
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                                backgroundImage:
                                                                AssetImage(
                                                                  "assets/personn.jpg",
                                                                ),
                                                                radius: 12,
                                                                backgroundColor:
                                                                Colors.white60),
                                                            CircleAvatar(
                                                                backgroundImage:
                                                                AssetImage(
                                                                  "assets/ppr.jpg",
                                                                ),
                                                                radius: 12,
                                                                backgroundColor:
                                                                Colors.white60),
                                                            CircleAvatar(
                                                                backgroundImage:
                                                                AssetImage(
                                                                  "assets/ppr.jpg",
                                                                ),
                                                                radius: 12,
                                                                backgroundColor:
                                                                Colors.white60),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15.0),
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 20,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      LinearPercentIndicator(
                                                          width: 200.0,
                                                          lineHeight: 8.0,
                                                          percent: 0.45,
                                                          progressColor: Colors
                                                              .blue,
                                                          linearStrokeCap:
                                                          LinearStrokeCap.round

                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 5.0,
                                                                right: 10),
                                                            child: Icon(
                                                              Icons
                                                                  .access_time_filled,
                                                              color: Colors
                                                                  .blue,
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                left: 5.0,
                                                              ),
                                                              child: Text(
                                                                  usersData
                                                                      .startingDate!
                                                                      .year
                                                                      .toString() +
                                                                      "-" +
                                                                      usersData
                                                                          .startingDate!
                                                                          .month
                                                                          .toString() +
                                                                      "-" +
                                                                      usersData
                                                                          .startingDate!
                                                                          .day
                                                                          .toString())),
                                                          Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 5.0),
                                                              child: Text("_")),
                                                          Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 5.0,
                                                                  right: 6),
                                                              child: Text(
                                                                  usersData
                                                                      .expectedExpiryDate!
                                                                      .year
                                                                      .toString() +
                                                                      "-" +
                                                                      usersData
                                                                          .expectedExpiryDate!
                                                                          .month
                                                                          .toString() +
                                                                      "-" +
                                                                      usersData
                                                                          .expectedExpiryDate!
                                                                          .day
                                                                          .toString())),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    );
                                  },
                                  itemCount: data.data.length,
                                ),
                              ),),
                        error: (err, _) =>
                            Text(
                              "$err",
                              style: TextStyle(color: Colors.red),
                            ),
                        loading: () =>
                            Center(child: CircularProgressIndicator()))),


              ]),
        )

    );
  }

  Future _firebasemessagingbackgroundHandler(RemoteMessage message) async {
    debugPrint("Handling Background Message ${message}");
  }

  void requestpermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebasemessagingbackgroundHandler);
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("user granted permission");
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification pushnotification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body);
        setState(() {
          // notificationInfo = pushnotification;
        });
        // if (notificationInfo != null) {
        //   showSimpleNotification(
        //       Text(notificationInfo?.title??" "),
        //       leading: Notificationpage(totalnotification:totalnotification ,),
        //       duration: Duration(seconds: 2),
        //       subtitle: Text(notificationInfo?.title ?? " "),
        //       background: Colors.green.shade500);
      }
        //   });
        // } else if (settings.authorizationStatus ==
        //     AuthorizationStatus.provisional) {
        //   debugPrint("user provisional permission");
        // } else {
        //   debugPrint("user declined or has accepted permission");

      );
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((value) async {
      setState(() {
        device_token = value ?? " ";
        SharedPreferencesInfo.saveDeviceIdSF(device_token);


        savetoken(value!);
        debugPrint("tokennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn${value}nn");
      });
    });
  }


  void savetoken(String token) async {
    await FirebaseFirestore.instance
        .collection("usertoken")
        .doc("users")
        .set({'token': token});
  }

  @override
  void initState() {
    getToken();
    Future.delayed
      (Duration(milliseconds: 40),() async {
      postDeviceToken();
    });
  }
  postDeviceToken() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final String? token = shared.getString(
        '${SharedPreferencesInfo.deviceTokenKey}');

    var response = ref.read(deviceTokenProvider).postDeviceToken(token!);
    print("{tokennnnnnnnnnnnnnnnnnnnn+${response}");
  }
}
class PushNotification {
  String? title;
  String? body;
  PushNotification({this.body,this.title});

}

