// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users_model _$Users_modelFromJson(Map<String, dynamic> json) => Users_model(
      json['name'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['password'] as String?,
      json['uId'] as String?,
      json['isEmailVerfied'] as bool?,
      json['image'] as String?,
      json['status'] as String?,
      json['UserGroups'] as List<dynamic>?,
    );

Map<String, dynamic> _$Users_modelToJson(Users_model instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'uId': instance.uId,
      'isEmailVerfied': instance.isEmailVerfied,
      'image': instance.image,
      'status': instance.status,
      'UserGroups': instance.UserGroups,
    };
