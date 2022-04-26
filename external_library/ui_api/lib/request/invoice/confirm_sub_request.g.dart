// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_sub_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmSubRequest _$ConfirmSubRequestFromJson(Map<String, dynamic> json) =>
    ConfirmSubRequest(
      invoiceId: json['invoice_id'] as int?,
      symptom: json['symptom'] as String?,
      testMethod: json['test_method'] as String?,
      diseaseName: json['disease_name'] as String?,
      treatments: json['treatments'] as String?,
      appointmentNextTime: json['appointment_next_time'] as String?,
      comment: json['comment'] as String?,
      summary: json['summary'] as String?,
    );

Map<String, dynamic> _$ConfirmSubRequestToJson(ConfirmSubRequest instance) =>
    <String, dynamic>{
      'invoice_id': instance.invoiceId,
      'symptom': instance.symptom,
      'test_method': instance.testMethod,
      'disease_name': instance.diseaseName,
      'treatments': instance.treatments,
      'appointment_next_time': instance.appointmentNextTime,
      'comment': instance.comment,
      'summary': instance.summary,
    };
