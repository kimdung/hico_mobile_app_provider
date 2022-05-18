// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_extend_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingExtendRequest _$BookingExtendRequestFromJson(
        Map<String, dynamic> json) =>
    BookingExtendRequest(
      invoiceId: json['invoice_id'] as int?,
      subId: json['sub_id'] as int?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$BookingExtendRequestToJson(
        BookingExtendRequest instance) =>
    <String, dynamic>{
      'invoice_id': instance.invoiceId,
      'sub_id': instance.subId,
      'status': instance.status,
    };
