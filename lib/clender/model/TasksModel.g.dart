// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TasksModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksModel _$TasksModelFromJson(Map<String, dynamic> json) => TasksModel(
      status: json['status'] as bool?,
      errNum: json['errNum'] as String?,
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TasksModelToJson(TasksModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errNum': instance.errNum,
      'msg': instance.msg,
      'data': instance.data,
    };
