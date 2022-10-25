// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserServicesCategoryModel _$UserServicesCategoryModelFromJson(
        Map<String, dynamic> json) =>
    UserServicesCategoryModel(
      serviceCategoryId: json['service_category_id'] as int? ?? 0,
      name: json['name'] as String?,
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => UserServicesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      openChild: json['open_child'] as bool? ?? false,
    );

Map<String, dynamic> _$UserServicesCategoryModelToJson(
        UserServicesCategoryModel instance) =>
    <String, dynamic>{
      'service_category_id': instance.serviceCategoryId,
      'name': instance.name,
      'list': instance.list,
      'open_child': instance.openChild,
    };

UserServicesModel _$UserServicesModelFromJson(Map<String, dynamic> json) =>
    UserServicesModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      isOnline: json['is_online'] as int? ?? 0,
      isOffline: json['is_offline'] as int? ?? 0,
    );

Map<String, dynamic> _$UserServicesModelToJson(UserServicesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_online': instance.isOnline,
      'is_offline': instance.isOffline,
    };
