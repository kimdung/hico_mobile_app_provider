// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => RatingModel(
      id: json['id'] as int?,
      invoiceCode: json['invoice_code'] as String? ?? '',
      content: json['content'] as String?,
      numberStar: json['number_star'] as int?,
      createdAt: json['created_at'] as String? ?? '',
      customerAvatar: json['customer_avatar'] as String? ?? '',
      serviceName: json['service_name'] as String? ?? '',
    );

Map<String, dynamic> _$RatingModelToJson(RatingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_code': instance.invoiceCode,
      'content': instance.content,
      'number_star': instance.numberStar,
      'created_at': instance.createdAt,
      'customer_avatar': instance.customerAvatar,
      'service_name': instance.serviceName,
    };
