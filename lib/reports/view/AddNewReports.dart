
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../AddNewTask/provider/AddNewTaskProvider.dart';
import '../provider/ReportsProvider.dart';

class AddNewReportsScreen extends ConsumerWidget {

  File? image ;
  final _picker = ImagePicker();
  bool showSpinner = false ;
  int progect_id;
  AddNewReportsScreen({
    required this.progect_id
  });
  Future getImage()async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery , imageQuality: 80);

    if(pickedFile!= null ){
      image = File(pickedFile.path);
      // setState(() {
      //
      // });
    }else {
      print('no image selected');
    }
  }



  TextEditingController reportController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController imaggeController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  // FilePickerResult? result;






  @override
    Widget build(BuildContext context,WidgetRef ref) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF005373),
            title: Text("Add Report", style:
            TextStyle(fontSize: 25, color: Colors.white
            ),),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(30),
            //   )
            //),
            centerTitle: true,
          ),


          body: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Report",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                Container(

                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                  TextField(
                  controller: reportController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
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
                    ), // labelText: "Reason", //babel text
                      hintText: "Enter Report",
                    ),


                  )])),

                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Reason",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  SizedBox(height: 3,),
                  Container(

                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(10),
                      child: Column(
                          children: [
                            TextField(
                              controller: reasonController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
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
        ), // labelText: "Reason", //babel text
       hintText: "Enter Reason",
      ),

                            ),
                          ])),
                  SizedBox(
                    height: 5,
                  ),

                     Container(
                      margin: EdgeInsets.only(top: 3),
                      height: 130,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[100],
                      ),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 230.0),
                            child: Text(
                              "Attachments",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                                height: 150,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: image == null ? Center(
                                    child: InkWell(

                                        onTap: () {
                                              getImage();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(Icons.add),
                                            ))) :
                                Container(
                                    child:
                                       Image.file(File(image!.path).absolute,
                                        height: 100,
                                        width: 100,
                                        // InkWell(
                                        //   onTap: () async {
                                        //     imageFile();
                                        //   },
                                        //     ),
                                      ),
                                    )),

                          SizedBox(height: 5,),
                          Container(
                            margin: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 10),
                            height: 63,
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
                                print("pro_id$progect_id");
                                if (reportController.text.isEmpty ||
                                    reasonController.text.isEmpty ||
                                    reportController.text == null ||
                                    reasonController.text == null) {
                                     Dialog(child: Text("enter report data"));
                                  print("empty");
                                }
                                else {
                                  print("pro_id$progect_id");
                                  final response = await ref.read(
                                      NewReportProvider).AddNewReport(

                                      reportController.text,
                                      reasonController.text,
                                      image!,
                                    progect_id


                                  );
                                  if (response?.status == true) {
                                    reportController.clear();
                                    reasonController.clear();
                                    _formKey.currentState!.reset();
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("${response?.status == true
                                          ? "Done"
                                          : "failed"}"),
                                      duration: const Duration(seconds: 4),
                                      backgroundColor: (response?.status == true)
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  );
                                  //012809796921
                                  // Navigator.push(context,
                                  // MaterialPageRoute(builder: (context)=>Bottomnavigation()));
                                }
                              },
                              child: Text(
                                  "    Add Task    ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
              ),
            ),
          );
    }

// Container(
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.only(
//       topLeft: (Radius.circular(20)),
//       topRight: (Radius.circular(20))
//
//
//
//     )
//   ),
// )

}