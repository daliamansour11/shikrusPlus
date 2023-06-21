// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:tasksapp/Authentication/login/model/LoginModel.dart';
// import 'package:tasksapp/Authentication/login/view/Login.dart';
// import 'package:tasksapp/core/SharedPreferenceInfo.dart';
//
// import 'bottomnavigation.dart';
//
// class Onboarding extends StatefulWidget {
//   @override
//   State<Onboarding> createState() => _OnboardingState();
// }
//
// class _OnboardingState extends State<Onboarding> {
//   final controller = PageController();
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   bool isLastPage = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.only(bottom: 80.0),
//         child: PageView(
//           controller: controller,
//           onPageChanged: (index) {
//             setState(() {
//               isLastPage = index == 2;
//             });
//           },
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Container(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 40,),
//                     Center(
//                       child: Row(
//                         children: [
//                         Center(
//                           child: SmoothPageIndicator(
//                             count: 3,
//                             controller: controller,
//                             effect: WormEffect(
//                                 spacing: 15,
//                              // expansionFactor: 3,
//                                 dotWidth: 115,
//                                 radius: 20,
//                                 strokeWidth: 1,
//                                 dotHeight: 8,
//                                 dotColor: Colors.black26,
//                                 activeDotColor: Colors.blue),
//                             onDotClicked: (index) => controller.animateToPage(index,
//                                 duration: Duration(milliseconds: 500),
//                                 curve: Curves.easeInOut),
//                           ),
//                         ),
//                       ],),
//                     ),
//                     SizedBox(height: 10,),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Checkbox(value: true, onChanged: (val){}),
//                             Text("Shikrsplus",style: TextStyle(color: Colors.blue),),
//                           ],
//                         ),
//                         InkWell(
//                             onTap: (){
//                               Navigator.of(context).pushReplacement(
//                                   MaterialPageRoute(builder: (context) => LoginScreen()));
//                             },
//                             child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),))
//                       ],
//                     ),
//
//
//                     SizedBox(height: 30,),
//                     Text.rich(TextSpan(
//                         text: "Manage Your Daily Activities with",
//                         style: TextStyle(
//                             color: Colors.indigo,
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold),
//                         children: [
//                           TextSpan(
//                               text: "Shikrsplus",
//                               style: TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 30))
//                         ])),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Image.asset(
//                       "assets/onboard1.png",
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Text(
//                         "As the name said Shikrsplus,we will give you the easiest way to manage your day to day activities ",
//                         style: TextStyle(color: Colors.indigo))
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Container(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 40,),
//                     Center(
//                       child: Row(
//                         children: [
//                           Center(
//                             child: SmoothPageIndicator(
//                               count: 3,
//                               controller: controller,
//                               effect: WormEffect(
//                                   spacing: 15,
//                                //   expansionFactor: 3,
//                                   dotWidth: 115,
//                                   radius: 20,
//                                   strokeWidth: 1,
//                                   dotHeight: 8,
//                                   dotColor: Colors.black26,
//                                   activeDotColor: Colors.blue),
//                               onDotClicked: (index) => controller.animateToPage(index,
//                                   duration: Duration(milliseconds: 500),
//                                   curve: Curves.easeInOut),
//                             ),
//                           ),
//                         ],),
//                     ),
//                     SizedBox(height: 10,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Checkbox(value: true, onChanged: (val){}),
//                             Text("Shikrsplus",style: TextStyle(color: Colors.blue),),
//                           ],
//                         ),
//                         InkWell(
//                             onTap: (){
//
//                                     Navigator.of(context).pushReplacement(
//                                         MaterialPageRoute(builder: (context) => LoginScreen()));
//                                   },
//
//                             child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),))
//                       ],
//                     ),
//                     SizedBox(height: 30,),
//                     Text.rich(TextSpan(
//                         text: "Manage Your Daily Activities with",
//                         style: TextStyle(
//                             color: Colors.indigo,
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold),
//                         children: [
//                           TextSpan(
//                               text: "Shikrsplus",
//                               style: TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 30))
//                         ])),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Image.asset(
//                       "assets/onboard1.png",
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Text(
//                         "As the name said Shikrsplus,we will give you the easiest way to manage your day to day activities ",
//                         style: TextStyle(color: Colors.indigo))
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Container(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 40,),
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Center(
//                             child: SmoothPageIndicator(
//                               count: 3,
//                               controller: controller,
//                               effect: WormEffect(
//                                   spacing: 15,
//                                 //  expansionFactor: 5,
//                                   dotWidth: 115,
//                                   radius: 20,
//                                   strokeWidth: 1,
//                                   dotHeight: 8,
//                                   dotColor: Colors.black26,
//                                   activeDotColor: Colors.blue),
//                               onDotClicked: (index) => controller.animateToPage(index,
//                                   duration: Duration(milliseconds: 500),
//                                   curve: Curves.easeInOut),
//                             ),
//                           ),
//                         ],),
//                     ),
//                     SizedBox(height: 10,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Checkbox(value: true, onChanged: (val){}),
//                             Text("Shikrsplus",style: TextStyle(color: Colors.blue),),
//                           ],
//                         ),
//                         InkWell(
//                             onTap: (){
//
//                                     Navigator.of(context).pushReplacement(
//                                         MaterialPageRoute(builder: (context) => LoginScreen()));
//                             },
//                             child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),))
//                       ],
//                     ),
//                     SizedBox(height: 30,),
//                     Text.rich(TextSpan(
//                         text: "Manage Your Daily Activities with",
//                         style: TextStyle(
//                             color: Colors.indigo,
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold),
//                         children: [
//                           TextSpan(
//                               text: "Shikrsplus",
//                               style: TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 30))
//                         ])),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Image.asset(
//                       "assets/onboard1.png",
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Text(
//                         "As the name said Shikrsplus,we will give you the easiest way to manage your day to day activities ",
//                         style: TextStyle(color: Colors.indigo))
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomSheet: Padding(
//         padding: const EdgeInsets.only(bottom: 15.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//
//               width: 200,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.indigo,
//                     borderRadius: BorderRadius.circular(20),
//               ),
//                  child: TextButton(
//                       onPressed: () {
//                         // Navigator.pushReplacement(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) => Bottomnavigation()));
//                       },
//                       child: Text(
//                         "Get Started",
//                         style: TextStyle(fontSize: 24,color: Colors.white),
//                       )),
//                ),
//           ],
//         ),
//       )
//
//     );
//   }
//
//
// }
