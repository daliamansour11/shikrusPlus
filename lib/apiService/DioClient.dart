import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as mime;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanger/apiService/DioClient.dart';
import 'package:taskmanger/apiService/DioClient.dart';
import 'package:taskmanger/apiService/DioClient.dart';
import 'package:taskmanger/apiService/DioClient.dart';
import 'package:taskmanger/core/Constants.dart';
import 'package:taskmanger/core/SharedPreferenceInfo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:taskmanger/home/model/Projectmodel.dart';
import 'package:taskmanger/home/model/statisticsmodel.dart';
import 'package:taskmanger/clender/model/TasksModel.dart';

import '../Admin_projects/model/Admin_ProjectModel.dart';
import '../Authentication/login/model/logoutmodel.dart';
import '../Notification/model/Notificationcountmodel.dart';
import '../Notification/model/Notifications.dart';
import '../chat/chats/model/UsersModel.dart';
import '../clender/Provider/SubTaskProvider.dart';
import '../clender/Repository/SubtTaskRepo.dart';
import '../clender/model/AllMainTaskModel.dart';
import '../home/model/statisticsadminmodel.dart';
import '../reports/model/reportsresponse.dart';
part'DioClient.g.dart';
@JsonSerializable()
class DioClient {
  final Dio _dio = Dio();
  final _baseUrl = 'https://management-system.webautobazaar.com/api/';


  Future LoggingIn(String email, String password) async {
    final loginData = FormData.fromMap({
      "email": email,
      "password": password,
    });
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      final String? token = shared.getString(
          '${SharedPreferencesInfo.userTokenKey}');
      print("shhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh    ${token}");
      var response = await _dio.post(
          _baseUrl + "app-login",
          data: loginData,
          options: Options(
            headers: {
              "Content-Type": CONTENT_TYPE,
              "lang": 'ar',
              'Authorization': 'Bearer $token'
            },
          )
      );
      print('logedin Info: ${response.statusCode}');
      print('logedin Info: ${response.data.toString()}');
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }
  //////project main task/////////////////////

  Future<TasksModel?> getEmployeeMainTasks(int project_id) async {
    TasksModel? tasksModel;
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      final String? token = shared.getString(
          '${SharedPreferencesInfo.userTokenKey}');
      print("shhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh    ${token}");
      Response userData = await _dio.get(
           'https://shapi.webautobazaar.com/api/employee/tasks/${project_id}',
          options: Options(
        headers: {
          "Content-Type": CONTENT_TYPE,
          "lang": 'ar',
          'Authorization': 'Bearer $token'
        },
      ));
      print('mainTask Info: ${userData.statusCode}');
      print('mainTask Info: ${userData.data}');
      tasksModel = TasksModel.fromJson(userData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return tasksModel;
  }

  ////all maintasks///
  Future<AllMainTaskModel?> getAllEmployeeMainTasks() async {
    AllMainTaskModel? allTasksModel;
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      final String? token = shared.getString(
          '${SharedPreferencesInfo.userTokenKey}');
      print("shhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh    ${token}");
      Response userData = await _dio.get(
           'https://management-system.webautobazaar.com/api/employee/main-tasks',
          options: Options(
        headers: {
          "Content-Type": CONTENT_TYPE,
          "lang": 'ar',
          'Authorization': 'Bearer $token'
        },
      ));
      print('allmainTask Info: ${userData.statusCode}');
      print('allmainTask Info: ${userData.data}');
      allTasksModel = AllMainTaskModel.fromJson(userData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return allTasksModel;
  }
  //logout//////////
  Future<Logoutresponse?> getlogout() async {
    Logoutresponse? logoutresponse;
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      final String? token = shared.getString(
          '${SharedPreferencesInfo.userTokenKey}');
      print("shhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh    ${token}");
      Response userData = await _dio.get(
          'https://management-system.webautobazaar.com/api/logout',
          options: Options(
            headers: {
              "Content-Type": CONTENT_TYPE,
              "lang": 'ar',
              'Authorization': 'Bearer $token'
            },
          ));
      print('allmainTask Info: ${userData.statusCode}');
      print('allmainTask Info: ${userData.data}');
      logoutresponse = Logoutresponse.fromJson(userData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return logoutresponse;
  }

  Future<TasksModel?> getEmployeeSubTasks( int main_task_id ) async {
    TasksModel? tasksModel;
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      final String? token = shared.getString(
          '${SharedPreferencesInfo.userTokenKey}');
      print("shhhhhh   ${token}");
      Response userData = await _dio.get(
           'https://management-system.webautobazaar.com/api/employee/sub-tasks/9/${main_task_id}'
          , options: Options(
        headers: {
          "Content-Type": CONTENT_TYPE,
          "lang": 'ar',
          'Authorization': 'Bearer $token'
        },
      ));
      print('subTask Info: ${userData.statusCode}');
      print('subTask Info: ${userData.data}');
      tasksModel = TasksModel.fromJson(userData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return tasksModel;
  }

  Future<GetStatisticsResponse> askstatistics() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final String? token = shared.getString(
        '${SharedPreferencesInfo.userTokenKey}');
    print("shhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh    ${token}");

    var response = await Dio().get(
        'https://management-system.webautobazaar.com/api/employee/statistics',
        //         options: Options(
        options: Options(headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
          'Accept': 'application/json',
          'lang': 'ar'
        },
        )
    );
    GetStatisticsResponse statisticsmodel = GetStatisticsResponse.fromJson(
        response.data);
    if (response.statusCode == 200) {
      debugPrint("${response}  sucessssssssssssssssssssssssssssss");
    }
    else {
      debugPrint("faildddddddddddddddddddddddddddddddddd");
    }
    print(response.data);


    return statisticsmodel;
  }
  Future<GetStatisticsAdminResponse> askstatisticsadmin() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final String? token = shared.getString(
        '${SharedPreferencesInfo.userTokenKey}');
    print("shhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh    ${token}");

    var response = await Dio().get(
        'https://management-system.webautobazaar.com/api/admin/projects-statistics',
        //         options: Options(
        options: Options(headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
          'Accept': 'application/json',
          'lang': 'ar'
        },
        )
    );
    GetStatisticsAdminResponse statisticsmodel = GetStatisticsAdminResponse.fromJson(
        response.data);
    if (response.statusCode == 200) {
      debugPrint("${response}  sucessssssssssssssssssssssssssssss");
    }
    else {
      debugPrint("faildddddddddddddddddddddddddddddddddd");
    }
    print(response.data);


    return statisticsmodel;
  }
  ////////////////////////update task Status/////////////////////\
  Future<NotificationCount> getnotificationscount() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final String? token = shared.getString(
        '${SharedPreferencesInfo.userTokenKey}');
    print("shhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh    ${token}");

