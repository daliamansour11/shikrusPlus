// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Projectmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Projectmodel _$ProjectmodelFromJson(Map<String, dynamic> json) => Projectmodel(
      status: json['status'] as bool,
      errNum: json['errNum'] as String,
      msg: json['msg'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectmodelToJson(Projectmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errNum': instance.errNum,
      'msg': instance.msg,
      'data': instance.data,
    };
