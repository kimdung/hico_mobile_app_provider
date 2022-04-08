// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingResponse _$RatingResponseFromJson(Map<String, dynamic> json) =>
    RatingResponse(
      data: json['data'] == null
          ? null
          : RatingInfoModel.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..base = json['base'] == null
          ? null
          : BaseVersion.fromJson(json['base'] as Map<String, dynamic>);

Map<String, dynamic> _$RatingResponseToJson(RatingResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'base': instance.base,
      'data': instance.data,
    };

RatingInfoModel _$RatingInfoModelFromJson(Map<String, dynamic> json) =>
    RatingInfoModel(
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => RatingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recordsTotal: json['recordsTotal'] as int?,
      total: json['total'] as int?,
      totalFirst: json['totalFirst'] as int?,
      totalSecond: json['totalSecond'] as int?,
      totalThird: json['totalThird'] as int?,
      totalFourth: json['totalFourth'] as int?,
      totalFifth: json['totalFifth'] as int?,
    );

Map<String, dynamic> _$RatingInfoModelToJson(RatingInfoModel instance) =>
    <String, dynamic>{
      'rows': instance.rows,
      'recordsTotal': instance.recordsTotal,
      'total': instance.total,
      'totalFirst': instance.totalFirst,
      'totalSecond': instance.totalSecond,
      'totalThird': instance.totalThird,
      'totalFourth': instance.totalFourth,
      'totalFifth': instance.totalFifth,
    };
