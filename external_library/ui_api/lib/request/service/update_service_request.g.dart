// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_service_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateServiceRequest _$UpdateServiceRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateServiceRequest(
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => UserServicesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      districtIds: (json['district_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      userTime: (json['user_time'] as List<dynamic>?)
          ?.map((e) => TimeSlotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      removeTimeIds: (json['remove_time_ids'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$UpdateServiceRequestToJson(
        UpdateServiceRequest instance) =>
    <String, dynamic>{
      'services': instance.services,
      'district_ids': instance.districtIds,
      'user_time': instance.userTime,
      'remove_time_ids': instance.removeTimeIds,
    };

TimeSlotModel _$TimeSlotModelFromJson(Map<String, dynamic> json) =>
    TimeSlotModel(
      date: json['date'] as String?,
      timeSlot: (json['time_slot'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      checkOffline: (json['check_offline'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$TimeSlotModelToJson(TimeSlotModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'check_offline': instance.checkOffline,
      'time_slot': instance.timeSlot,
    };