    var response = await Dio().get(
        'https://shapi.webautobazaar.com/api/secretary/unread-count-notification',
        //         options: Options(
        options: Options(headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
          'Accept': 'application/json',
          'lang': 'ar'
        },
        )
    );
    NotificationCount notificationCountsmodel = NotificationCount.fromJson(
        response.data);

    if (response.statusCode == 200) {
      debugPrint("${response}  sucessssssssssssssssssssssssssssss");
    }
    else {
      debugPrint("faildddddddddddddddddddddddddddddddddd");
    }
    print(response.data);
    return notificationCountsmodel;
  }

  Future<Notifications> getnotifications() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final String? token = shared.getString(
        '${SharedPreferencesInfo.userTokenKey}');
    print("shhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh    ${token}");

    var response = await Dio().get(
        'https://shapi.webautobazaar.com/api/secretary/notifications',
        //         options: Options(
        options: Options(headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
          'Accept': 'application/json',
          'lang': 'ar'
        },)
    );
    Notifications notificationsmodel = Notifications.fromJson(response.data);
    if (response.statusCode == 200) {
      debugPrint("${response}  sucessssssssssssssssssssssssssssss");
    }
    else {
      debugPrint("faildddddddddddddddddddddddddddddddddd");
    }
    print(response.data);
    return notificationsmodel;
  }
  Future<ReportResponse> getReport() async {
    List<ReportResponse>reportlist = [];
    SharedPreferences shared = await SharedPreferences.getInstance();
    final String? token = shared.getString(
        '${SharedPreferencesInfo.userTokenKey}');
    print("shhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh    ${token}");
    var response = await Dio().get(
        'https://management-system.webautobazaar.com/api/employee/reports',
        //         options: Options(
        options: Options(headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
          'Accept': 'application/json',
          'lang': 'ar'
        },
        )
    );
    ReportResponse reportmodel = ReportResponse.fromJson(response.data);
    reportlist.add(reportmodel);
    if (response.statusCode == 200) {
      debugPrint("${reportmodel}  sucessssssssssssssssssssssssssssss");
    }
    else {
      debugPrint("faildddddddddddddddddddddddddddddddddd");
    }
    print(reportlist);


    return reportmodel;
  }

  upDateEmployeeTasksStatus(String status, int? id) async {
    final data = FormData.fromMap({
      "task_id": id,
      "status": status,
    });
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      final String? token = shared.getString(
          '${SharedPreferencesInfo.userTokenKey}');
      // print("shhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh    ${token}");
      Response userData = await _dio.post(
          "https://shapi.webautobazaar.com/api/employee/change-status",
          data: data,
          options: Options(
            headers: {
              "Content-Type": CONTENT_TYPE,
              "lang": 'ar',
              'Authorization': 'Bearer $token'
            },
          ));
      print('update Info: ${userData.statusCode}');
      print('update Info: ${userData.data}');
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }

  ///////post Task///////////////////////////////////
  Future  AddNewMainTask(String name, String subject, String note,
      String start_date, String end_date, String time_from, String time_to,
      String type,int project_id) async {
    final data = FormData.fromMap({
      "name": name,
      "subject": subject,
      'notes': note,
      "starting_date": start_date,
      'expected_expiry_date': end_date,
      'time_from': time_from,
      'time_to': time_to,
      'type': type,
      "project_id":project_id

    });
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      final String? token = shared.getString(
          '${SharedPreferencesInfo.userTokenKey}');
      var response = await _dio.post(
          _baseUrl + 'employee/task',
          data: data,
          options: Options(
            headers: {
              "Content-Type": ACCEPT,
              "lang": 'ar',
              'Authorization': 'Bearer $token'},));
      print('task Info: ${response.statusCode}');
      print('task Info: ${response.data.toString()}');
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');

      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }







  AddNewSubTask(String name, String subject, String note,
      String start_date, String end_date, String time_from, String time_to,
      String type,int project_id, int main_task_id) async {
    final data = FormData.fromMap({
      "name": name,
      "subject": subject,
      'notes': note,
      "starting_date": start_date,
      'expected_expiry_date': end_date,
      'time_from': time_from,
      'time_to': time_to,
      'type': type,
      "project_id":project_id,
      "main_task_id":main_task_id
    });
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      final String? token = shared.getString(
          '${SharedPreferencesInfo.userTokenKey}');
      var response = await _dio.post(
          _baseUrl + 'employee/task',
          data: data,
          options: Options(
            headers: {
              "Content-Type": ACCEPT,
              "lang": 'ar',
              'Authorization': 'Bearer $token'},));
      print('task Info: ${response.statusCode}');
      print('task Info: ${response.data.toString()}');
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }
  ////////////////////////////getAll Users////////////
  Future<UsersModel> getAllUsers() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final String? token = shared.getString(
        '${SharedPreferencesInfo.userTokenKey}');

    var response = await Dio().get(
        _baseUrl+"users",
        //         options: Options(
        options: Options(headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
          'Accept': 'application/json',
          'lang': 'ar'
        },
        )
    );
    UsersModel usersModel = UsersModel.fromJson(response.data);
    if (response.statusCode == 200) {
      debugPrint("${response}  sucessssssssssssssssssssssssssssss");
    }
    else {
      debugPrint("faildddddddddddddddddddddddddddddddddd");
    }
    print(response.data);
    return usersModel;
  }

  /////////////////////////////getProjects./////////////////////////////////////
  Future<Projectmodel> getAllProjects() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final String? token = shared.getString(
        '${SharedPreferencesInfo.userTokenKey}');

    var response = await Dio().get(
        'https://management-system.webautobazaar.com/api/employee/projects',
        //         options: Options(
        options: Options(headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
          'Accept': 'application/json',
          'lang': 'ar'
        },
        )
    );
    Projectmodel projectmodel = Projectmodel.fromJson(response.data);
    if (response.statusCode == 200) {
      debugPrint("${response}  sucessssssssssssssssssssssssssssss");
    }
    else {
      debugPrint("faildddddddddddddddddddddddddddddddddd");
    }
    print(response.data);
    return projectmodel;
  }
  ///////////////////////////getemployeeprojects////////////////////////////////
  Future<AdminProjectModel> getProjectEmployees(int project_id) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final String? token = shared.getString(
        '${SharedPreferencesInfo.userTokenKey}');

    var response = await Dio().get(
        'https://management-system.webautobazaar.com/api/admin/project-employees/${project_id}',
        //         options: Options(
        options: Options(headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
          'Accept': 'application/json',
          'lang': 'ar'
        },
        )
    );
    AdminProjectModel projectmodel = AdminProjectModel.fromJson(response.data);
    if (response.statusCode == 200) {
      debugPrint("${response}  sucessssssssssssssssssssssssssssss");
    }
    else {
      debugPrint("faildddddddddddddddddddddddddddddddddd");
    }
    print(response.data);
    return projectmodel;
  }



  ////////////////////////////upload DeviceToken//////////////

  Future  PostDeviceToken(String device_token, ) async {
    final data = FormData.fromMap({
      "fcm_token": device_token,
    });
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      final String? token = shared.getString(
          '${SharedPreferencesInfo.userTokenKey}');
      var response = await _dio.post(
          'https://shapi.webautobazaar.com/api/employee/device-toked',
          data: data,
          options: Options(
            headers: {
              "Content-Type": ACCEPT,
              "lang": 'ar',
              'Authorization': 'Bearer $token'},));
      print('token Info: ${response.statusCode}');
      print('token Info: ${response.data.toString()}');
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }



  //////////UploadReport////////////////////////////////

  Future<ReportResponse?> addNewReport(String report, String reason,
  File  file, int project_id) async {
    ReportResponse? response;
    final data = FormData.fromMap({
        "report": report,
        "reason": reason,
        'files': [
          await MultipartFile.fromFile(file.path, filename: ''),],
      });
      try {
        SharedPreferences shared = await SharedPreferences.getInstance();
        final String? token = shared.getString(
            '${SharedPreferencesInfo.userTokenKey}');
        var response = await _dio.post(
            'https://shapi.webautobazaar.com/api/employee/report/$project_id',
            data: data,
            onSendProgress: (int sent,int total){
            print("$sent,$total");
            },
            options: Options(
              headers: {
                "Content-Type": ACCEPT,
                "lang": 'ar',
                'Authorization': 'Bearer $token'},));
        print('report Info: ${response.statusCode}');
        print('report Info: ${response.data.toString()}');
      } on DioError catch (e) {
        if (e.response != null) {
          print('Dio error!');
          print('STATUSreport: ${e.response?.statusCode}');
          print('DATA: ${e.response?.data}');
          print('HEADERS: ${e.response?.headers}');
        } else {
          // Error due to setting up or sending the request
          print('Error sending request!');
          print(e.message);
        }
      }

    return response;}
  }
