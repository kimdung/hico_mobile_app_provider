// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provinces_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvincesModel _$ProvincesModelFromJson(Map<String, dynamic> json) =>
    ProvincesModel(
      id: json['id'] as int?,
      zipCode: json['zip_code'] as String? ?? '',
      name: json['name'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$ProvincesModelToJson(ProvincesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'zip_code': instance.zipCode,
      'name': instance.name,
      'status': instance.status,
    };
