// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectinfoModel _$ProjectinfoModelFromJson(Map<String, dynamic> json) =>
    ProjectinfoModel(
      status: json['status'] as bool,
      errNum: json['errNum'] as String,
      msg: json['msg'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProjectinfoModelToJson(ProjectinfoModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errNum': instance.errNum,
      'msg': instance.msg,
      'data': instance.data,
    };
