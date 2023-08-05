import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../clender/view/ClenderScreen.dart';
import '../../clender/view/SubTasksScreen.dart';
import '../../profile/profile.dart';
import '../provider/AddNewTaskProvider.dart';


class AddNewSubTask extends ConsumerStatefulWidget{
  int project_id;
  int main_task_id;
  AddNewSubTask({
    required this.project_id,
    required this.main_task_id,} );

  @override
  ConsumerState<AddNewSubTask> createState() => _AddNewSubTaskState();
}

class _AddNewSubTaskState extends ConsumerState<AddNewSubTask> {

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool showSpinner =false;
  var SelectedType ;
  var Choosedtype;
  var type;

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }
  DateTime? _selectedDate;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController   =  TextEditingController();
  TextEditingController startTimeController =  TextEditingController();
  TextEditingController endTimeController =  TextEditingController();
  TextEditingController mainNameController =  TextEditingController();
  TextEditingController subNameController =  TextEditingController();
  TextEditingController noteController =  TextEditingController();
  TextEditingController subjectController =  TextEditingController();


  @override
  void initState() {
    Future.delayed(
        Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            backgroundColor: Color(0xFF005373),
            title: Text(
              "AddSubTask",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: true,
            actions: [
              IconButton(onPressed: (){
              }, icon:Container(
                height: 180,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Profilescreen()));
                  },
                  child: ClipRRect(

                    borderRadius: BorderRadius.circular(50),
                    child: Image(image:AssetImage(
                        "assets/personn.jpg"),

                      width:50,height: 150 , fit: BoxFit.cover, ),
                  ),
                ),

              ),color: Colors.black,),
              SizedBox(width: 20,height: 10,)]),

        body: Container(

          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,

          ),

          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.width* 0.02,),

                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 12,bottom: 2),
                    child: Text("Name"
                      ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin:EdgeInsets.symmetric(horizontal: 5) ,

                    child: TextFormField(
                      controller: mainNameController,
                      validator:(value){
                        if(value == null|| value.isEmpty){
                          return "please enter name";
                        }
                        else if(value .length < 6){
                          return "Too short title,choosea title with 6 character or more characters";
                        }
                        return null;

                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        enabledBorder:OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),

                          borderRadius: BorderRadius.all(Radius.circular(10)
                          ),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF005373),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)
                          ),
                        ),
                        // labelText: "Title", //babel text
                        hintText: " title ", //hint text
                        prefixIcon: Icon(Icons.title), //prefix iocn
                        hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), //hint text style
                        //  labelStyle: TextStyle(fontSize: 13, color: Colors.white), //label style
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 20,top: 2,bottom: 1),
                    child: Text(
                      "Subject",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 23),
                      // ),
                    ),
                  ),
                  Container(

                    alignment: Alignment.center,
                    margin:EdgeInsets.symmetric(horizontal: 5) ,

                    child: TextFormField(
                      controller: subjectController,
                      validator:(value){
                        if(value == null|| value.isEmpty){
                          return "please enter your subject";
                        }
                        else if(value .length < 4){
                          return "Too short title,choosea title with 6 character or more characters";
                        }
                        return null;

                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        enabledBorder:OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),

                          borderRadius: BorderRadius.all(Radius.circular(10)
                          ),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF005373),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)
                          ),
                        ),
                        // labelText: "Title", //babel text
                        hintText: " subject ", //hint text
                        prefixIcon: Icon(Icons.title), //prefix iocn
                        hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), //hint text style
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 12,top: 2,bottom: 1),
                    child: Text(
                      "notes",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 23),
                      // ),
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
                              color: Colors.blue,
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


                  SizedBox(height: size.width* 0.02,),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 12,bottom: 2),
                    child: Text("Date" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),
                    ),
                  ),
                  Container(

                    alignment: Alignment.center,
                    margin:EdgeInsets.symmetric(horizontal: 5) ,

                    child:Row(
                      children: [
                        Expanded(
                          flex:2,
                          child: TextFormField(
                            controller: startDateController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                              enabledBorder:OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1,

                                ),

                                borderRadius: BorderRadius.all(Radius.circular(20)
                                ),

                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2,

                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20)

                                ),
                              ),
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'startDate',
                            ),
                            onTap: ()async {
                              DateTime? newSelectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2040),

                                  builder: ( context,  child) {
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
                                      child: child!,);
                                  }
                              );
                              if (newSelectedDate != null) {
                                _selectedDate = newSelectedDate;
                                startDateController

                                  ..text = DateFormat("yyyy-MM-dd").format(_selectedDate!)
                                  ..selection = TextSelection.fromPosition(TextPosition(
                                      offset: startDateController.text.length,
                                      affinity: TextAffinity.upstream));
                              }
                            },
                            validator:(value){
                              if (value!.isEmpty  ||value ==null)
                              {
                                return "please enter  your startDate";

                                // else if(!value .contains("@") ||!value .contains(".") ){
                                //   return " please enter valide starttime ";

                              }
                              return null;

                            },
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: endDateController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                              enabledBorder:OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1,

                                ),

                                borderRadius: BorderRadius.all(Radius.circular(20)
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20)

                                ),
                              ),
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),

                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'endDate',
                            ),
                            onTap: ()async {
                              DateTime? newSelectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2040),

                                  builder: ( context,  child) {
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
                                      child: child!,
                                    );
                                  });
                              if (newSelectedDate != null) {
                                _selectedDate = newSelectedDate;
                                endDateController
                                  ..text = DateFormat("yyyy-MM-dd").format(_selectedDate!)
                                  ..selection = TextSelection.fromPosition(TextPosition(
                                      offset: endDateController.text.length,
                                      affinity: TextAffinity.upstream));
                                print("daaaaaaaaaaaaaaaaa${endDateController.text.runtimeType}");

                              }
                            },
                            validator:(value){
                              if (value!.isEmpty  ||value ==null)
                              {
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


                  SizedBox(height: size.width* 0.02,),
                  Container(
                    alignment: Alignment.center,
                    margin:EdgeInsets.symmetric(horizontal: 5) ,

                    child:Row(

                      children: [

                        Expanded(
                            flex: 2,
                            child: Container(
                              child:   TextFormField(
                                controller:startTimeController ,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                  enabledBorder:OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),

                                    borderRadius: BorderRadius.all(Radius.circular(20)
                                    ),

                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 2,

                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20)

                                    ),
                                  ),
                                  hintStyle: TextStyle(color: Colors.black45),
                                  errorStyle: TextStyle(color: Colors.redAccent),

                                  suffixIcon: Icon(Icons.event_note),
                                  labelText: 'startTime',
                                ),
                                onTap: ()async {
                                  var time = await showTimePicker(
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.dark(
                                            primary: const Color(0xffE5E0A1),
                                            onPrimary: Colors.black,
                                            surface: Colors.white,
                                            onSurface: Colors.black,
                                          ),
                                          dialogBackgroundColor: Colors.white,
                                        ),
                                        child: child!,
                                      );
                                    },
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    //timeController.text = time.format(context) from here
                                  ); //end of showTimePicker
                                  startTimeController.text = time!.format(context); // to h{

                                },
                                validator:(value){
                                  if (value!.isEmpty  ||value == null)
                                  {
                                    return "please enter  your starttime";

                                    // else if(!value .contains("@") ||!value .contains(".") ){
                                    //   return " please enter valide starttime ";

                                  }
                                  return null;

                                },

                              ),

                            )
                        ),
                        SizedBox(width: size.width* 0.03,),
                        Expanded(
                          flex: 2,
                          child: Container(
                              child: TextFormField(
                                  controller:endTimeController ,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                    enabledBorder:OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,

                                      ),

                                      borderRadius: BorderRadius.all(Radius.circular(20)
                                      ),

                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,

                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20)

                                      ),
                                    ),
                                    hintStyle: TextStyle(color: Colors.black45),
                                    errorStyle: TextStyle(color: Colors.redAccent),

                                    suffixIcon: Icon(Icons.event_note),
                                    labelText: 'endTime',
                                  ),
                                  onTap: () async {
                                    var time = await showTimePicker(
                                      builder: (context, child) {
                                        return Theme(
                                          data: ThemeData.light().copyWith(
                                            colorScheme: ColorScheme.dark(
                                              primary: const Color(0xffE5E0A1),
                                              onPrimary: Colors.black,
                                              surface: Colors.white,
                                              onSurface: Colors.black,
                                            ),
                                            dialogBackgroundColor: Colors.white,
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
                                  validator:(value){
                                    if (value!.isEmpty ||value ==null) {
                                      return "please enter  your endtime";
                                      return null;

                                    }}
                              )
                          ),
                        )
                      ],),
                  ),

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

                        if( mainNameController.text.isEmpty ||
                            startDateController .text .isEmpty ||
                            endDateController.text == null||startTimeController.text == null  ||endTimeController.text == null) {
                          _submit();
                          print("empty");
                        }
                        else{

                          print(widget.project_id);

                          var response=  await  ref.read(NewSubTaskProvider).AddNewSubTask(
                              mainNameController.text,
                              subjectController.text,noteController.text,
                              startDateController.text,
                              endDateController.text,
                              startTimeController.text,
                              endTimeController.text,
                              "sub",
                            widget.project_id,
                            widget.main_task_id,
                          );
                          if (response?.status == true) {
                             mainNameController.clear();
                            startDateController.clear();
                            endDateController.clear();
                            startTimeController.clear();
                            endTimeController.clear();
                            _formKey.currentState!.reset();
                          }
                          // final userTask = ref.read(MainTaskProvider).EmployeeMainTask();
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text("${response?.status== true ? "Done":"failed"}"),
                          //     duration: const Duration(seconds: 4),
                          //     backgroundColor: (response?.status == true)
                          //         ? Colors.green
                          //         : Colors.red,
                          //   ),
                          // );
                          //012809796921
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>Calendarpage()));
                        }
                      },

                      child: Text(
                          "    Add Task    ",
                          style: TextStyle(color: Colors.white, fontSize: 18)
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),

        )
    );

  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );
    builder: (BuildContext context, Widget child) {
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
      startDateController.text =DateFormat.yMd().format(_selectedDate!);

      startDateController.selection = TextSelection.fromPosition(TextPosition(
          offset: startDateController.text.length,
          affinity: TextAffinity.upstream));
    }
    // print(newSelectedDate);
  }
}



