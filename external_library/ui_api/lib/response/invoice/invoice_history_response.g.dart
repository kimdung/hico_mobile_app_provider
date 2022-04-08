// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceHistoryResponse _$InvoiceHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    InvoiceHistoryResponse(
      data: json['data'] == null
          ? null
          : InvoiceList.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..base = json['base'] == null
          ? null
          : BaseVersion.fromJson(json['base'] as Map<String, dynamic>);

Map<String, dynamic> _$InvoiceHistoryResponseToJson(
        InvoiceHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'base': instance.base,
      'data': instance.data,
    };

InvoiceList _$InvoiceListFromJson(Map<String, dynamic> json) => InvoiceList(
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => InvoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..base = json['base'] == null
          ? null
          : BaseVersion.fromJson(json['base'] as Map<String, dynamic>);

Map<String, dynamic> _$InvoiceListToJson(InvoiceList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'base': instance.base,
      'rows': instance.rows,
    };
