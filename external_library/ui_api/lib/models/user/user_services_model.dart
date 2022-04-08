import 'package:json_annotation/json_annotation.dart';
part 'user_services_model.g.dart';

@JsonSerializable()
class UserServicesCategoryModel {
  @JsonKey(name: 'service_category_id', defaultValue: 0)
  int? serviceCategoryId;
  String? name;
  List<UserServicesModel>? list;

  UserServicesCategoryModel({this.serviceCategoryId, this.name, this.list});

  factory UserServicesCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$UserServicesCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserServicesCategoryModelToJson(this);
}

@JsonSerializable()
class UserServicesModel {
  int? id;
  String? name;
  @JsonKey(name: 'is_online', defaultValue: 0)
  int? isOnline;
  @JsonKey(name: 'is_offline', defaultValue: 0)
  int? isOffline;

  UserServicesModel({this.id, this.name, this.isOnline, this.isOffline});

  factory UserServicesModel.fromJson(Map<String, dynamic> json) =>
      _$UserServicesModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserServicesModelToJson(this);
}
