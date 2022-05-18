// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_extend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceExtendModel _$InvoiceExtendModelFromJson(Map<String, dynamic> json) =>
    InvoiceExtendModel(
      workingForm: json['working_form'] as int? ?? 0,
      customerName: json['customer_name'] as String? ?? '',
      service: json['service'] == null
          ? null
          : ServiceModel.fromJson(json['service'] as Map<String, dynamic>),
      minutes: json['minutes'] as int?,
      workingDate: json['working_date'] as String? ?? '',
      tmpTotal: json['tmp_total'] as int? ?? 0,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$InvoiceExtendModelToJson(InvoiceExtendModel instance) =>
    <String, dynamic>{
      'working_form': instance.workingForm,
      'customer_name': instance.customerName,
      'service': instance.service,
      'minutes': instance.minutes,
      'working_date': instance.workingDate,
      'tmp_total': instance.tmpTotal,
      'total': instance.total,
    };
