import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanger/core/SharedPreferenceInfo.dart';
import 'package:taskmanger/core/utils.dart';
import 'package:taskmanger/home/provider/HomeProvider.dart';
import 'package:taskmanger/home/view/ProjectsProgress.dart';
import 'package:taskmanger/home/view/ProjectsScreen.dart';
import 'package:taskmanger/main.dart';
import '../../Admin_projects/model/Admin_ProjectModel.dart';
import '../../Admin_projects/provider/Admin_Projectsprovider.dart';
import '../../Notification/provider/NotificationProvider.dart';
import '../../Notification/view/Notification_screen.dart';
import '../../core/Color.dart';
import '../../profile/profile.dart';
import '../../widgets/TextFieldWidget.dart';
import '../model/statisticsmodel.dart';
import '../provider/DeviceTokenProvider.dart';
import '../provider/ProjectInfoProvider.dart';
import 'detailsscreen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {



  onStatusChang(String key) {
    if (key == "DONE") {
      return Itemcolors[0];
    } else if (key == "ON_GOING") {
      return Itemcolors[3];
    } else if (key == "TO_DO") {
      return Itemcolors[2];
    } else if (key == "HOLD") {
      return Itemcolors[1];
    }
  }

  List<String>listname = ["TO_DO", "DONE", "HOLD", "ON_GOING"];
  List<Color> Itemcolor = <Color>[
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.redAccent,

  ];

  String device_token = '';

  DateTime now = DateTime.now();
  String formatter = DateFormat('d-M-y').format(DateTime.now());
  late SharedPreferences sf;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  void handlemessagenotifiction() async {
    navigatorkey.currentState
        ?.push(MaterialPageRoute(builder: (context) => NotificationScreen()));
  }

  Future _firebasemessagingbackgroundHandler(RemoteMessage? message) async {
    debugPrint("Handling Background Message ${message}");
  }

  void requestpermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FirebaseMessaging.instance
        .getInitialMessage()
        .then(_firebasemessagingbackgroundHandler);
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
    // await FirebaseMessaging.instance.getInitialMessage().then(handlemessagenotification);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    await FirebaseMessaging.instance.getToken().then((value) async {
      setState(() {
        device_token = value ?? " ";
        SharedPreferencesInfo.saveDeviceIdSF(device_token);
        var response = ref.read(deviceTokenProvider).postDeviceToken(value!);
        print("{devicetokennnnnnnnnnnnnnnnnnnnn+${value}");
        savetoken(value);
        debugPrint("tokennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn**:${value}:***");
      });
    });
  }

  void savetoken(String token) async {
    await FirebaseFirestore.instance
        .collection("usertoken")
        .doc("users")
        .set({'token': token});
  }
