// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceDetailResponse _$InvoiceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    InvoiceDetailResponse(
      data: json['data'] == null
          ? null
          : InvoiceModel.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..base = json['base'] == null
          ? null
          : BaseVersion.fromJson(json['base'] as Map<String, dynamic>);

Map<String, dynamic> _$InvoiceDetailResponseToJson(
        InvoiceDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'base': instance.base,
      'data': instance.data,
    };
