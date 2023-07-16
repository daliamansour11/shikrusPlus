import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:taskmanger/Authentication/login/model/Users.dart';
import 'package:taskmanger/Authentication/login/provider/LoginProvider.dart';

import 'package:taskmanger/core/SharedPreferenceInfo.dart';

import '../../../screens/bottomnavigation.dart';

class LoginScreen extends ConsumerStatefulWidget{
  @override
  ConsumerState<LoginScreen> createState() =>_LoginScreenState();
}
class _LoginScreenState extends ConsumerState<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool showSpinner =false;
  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }
  static String userToken = "USERTOKENKEY";

  TextEditingController userEmailController =  TextEditingController();

  TextEditingController passwordController =  TextEditingController();

  bool ischecked = false;

  late String? email;

  late String? password;
  bool isvisible =true;

  void _toggle() {
    setState(() {
      isvisible = !isvisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(

        body: Container(
            decoration: BoxDecoration(
              color: Color(0xFF005373),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(35),
                topLeft: Radius.circular(35),
              ),
            ),
            child: Column(
                children: [
                  Expanded(
                      flex: 1,


                      child: Padding(
                        padding: const EdgeInsets.only(top: 38.0),
                        child: SizedBox(
                          height: 10.0,
                          child: Container(
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/task.jpg'),
                              radius: 60,
                            ),

                          ),
                        ),
                      )),
                  // SizedBox(height: 10,),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 0),
                    child: const Text("LOGIN",
                      style: TextStyle(fontSize: 27,
                          color: Colors.white),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                  ),


                  SizedBox(height: size.height * 0.03,),
                  SizedBox(
                    height: 4,
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFDDE3E5),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                            topLeft: Radius.circular(35),
                          ),),

                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFDDE3E5),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(35),
                              topLeft: Radius.circular(35),
                            ),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        // Container(
                                        //
                                        //   child: CircleAvatar(
                                        //     backgroundImage: AssetImage('assets/task.jpg'),
                                        //     radius: 60,
                                        //   ),
                                        //
                                        // ),

                                        Container(
                                          // decoration: BoxDecoration(color: Colors.white,
                                          // borderRadius: BorderRadius.all(Radius.circular(10)),

                                          // ),

                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: TextFormField(

                                              controller: userEmailController,
                                              obscureText: false,
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value == null) {
                                                  return "please enter  your email";
                                                }
                                                else if (!value.contains("@") ||
                                                    !value.contains(".")) {
                                                  return " please enter valide email address";
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {

                                              },
                                              keyboardType: TextInputType
                                                  .emailAddress,
                                              decoration: InputDecoration(

                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(20)
                                                  ),),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1,

                                                  ),

                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(20)
                                                  ),

                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2,

                                                  ),
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(20)

                                                  ),
                                                ),
                                                // labelText: "UserEmail", //babel text
                                                hintText: "Enter Email",

                                                contentPadding: EdgeInsets
                                                    .symmetric(
                                                    vertical: 1, horizontal: 5),
                                                //hint text
                                                prefixIcon: Icon(Icons.email),
                                                //prefix iocn
                                                hintStyle: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black45),
                                                //hint text style
                                                labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors
                                                        .redAccent), //label style

                                              ),

                                            )

                                        ),
                                        SizedBox(height: size.height * 0.03,),

                                        Container(

                                          // decoration: BoxDecoration(color: Colors.white,
                                          // borderRadius: BorderRadius.all(Radius.circular(10)),
                                          // ),

                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: TextFormField(
                                              controller: passwordController,
                                              obscureText: isvisible,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "please password is required";
                                                }
                                                else if (value.length < 8) {
                                                  return "password should be 8 character or more characters";
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {

                                              },
                                              keyboardType: TextInputType
                                                  .visiblePassword,
                                              decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  icon: Icon(isvisible
                                                      ? Icons.visibility_off :
                                                  Icons.visibility),
                                                  onPressed: _toggle,
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(20))),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1,

                                                  ),

                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(20)
                                                  ),

                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2,

                                                  ),
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(20)

                                                  ),
                                                ),
                                                // labelText: "password", //babel text
                                                hintText: "Enter your password",
                                                contentPadding: EdgeInsets
                                                    .symmetric(vertical: 1,
                                                    horizontal: 10),

                                                //hint text
                                                prefixIcon: Icon(
                                                    Icons.password),
                                                //prefix iocn
                                                hintStyle: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black45),
                                                //hint text style
                                                labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors
                                                        .redAccent), //label style

                                              ),

                                            )


                                        ),
                                        SizedBox(height: size.height * 0.03,),

                                        Container(
                                          width: 200,
                                          height: 70,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(left: 10,
                                              right: 30,
                                              top: 10,
                                              bottom: 0),
                                          child: ElevatedButton(

                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(
                                                  0xFF005373),
                                              elevation: 5,
                                              padding: EdgeInsets.all(20.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(25.0),

                                              ),

                                            ),
                                            onPressed: () async {
                                              if (userEmailController.text
                                                  .isEmpty ||
                                                  userEmailController.text ==
                                                      null &&
                                                      passwordController.text
                                                          .isEmpty ||
                                                  passwordController.text ==
                                                      null) {
                                                _submit();
                                              }
                                              else {
                                                var user = Users_model(
                                                    "name",
                                                    userEmailController.text
                                                        .trim(),
                                                    "phone",
                                                    passwordController.text
                                                        .trim(),
                                                    "uId",
                                                    true,
                                                    "",
                                                    "",
                                                    []);
                                                var response = await ref.read(
                                                    logedInProvider).onLogedIn(
                                                    user);
                                                if (response.status == true) {
                                                  userEmailController.clear();
                                                  passwordController.clear();
                                                  _formKey.currentState!
                                                      .reset();
                                                   print("iddddddddddddddddddddddd${response.data!.personalInformation.id}");
                                                  SharedPreferencesInfo
                                                      .saveUserEmailSF(
                                                      response.data!
                                                          .personalInformation
                                                          .email);
                                                  SharedPreferencesInfo
                                                      .saveUserIdSF(
                                                      response.data!.personalInformation.id);
                                                  SharedPreferencesInfo
                                                      .saveUserLoggedInStatus(
                                                      response.status ?? false);
                                                  SharedPreferencesInfo
                                                      .saveUserTokenSF(
                                                      response.data?.token??
                                                          "");
                                                  print(response.data
                                                      ?.personalInformation
                                                      .email);
                                                  print(response.data?.token);
                                                }
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(content: Text(
                                                      "${response.msg}"),
                                                    duration: const Duration(
                                                        seconds: 4),
                                                    backgroundColor:
                                                    (response.status == true)
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                );
//sm3021914@gmail.c
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Bottomnavigation()));
                                              }
                                            },
                                            child: Text(
                                                "LogIn",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18)
                                            ),
                                          ),
                                        ),


                                        SizedBox(height: size.height * 0.04,),


                                      ])
                              )


                          ),
                        ),
                      )

                  )
                ]
            )
        )

    );
  }}