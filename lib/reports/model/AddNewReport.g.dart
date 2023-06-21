// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddNewReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNewReport _$AddNewReportFromJson(Map<String, dynamic> json) => AddNewReport(
      report: json['report'] as String?,
      reason: json['reason'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$AddNewReportToJson(AddNewReport instance) =>
    <String, dynamic>{
      'report': instance.report,
      'reason': instance.reason,
      'image': instance.image,
    };
