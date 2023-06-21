
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../apiService/DioClient.dart';

class DeviceTokenRepo {
  final DioClient dioClient;

  // final Webservice webservice;

  DeviceTokenRepo(this.dioClient);

  // Future<Usermodel> loginUser(Users_model user) async {
  //
  //     var response =  await webservice.checkUser(user);
  //      return response;
  // }

 postDeviceToken(String device_token) async {
    var response0 =  await dioClient.PostDeviceToken(device_token);
    print("${response0}");
    return response0;
  }

// Future<Projectmodel> getprojects() async {
//
//   var response =  await webservice.getAllProjects("Bearer Ws0nyRlKh7RJpPxXrhBojKEobkWjDJq4W2ORrUVG");
//   debugPrint("${response}");
//
//   return response;
// }
}
final device_tokenRepo=Provider<DeviceTokenRepo>((ref)=>DeviceTokenRepo(DioClient()));

