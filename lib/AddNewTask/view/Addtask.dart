import 'package:date_field/date_field.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taskmanger/Admin_projects/model/Admin_ProjectModel.dart';
import 'package:taskmanger/core/utils.dart';
import 'package:taskmanger/home/model/ProjectInfoModel.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';
import 'package:taskmanger/home/view/homescreen.dart';
import '../../Admin_projects/provider/Admin_Projectsprovider.dart';
import '../../Notification/Notification_helper.dart';
import '../../core/SharedPreferenceInfo.dart';
import '../../home/provider/HomeProvider.dart';
import '../../home/provider/ProjectInfoProvider.dart';
import '../../profile/profile.dart';
import '../../screens/bottomnavigation.dart';
import '../../widgets/TextFieldWidget.dart';
import '../provider/AddNewTaskProvider.dart';
import 'dropfield.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  int project_id;

  AddTaskScreen({
    required this.project_id,
  });

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  List<String> _selectedItems = [];

  void _showMultiSelect() async {
    final List<String> items = [
      'Flutter',
      'Node.js',
      'React Native',
      'Java',
      'Docker',
      'MySQL'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
        print("${_selectedItems}itemm");
      });
    }
  }

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool showSpinner = false;
  var SelectedType;

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  DateTime? _selectedDate;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController mainNameController = TextEditingController();
  TextEditingController subNameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  String project = ' ';
  int idpro = 0;
  String type = "";

  gettingUserType() async {
    await SharedPreferencesInfo.getUserTypeFromSF().then((value) {
      setState(() {
        type = value!;
        print("nameeeeeeeeeeeeee$type");
      });
    });
  }

  @override
  void initState() {
    gettingUserType();
    // WidgetsBinding.instance.addPersistentFrameCallback((_) async {
    //   Future.delayed(Duration(seconds: 1));
    //
    //   ref.read(adminprojectProvider(idpro));
    // });
  }
  String? proj = "";
  @override
  Widget build(BuildContext context) {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'dbfood', 'dbfood', importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    final projects = ref.read(proProvider);
    //final employees =ref.watch(adminprojectProvider(idpro));
    Size size = MediaQuery.of(context).size;
    List<String> _selectedItems = [];

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Color(0xFF005373),
          title: TextFieldHeaderWidget(
            title: "AddNewTask",
            colors: Colors.white,
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                            EdgeInsets.only(left: 12.w, bottom: 2.h, top: 10.h),
                        child: TextFieldTitleWidget(
                          title: "Name",
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: TextFormField(
                          controller: mainNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter name";
                            } else if (value.length < 6) {
                              return "Too short title,choosea title with 6 character or more characters";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF005373),
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            // labelText: "Title", //babel text
                            hintText: " title ",
                            //hint text
                            prefixIcon: Icon(Icons.title),
                            //prefix iocn
                            hintStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400), //hint text style
                            //  labelStyle: TextStyle(fontSize: 13, color: Colors.white), //label style
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 12, top: 2, bottom: 1),
                        child: TextFieldTitleWidget(
                          title: "Subject",
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: TextFormField(
                          controller: subjectController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter your subject";
                            } else if (value.length < 4) {
                              return "Too short title,choosea title with 6 character or more characters";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF005373),
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            // labelText: "Title", //babel text
                            hintText: " subject ",
                            //hint text
                            prefixIcon: Icon(Icons.title),
                            //prefix iocn
                            hintStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400), //hint text style
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 12, top: 2, bottom: 1),
                        child: TextFieldTitleWidget(
                          title: "Note",
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: TextFormField(
                            // maxLines: 1,
                            controller: noteController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please enter your notes";
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF005373),
                                  width: 2,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              //labelText: "Note", //babel text
                              hintText: "Enter your Note",
                              //hint text
                              prefixIcon: Icon(Icons.note),
                              //prefix iocn
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.w400), //hint text style
                              //    labelStyle: TextStyle(fontSize: 13, color: Colors.white), //label style
                            ),
                          )),
                      // Container(
                      //   alignment: Alignment.topLeft,
                      //   margin: EdgeInsets.only(left: 12, top: 2, bottom: 1),
                      //   child: TextFieldTitleWidget(
                      //     title: "Project Name",
                      //     size: 16.sp,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(left: 12.0, top: 2, right: 8),
                      //   child: projects.when(
                      //       data: (dataa) => ListView.builder(
                      //           shrinkWrap: true,
                      //           itemCount: dataa.data.length,
                      //           itemBuilder: (BuildContext context, int index) {
                      //             List<String> emptyy = [];
                      //             if (dataa.data.isEmpty) {
                      //               // return SizedBox(
                      //               //   width: 200,
                      //               //   child: DropdownButtonFormField<String>(
                      //               //       decoration: InputDecoration(
                      //               //         enabledBorder: OutlineInputBorder(
                      //               //             borderSide: BorderSide(
                      //               //               width: 0,
                      //               //               color: Colors.grey,
                      //               //             ),
                      //               //             borderRadius:
                      //               //             BorderRadius.circular(10)),
                      //               //         focusedBorder: OutlineInputBorder(
                      //               //             borderSide: BorderSide(
                      //               //               width: 2,
                      //               //               color: Color(0xFF005373),
                      //               //             ),
                      //               //             borderRadius:
                      //               //             BorderRadius.circular(10)),
                      //               //         errorBorder: OutlineInputBorder(
                      //               //             borderSide: BorderSide(
                      //               //               width: 2,
                      //               //               color: Color(0xFF005373),
                      //               //             ),
                      //               //             borderRadius:
                      //               //             BorderRadius.circular(10)),
                      //               //       ),
                      //               //       value: "" ?? "",
                      //               //       items: emptyy.map((item) => DropdownMenuItem(
                      //               //           value: item,
                      //               //           child: Text(
                      //               //             item.toString(),
                      //               //             style: TextStyle(
                      //               //                 fontWeight: FontWeight.bold),
                      //               //           )))
                      //               //           .toList(),
                      //               //       onChanged: (item) {
                      //               //
                      //               //       }),
                      //               // );
                      //             }
                      //
                      //             List<String> pro_list_name = [];
                      //
                      //             String projectname =
                      //                 dataa.data[index].name ?? "";
                      //             pro_list_name.add(projectname);
                      //             String? pro_name = "";
                      //             List<Datum> projectmodel = dataa.data
                      //                 .where((element) =>
                      //                     element.name == projectname)
                      //                 .toList();
                      //             idpro = projectmodel[0].id ?? 0;
                      //             String? proj = "";
                      //             return SizedBox(
                      //               width: 200,
                      //               child: Row(
                      //                 children: [
                      //                   Text("${dataa.data[index].name ?? ""}"),
                      //                   Radio(
                      //                       value: dataa.data[index].name ?? "",
                      //                       groupValue: proj,
                      //                       activeColor: Colors.black,
                      //                       onChanged: (val) {
                      //                         setState(() {
                      //                           proj = val;
                      //                           print(proj);
                      //                         });
                      //                       }),
                      //                 ],
                      //               ),
                      //               // child: DropdownButtonFormField<String>(
                      //               //     decoration: InputDecoration(
                      //               //       enabledBorder: OutlineInputBorder(
                      //               //           borderSide: BorderSide(
                      //               //             width: 0,
                      //               //             color: Colors.grey,
                      //               //           ),
                      //               //           borderRadius:
                      //               //               BorderRadius.circular(10)),
                      //               //       focusedBorder: OutlineInputBorder(
                      //               //           borderSide: BorderSide(
                      //               //             width: 2,
                      //               //             color: Color(0xFF005373),
                      //               //           ),
                      //               //           borderRadius:
                      //               //               BorderRadius.circular(10)),
                      //               //       errorBorder: OutlineInputBorder(
                      //               //           borderSide: BorderSide(
                      //               //             width: 2,
                      //               //             color: Color(0xFF005373),
                      //               //           ),
                      //               //           borderRadius:
                      //               //               BorderRadius.circular(10)),
                      //               //     ),
                      //               //     value: dataa.data[index].name ?? "",
                      //               //     items: pro_list_name.map((item) => DropdownMenuItem(
                      //               //             value: item,
                      //               //             child: Text(
                      //               //               item.toString(),
                      //               //               style: TextStyle(
                      //               //                   fontWeight: FontWeight.bold),
                      //               //             )))
                      //               //         .toList(),
                      //               //     onChanged: (item) {
                      //               //       setState(() {
                      //               //         pro_name = item;
                      //               //         print("itemmm$pro_name");
                      //               //       });
                      //               //     }),
                      //             );
                      //           }),
                      //       error: (err, _) => Text(""),
                      //       loading: () =>
                      //           Center(child: CircularProgressIndicator())),
                      // ),

                      SizedBox(
                        height: size.width * 0.001,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF005373),
                                padding: EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  opendialog(ref);
                                });
                              },
                              child: Text("Select Project")),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF005373),
                                        padding: EdgeInsets.all(15.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() async {
                                          final List<String>? results =
                                          await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ref.watch(ProjectinfoProvider(idpro)).when(
                                                data: (dataa) => ListView.builder(
                                                  itemCount: 1,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                      int index) {
                                                    String nameemployee = dataa
                                                        .data
                                                        .employees[index]
                                                        .name;
                                                    print(
                                                        "${nameemployee}employeee");
                                                    List<String> names = [];
                                                    names.add(nameemployee);
                                                    print("${idpro}nammm");
                                                    return MultiSelect(
                                                        items: names);
                                                  },
                                                ),
                                                  error: (err, _) => Text("${err.toString()}"),
                                                  loading: () => Center(
                                                      child: CircularProgressIndicator())
                                              );
                                            },
                                          );

                                          if (results != null) {
                                            setState(() {
                                              _selectedItems = results;
                                              print("${_selectedItems}itemm");
                                            });
                                          }
                                        });
                                      },
                                      child: const Text('Select Employees'),
                                    ),

                                const Divider(
                                  height: 1,
                                ),
                                Wrap(
                                  children: _selectedItems
                                      .map((e) => Chip(
                                    label: Text(
                                      e,
                                      style:
                                      TextStyle(color: Colors.black),
                                    ),
                                  ))
                                      .toList(),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 0.001,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 12, bottom: 2),
                        child: TextFieldTitleWidget(
                          title: "Date",
                          size: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: startDateController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 2,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  hintStyle: TextStyle(color: Colors.black45),
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent),
                                  suffixIcon: Icon(Icons.event_note),
                                  labelText: 'startDate',
                                ),
                                onTap: () async {
                                  DateTime? newSelectedDate =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: _selectedDate != null
                                              ? _selectedDate!
                                              : DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2040),
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData.dark().copyWith(
                                                colorScheme: ColorScheme.dark(
                                                  primary: Colors.deepPurple,
                                                  onPrimary: Colors.white,
                                                  surface: Colors.blueGrey,
                                                  onSurface: Colors.yellow,
                                                ),
                                                dialogBackgroundColor:
                                                    Colors.blue[500],
                                              ),
                                              child: child!,
                                            );
                                          });
                                  if (newSelectedDate != null) {
                                    _selectedDate = newSelectedDate;
                                    startDateController
                                      ..text = DateFormat("yyyy-MM-dd")
                                          .format(_selectedDate!)
                                      ..selection = TextSelection.fromPosition(
                                          TextPosition(
                                              offset: startDateController
                                                  .text.length,
                                              affinity: TextAffinity.upstream));
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return "please enter  your startDate";

                                    // else if(!value .contains("@") ||!value .contains(".") ){
                                    //   return " please enter valide starttime ";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: endDateController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 2,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  hintStyle: TextStyle(color: Colors.black45),
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent),
                                  suffixIcon: Icon(Icons.event_note),
                                  labelText: 'endDate',
                                ),
                                onTap: () async {
                                  DateTime? newSelectedDate =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: _selectedDate != null
                                              ? _selectedDate!
                                              : DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2040),
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData.dark().copyWith(
                                                colorScheme: ColorScheme.dark(
                                                  primary: Colors.deepPurple,
                                                  onPrimary: Colors.white,
                                                  surface: Colors.blueGrey,
                                                  onSurface: Colors.yellow,
                                                ),
                                                dialogBackgroundColor:
                                                    Colors.blue[500],
                                              ),
                                              child: child!,
                                            );
                                          });
                                  if (newSelectedDate != null) {
                                    _selectedDate = newSelectedDate;
                                    endDateController
                                      ..text = DateFormat("yyyy-MM-dd")
                                          .format(_selectedDate!)
                                      ..selection = TextSelection.fromPosition(
                                          TextPosition(
                                              offset:
                                                  endDateController.text.length,
                                              affinity: TextAffinity.upstream));
                                    print(
                                        "daaaaaaaaaaaaaaaaa${endDateController.text.runtimeType}");
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return "please enter  your endDate";

                                    // else if(!value .contains("@") ||!value .contains(".") ){
                                    //   return " please enter valide starttime ";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: TextFormField(
                                    controller: startTimeController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      suffixIcon: Icon(Icons.event_note),
                                      labelText: 'startTime',
                                    ),
                                    onTap: () async {
                                      var time = await showTimePicker(
                                        builder: (context, child) {
                                          return Theme(
                                            data: ThemeData.light().copyWith(
                                              colorScheme: ColorScheme.dark(
                                                primary:
                                                    const Color(0xffE5E0A1),
                                                onPrimary: Colors.black,
                                                surface: Colors.white,
                                                onSurface: Colors.black,
                                              ),
                                              dialogBackgroundColor:
                                                  Colors.white,
                                            ),
                                            child: child!,
                                          );
                                        },
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        //timeController.text = time.format(context) from here
                                      ); //end of showTimePicker
                                      startTimeController.text =
                                          time!.format(context); // to h{
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return "please enter  your starttime";

                                        // else if(!value .contains("@") ||!value .contains(".") ){
                                        //   return " please enter valide starttime ";
                                      }
                                      return null;
                                    },
                                  ),
                                )),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                  child: TextFormField(
                                      controller: endTimeController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        errorStyle:
                                            TextStyle(color: Colors.redAccent),
                                        suffixIcon: Icon(Icons.event_note),
                                        labelText: 'endTime',
                                      ),
                                      onTap: () async {
                                        var time = await showTimePicker(
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                colorScheme: ColorScheme.dark(
                                                  primary:
                                                      const Color(0xffE5E0A1),
                                                  onPrimary: Colors.black,
                                                  surface: Colors.white,
                                                  onSurface: Colors.black,
                                                ),
                                                dialogBackgroundColor:
                                                    Colors.white,
                                              ),
                                              child: child!,
                                            );
                                          },
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          //timeController.text = time.format(context) from here
                                        ); //end of showTimePicker
                                        endTimeController.text =
                                            time!.format(context); // to h
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty || value == null) {
                                          return "please enter  your endtime";
                                          return null;
                                        }
                                      })),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),


                      Container(
                        margin: EdgeInsets.only(
                            top: 15, left: 20, right: 20, bottom: 10),
                        height: 62,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(160),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.3),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(0, 0.50))
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF005373),
                            padding: EdgeInsets.all(20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () async {
                            if (mainNameController.text.isEmpty ||
                                startDateController.text.isEmpty ||
                                endDateController.text == null ||
                                startTimeController.text == null ||
                                endTimeController.text == null) {
                              _submit();
                              print("empty");
                            } else {
                              print("project_id ${idpro}");
                              NotificationHelper.flutterLocalNotificationsPlugin
                                  .show(
                                      0,
                                      "Add New Task",
                                      "${mainNameController.text}",
                                      notificationDetails,
                                      payload: "");
                              if (type == "admin") {
                                var response = await ref
                                    .read(NewMainTaskAdminProvider)
                                    .AddNewMainAdminTask(
                                        mainNameController.text,
                                        subjectController.text,
                                        noteController.text,
                                        startDateController.text,
                                        endDateController.text,
                                        startTimeController.text,
                                        endTimeController.text,
                                        "main",
                                        idpro,
                                        22);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => HomeScreen()));
                                print("${response.status}ressssss");
                                if (response?.status == true) {
                                  mainNameController.clear();
                                  startDateController.clear();
                                  endDateController.clear();
                                  startTimeController.clear();
                                  endTimeController.clear();
                                  _formKey.currentState!.reset();
                                }
                                print(
                                    "${response?.status} -${idpro}statusssss");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Bottomnavigation()));
                              } else {
                                var response = await ref
                                    .read(NewMainTaskProvider)
                                    .AddNewMainTask(
                                        mainNameController.text,
                                        subjectController.text,
                                        noteController.text,
                                        startDateController.text,
                                        endDateController.text,
                                        startTimeController.text,
                                        endTimeController.text,
                                        "main",
                                        idpro);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => HomeScreen()));
                                print("${response}ressssss");
                                if (response?.status == true) {
                                  mainNameController.clear();
                                  startDateController.clear();
                                  endDateController.clear();
                                  startTimeController.clear();
                                  endTimeController.clear();
                                  _formKey.currentState!.reset();
                                }
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Text(
                                //         "${response?.status == true}"),
                                //     duration: const Duration(seconds: 4),
                                //     backgroundColor: (response?.status == true)
                                //         ? Colors.green
                                //         : Colors.red,
                                //   ),
                                // );
                                print(
                                    "${response?.status} -${idpro}statusssss");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Bottomnavigation()));
                              }
                            }
                          },
                          child: TextFieldTitleWidget(
                            title: "Add Task",
                            size: 16.sp,
                            colors: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future opendialog(WidgetRef ref) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Select Project"),
            content: Container(
              width: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 2, right: 8),
                child: ref.read(proProvider).when(
                    data: (dataa) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: dataa.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          List<String> emptyy = [];

                          List<String> pro_list_name = [];

                          String projectname = dataa.data[index].name ?? "";
                          pro_list_name.add(projectname);
                          String? pro_name = "";
                          List<Datum> projectmodel = dataa.data
                              .where((element) => element.name == projectname)
                              .toList();
                           idpro = projectmodel[0].id??0;

                          return SizedBox(
                            width: 200,
                            child: Row(
                              children: [
                                Radio(
                                  value: projectname,
                                  groupValue: proj,
                                  activeColor: Colors.black,
                                  onChanged: (val) {
                                    setState(() {
                                      proj = val;
                                      print(proj);
                                    });
                                  },
                                ),
                                Text(projectname),
                              ],
                            ),
                            // child: DropdownButtonFormField<String>(
                            //     decoration: InputDecoration(
                            //       enabledBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //             width: 0,
                            //             color: Colors.grey,
                            //           ),
                            //           borderRadius:
                            //               BorderRadius.circular(10)),
                            //       focusedBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //             width: 2,
                            //             color: Color(0xFF005373),
                            //           ),
                            //           borderRadius:
                            //               BorderRadius.circular(10)),
                            //       errorBorder: OutlineInputBorder(
                            //           borderSide: BorderSide(
                            //             width: 2,
                            //             color: Color(0xFF005373),
                            //           ),
                            //           borderRadius:
                            //               BorderRadius.circular(10)),
                            //     ),
                            //     value: dataa.data[index].name ?? "",
                            //     items: pro_list_name.map((item) => DropdownMenuItem(
                            //             value: item,
                            //             child: Text(
                            //               item.toString(),
                            //               style: TextStyle(
                            //                   fontWeight: FontWeight.bold),
                            //             )))
                            //         .toList(),
                            //     onChanged: (item) {
                            //       setState(() {
                            //         pro_name = item;
                            //         print("itemmm$pro_name");
                            //       });
                            //     }),
                          );
                        }),
                    error: (err, _) => Text(""),
                    loading: () => Center(child: CircularProgressIndicator())),
              ),
            ),
            actions: [TextButton(onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            }, child: Text("Submit"))],
          ));

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );
    builder:
    (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Colors.deepPurple,
            onPrimary: Colors.white,
            surface: Colors.blueGrey,
            onSurface: Colors.yellow,
          ),
          dialogBackgroundColor: Colors.blue[500],
        ),
        child: child,
      );
    };
    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      startDateController.text = DateFormat.yMd().format(_selectedDate!);

      startDateController.selection = TextSelection.fromPosition(TextPosition(
          offset: startDateController.text.length,
          affinity: TextAffinity.upstream));
    }
    // print(newSelectedDate);
  }
}

class MultiSelect extends StatefulWidget {
  final List<String> items;

  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: AlertDialog(

        title: const Text('Select Employee'),
        content: SingleChildScrollView(
          child: ListBody(
            children: widget.items
                .map((item) => CheckboxListTile(
                      value: _selectedItems.contains(item),
                      title: Text(item),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (isChecked) => _itemChange(item, isChecked!),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _cancel,
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
