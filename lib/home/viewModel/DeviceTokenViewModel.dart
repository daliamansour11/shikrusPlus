   import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanger/home/repo/DeviceTokenRepo.dart';

   class DeviceTokenNotifier extends ChangeNotifier{
     final Ref ref;
     DeviceTokenNotifier(this.ref);

     Future postDeviceToken(String device_token)async{
       var DeviceToken =await ref.read(device_tokenRepo).postDeviceToken(device_token);
       debugPrint("repooooooooooooooooooproviderrrrrrrrrrrrrrrrrrrrrrrr");
       return DeviceToken;
     }
   }

