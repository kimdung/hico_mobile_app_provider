import 'package:json_annotation/json_annotation.dart';
import 'package:ui_api/models/user/user_services_model.dart';

part 'update_service_request.g.dart';

@JsonSerializable()
class UpdateServiceRequest {
  List<UserServicesModel>? services;
  @JsonKey(name: 'district_ids')
  List<int>? districtIds;
  @JsonKey(name: 'user_time')
  List<TimeSlotModel>? userTime;
  @JsonKey(name: 'remove_time_ids')
  List<int>? removeTimeIds;

  UpdateServiceRequest({
    this.services,
    this.districtIds,
    this.userTime,
    this.removeTimeIds,
  });

  factory UpdateServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateServiceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateServiceRequestToJson(this);
}

@JsonSerializable()
class TimeSlotModel {
  String? date;
  @JsonKey(name: 'check_offline')
  List<int>? checkOffline;
  @JsonKey(name: 'time_slot')
  List<String>? timeSlot;

  TimeSlotModel({
    this.date,
    this.timeSlot,
    this.checkOffline,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotModelToJson(this);
}
