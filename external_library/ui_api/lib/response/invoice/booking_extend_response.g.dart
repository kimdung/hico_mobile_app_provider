// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_extend_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingExtendResponse _$BookingExtendResponseFromJson(
        Map<String, dynamic> json) =>
    BookingExtendResponse(
      data: json['data'] == null
          ? null
          : InvoiceExtendModel.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..base = json['base'] == null
          ? null
          : BaseVersion.fromJson(json['base'] as Map<String, dynamic>);

Map<String, dynamic> _$BookingExtendResponseToJson(
        BookingExtendResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'base': instance.base,
      'data': instance.data,
    };
