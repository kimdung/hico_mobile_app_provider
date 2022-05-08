// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_certificate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadCertificateResponse _$UploadCertificateResponseFromJson(
        Map<String, dynamic> json) =>
    UploadCertificateResponse(
      json['data'] == null
          ? null
          : DocumentsCertificateModel.fromJson(
              json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..base = json['base'] == null
          ? null
          : BaseVersion.fromJson(json['base'] as Map<String, dynamic>);

Map<String, dynamic> _$UploadCertificateResponseToJson(
        UploadCertificateResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'base': instance.base,
      'data': instance.data,
    };