class MyParmaters {
  final int?  project_id;
  final int? main_task_id;

  MyParmaters({this.project_id, this.main_task_id});
}










   // UploadAttachment(multiformData) async {
   //   FilePickerResult? result = await FilePicker.platform.pickFiles(
   //     type: FileType.custom,
   //     allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'mp4', 'mkv'],
   //   );
   //   if (result != null) {
   //     PlatformFile file = result.files.first;
   //
   //     print(file.name);
   //     print(file.bytes);
   //     print(file.size);
   //     print(file.extension);
   //     print(file.path);
   //     var multipartFile = await MultipartFile.fromFile(file.path ?? '',
   //     );
   //     FormData formData = FormData.fromMap({
   //       "MediaFile": multipartFile, //define your json data here
   //     });
   //     UploadAttachment(formData); //call upload function passing multiform data
   //   }
   //   final response = await _dio.post(
   //     _baseUrl + "",
   //     data: multiformData,
   //     options: Options(
   //         contentType: 'multipart/form-data',
   //         headers: {},
   //         followRedirects: false,
   //         validateStatus: (status) {
   //           return status! <= 500;
   //         }),
   //   );
   //   print(response.statusCode);
   // }

// void _upload(List<XFile> files) async {
   //   for (var file in files) {
   //     String fname = filename;
   //     FormData data = FormData.fromMap({
   //       "file": await MultipartFile.fromFile(
   //         file.path,
   //         filename: fname,
   //       ),
   //     });
   //
   //     Dio dio = new Dio();
   //
   //     print('Image File Name: $fname');
   //     var response = await dio.put(url,
   //       data: data,
   //       options: Options(
   //         headers: {},
   //       ),
   //     );
   //
   //     print(response.statusCode);
   //     print(response.data);
   //   }
   // }


//
// Future uploadPdf() async{
//
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.any,
//       allowMultiple: false
//     );
//     if(result != null){
//      String _fileNmae = result.files.first.name;
//
//       PlatformFile ? pickefile=  result.files.first;
//     }
// }

