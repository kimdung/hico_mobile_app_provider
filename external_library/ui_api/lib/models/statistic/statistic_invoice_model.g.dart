// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticInvoiceModel _$StatisticInvoiceModelFromJson(
        Map<String, dynamic> json) =>
    StatisticInvoiceModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      customerAvatar: json['customer_avatar'] as String? ?? '',
      total: (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StatisticInvoiceModelToJson(
        StatisticInvoiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'customer_avatar': instance.customerAvatar,
      'total': instance.total,
    };