int idpro=0;
String img="";
  String type="";
  gettingUserType() async {

    await SharedPreferencesInfo.getUserTypeFromSF().then((value) {
      setState(() {
        type = value!;
        print("nameeeeeeeeeeeeee$type");
      });
    });
    await SharedPreferencesInfo.getUserimg().then((value) {
      setState(() {
        img = value!;
        print("nameeeeeeeeeeeeee$type");
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback((_) async {
      Future.delayed(Duration(seconds: 1));

      ref.read(AdminprojectsProvider);
    });
    getToken();
    gettingUserType();
    postDeviceToken();
  }

  postDeviceToken() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final String? token =
    shared.getString('${SharedPreferencesInfo.deviceTokenKey}');


  }
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    final projects = ref.watch(proProvider);
    final statitic = ref.watch(statisticProvider);
    final statiticadmin = ref.watch(statisticadminProvider);
    final notificationcount = ref.watch(not_countProvider);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            backgroundColor: Color(0xFF005373),
            title: TextFieldHeaderWidget(
              title: "Home",
              colors: Colors.white,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Container(
                  height: 130,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()));
                    },
                    child: Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Icon(
                          Icons.notification_add,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      notificationcount.when(
                        data: (data) =>
                            CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 10,
                                child: Text(
                                  "${data.data}",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                        error: (err, _) => Text(""),
                        loading: () =>
                            Center(child: CircularProgressIndicator()),
                      )
                    ]),
                  ),
                ),
                color: Colors.black,
              ),
              IconButton(
                onPressed: () {},
                icon: Container(
                  height: 130,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profilescreen()));
                    },
                    child:img ==""? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        image: AssetImage("assets/personn.jpg"),
                        width: 50,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ):ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        image: NetworkImage(img),
                        width: 50,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                color: Colors.black,
              ),
              SizedBox(
                width: 20,
                height: 20,
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               type=="admin"? Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextFieldTitleWidget(
                   title: "My Projects",
                   size: 16.sp,
                 ),
               ):
               Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldTitleWidget(
                    title: "My Task",
                    size: 16.sp,
                  ),
                )
              ],
            ),
            type=="admin"?Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFDDE3E5)),
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 3.8,
              width: double.infinity,
              child: statiticadmin.when(
                  data: (data) =>
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
                              children: List.generate(data.data.length,
                                      (index) {
                                    return Container(
                                      height: 100,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Itemcolor[index]),
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
                                              child: Text(data.data[index].key,
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
                                                      left: 5, top: 7, right: 30),
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
                  error: (err, _) {  Center(child: Text("${err}"));
                  print("${err}errrr");},
                  // Center(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           TextFieldTitleWidget(
                  //             title: "Oops!! \n"
                  //                 "Connection Lost!",
                  //             fontWeight: FontWeight.bold,
                  //             size: 18.sp,
                  //           ),
                  //           SizedBox(width: 5.sp),
                  //           CircleAvatar(
                  //             backgroundImage: AssetImage(
                  //               "assets/sad.jpg",
                  //             ),
                  //             radius: 18.sp,
                  //             backgroundColor: Colors.grey,
                  //             foregroundColor: Colors.grey,
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  loading: () => Center(child: CircularProgressIndicator())),
            ):
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFDDE3E5)),
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 3.8,
              width: double.infinity,
              child: statitic.when(
                  data: (data) =>
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
                          children: List.generate(data.data.length,
                                  (index) {
                                return Container(
                                  height: 100,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Itemcolor[index]),
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
                                          child: Text(data.data[index].key,
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
                                                  left: 5, top: 7, right: 30),
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
                  error: (err, _) {  Center(child: Text("${err}"));
                    print("${err}errrr");},

                  loading: () => Center(child: CircularProgressIndicator())),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFieldTitleWidget(
                    title: "Latest project",
                    size: 16.sp,
                  ),
                ),
                InkWell(
                  onTap: () {
                    FirebaseMessaging.instance.subscribeToTopic("topic");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProjectsScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFieldTitleWidget(
                      title: "see More",
                      colors: Colors.grey,
                      size: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
                flex: 1,
                child: projects.when(
                    data: (data) =>
                RefreshIndicator(
                          backgroundColor: context.appTheme.bottomAppBarColor,
                          onRefresh: () async {
                            ref.refresh(proProvider);
                            // await ref.read(MainTasksProvider.future);
                            return Future.delayed(Duration(milliseconds: 300),
                                    () => ref.read(proProvider.future));
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
                              ),

                            ),
                            child: data.data.isEmpty ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(radius:40.sp,backgroundImage: AssetImage("assets/placeholder.png",),),
                                  SizedBox(height: 5.h,),
                                    Text(
                                        "Start Now",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),),
                                  ],
                                ),
                              ],
                            ) : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {

                                final adminprojects = ref.watch(
                                    AdminprojectsProvider);
                                   int projectid=data.data[index].id;
                                final usersData = data.data[index];
                                return data.data.isEmpty
                                    ? Text("no project",
                                  style: TextStyle(color: Colors.black),)
                                    : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Detailsscreen(
                                                  name: data.data[index].name ??
                                                      "",
                                                  subject: data.data[index]
                                                      .subject ??
                                                      "",
                                                  notes:
                                                  data.data[index].notes ??
                                                      "",
                                                  startDate: usersData.startingDate,
                                                  endDate: data.data[index].expectedExpiryDate,
                                                  status:
                                                  data.data[index].status ??
                                                      '',
                                                  project_id:
                                                  data.data[index].id,
                                                )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: 7, top: 16, left: 5, right: 5),
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height / 6,
                                    width: 100.w,
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
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextFieldTitle2Widget(
                                                  title: usersData.name ?? " ",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10,
                                                top: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    TextFieldTitleWidget(
                                                      title: "Progress",
                                                      colors: Colors.grey,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 90.0),
                                                      child: TextFieldTitleWidget(
                                                        title: "45%" ?? " ",
                                                        colors: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ref.watch(ProjectinfoProvider(projectid)).when(
                                                  data: (dataa)=>Column(
                                                    children: [
                                                      // Expanded(child : ListView.builder(shrinkWrap: true,itemBuilder: (context,index){return Text("jihuih");},itemCount: 2,)),
                                                      CircleAvatar(child: Image.network(dataa.data.employees[0].image),),
                                                    ],
                                                  ),
                                                      // Expanded(
                                                      //   child: ListView.builder(
                                                      //       shrinkWrap: true,
                                                      //                  //  physics: ClampingScrollPhysics(),
                                                      //                     scrollDirection: Axis.horizontal,
                                                      //                     itemCount: 2,
                                                      //                     itemBuilder: (BuildContext context, int indexadmin) {
                                                      //                       return Text("${dataa.data.employees[indexadmin].image}");
                                                      //                         // CircleAvatar(
                                                      //                         //   backgroundImage:
                                                      //                         //       AssetImage(
                                                      //                         //     "${dataa?.data[index].employeeProjects[indexadmin].image}",
                                                      //                         //   ),
                                                      //                         //   radius:
                                                      //                         //       12,
                                                      //                         //   backgroundColor:
                                                      //                         //       Colors.white60);
                                                      //                     }),
                                                      // ),
                                                    error: (err, _) { return  Center(child: Text("${err}"));
                                                    print("${err}errrr");},

                                                    loading: () => Center(child: CircularProgressIndicator())),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           left: 39.0),
                                                //   child: RefreshIndicator(
                                                //       backgroundColor: context.appTheme.bottomAppBarColor,
                                                //       onRefresh: () async {
                                                //         ref.refresh( adminprojectProvider(data.data[index].id));
                                                //         return Future.delayed(Duration(milliseconds: 300),
                                                //                 () => ref.read( adminprojectProvider(data.data[index].id)));
                                                //       },
                                                //     child: adminprojects.when(
                                                //         data: (dataa) =>
                                                //         ListView.builder(
                                                //           shrinkWrap: true,
                                                //             physics: ClampingScrollPhysics(),
                                                //             scrollDirection: Axis.horizontal,
                                                //                 itemCount: dataa?.data[index].employeeProjects.length,
                                                //                 itemBuilder: (BuildContext context, int indexadmin) {
                                                //                   return Text("${90}");
                                                //
                                                //                     // CircleAvatar(
                                                //                     //   backgroundImage:
                                                //                     //       AssetImage(
                                                //                     //     "${dataa?.data[index].employeeProjects[indexadmin].image}",
                                                //                     //   ),
                                                //                     //   radius:
                                                //                     //       12,
                                                //                     //   backgroundColor:
                                                //                     //       Colors.white60);
                                                //                 }),
                                                //         error: (err, _) =>
                                                //             Text("$err"),
                                                //         loading: () => Center(
                                                //             child:
                                                //                 CircularProgressIndicator())),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    LinearPercentIndicator(
                                                        width: 200.0,
                                                        lineHeight: 8.0,
                                                        percent: 0.45,
                                                        progressColor:
                                                        Color(0xFF005373),
                                                        linearStrokeCap:
                                                        LinearStrokeCap
                                                            .round),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                      child: Row(
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
                                                              color:
                                                              Color(0xFF005373),
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
                                                                  left:
                                                                  5.0),
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
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: data.data.length,
                            ),
                          ),
                        ),
                    error: (err, _) => Text(""),
                    loading: () => Center(child: CircularProgressIndicator(),)))]),
        ));
  }


}

class PushNotification {
  String? title;
  String? body;

  PushNotification({this.body, this.title});
}
