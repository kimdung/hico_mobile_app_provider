// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubInvoiceModel _$SubInvoiceModelFromJson(Map<String, dynamic> json) =>
    SubInvoiceModel(
      minutes: json['minutes'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      paymentStatus: json['payment_status'] as int?,
    );

Map<String, dynamic> _$SubInvoiceModelToJson(SubInvoiceModel instance) =>
    <String, dynamic>{
      'minutes': instance.minutes,
      'price': instance.price,
      'payment_status': instance.paymentStatus,
    };
