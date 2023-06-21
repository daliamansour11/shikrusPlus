// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reportdetailresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDetailResponse _$ReportDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ReportDetailResponse(
      status: json['status'] as bool,
      errNum: json['errNum'] as String,
      msg: json['msg'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportDetailResponseToJson(
        ReportDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errNum': instance.errNum,
      'msg': instance.msg,
      'data': instance.data,
    };
