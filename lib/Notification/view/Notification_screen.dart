import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../home/view/homescreen.dart';
import '../../widgets/TextFieldWidget.dart';
import '../provider/NotificationProvider.dart';
import '../provider/NotificationsProvider.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final notificationcount = ref.watch(not_countProvider);
    final notifications = ref.watch(notificationprovider);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Color(0xFF005373),
                        size: 30,
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Icon(
                        Icons.home_outlined,
                        color: Color(0xFF005373),
                        size: 30,
                      )),
                ]),],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "Notifications",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF005373)),
              )),
              SizedBox(
                height: 20,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              notificationcount.when(
                data: (data) =>
                    Center(child: Text("you have ${data.data} notifications ")),
                    error: (err, _) =>Text("you have 0 notifications"),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
              Center(
                  child: Text("Clear All ",
                      style: TextStyle(
                          color: Color(0xFF005373),
                          fontWeight: FontWeight.bold))),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: notifications.when(
                data: (data) =>data.data.length==0?Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(radius:50.sp,backgroundImage: AssetImage("assets/not.jpg",),backgroundColor: Colors.white,),
                        SizedBox(height: 10.h,),
                        Text(
                          "No Notifications Found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),),
                      ],
                    ),
                  ],
                ) : ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (data.data.length == 0) {
                          print("${data.data.length}lengthhh");
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "No Notifications ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF005373)),
                              ),

                            ],
                          );
                        }
                        print("${data.data.length}lengthhh");
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            color: Colors.grey[200],
                            child: Row(children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    backgroundImage:
                                        AssetImage("assets/personn.jpg"),
                                    radius: 40,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${data.data[index].titleEn}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${data.data[index].bodyEn}",
                                    style: TextStyle(),
                                  ),
                                ],
                              )
                            ]),
                          ),
                        );
                      },
                      itemCount: data.data.length,
                    ),
                error: (err, _) => Text(""),
                loading: () => Center(child: CircularProgressIndicator())),
          )
        ],
      ),
    );
  }
}
