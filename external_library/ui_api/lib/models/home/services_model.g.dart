// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      categoryName: json['category_name'] as String? ?? '',
      id: json['id'] as int?,
      name: json['name'] as String?,
      displayImage: json['display_image'] as String? ?? '',
      price: json['price'] as int?,
      isMedical: json['is_medical'] as int?,
      minHours: json['min_hours'] as int?,
      offlinePriceMin: json['offline_price_min'] as int?,
      hours: json['hours'] as int?,
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'category_name': instance.categoryName,
      'id': instance.id,
      'name': instance.name,
      'display_image': instance.displayImage,
      'price': instance.price,
      'is_medical': instance.isMedical,
      'min_hours': instance.minHours,
      'offline_price_min': instance.offlinePriceMin,
      'hours': instance.hours,
    };
