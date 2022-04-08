import 'package:json_annotation/json_annotation.dart';
part 'workplaces_model.g.dart';

@JsonSerializable()
class WorkplacesModel {
  @JsonKey(name: 'province_id', defaultValue: 0)
  int? provinceId;
  String? name;
  List<DistrictsWorkplacesModel>? districts;

  WorkplacesModel({this.provinceId, this.name, this.districts});

  factory WorkplacesModel.fromJson(Map<String, dynamic> json) =>
      _$WorkplacesModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkplacesModelToJson(this);
}

@JsonSerializable()
class DistrictsWorkplacesModel {
  int? id;
  String? name;

  DistrictsWorkplacesModel({this.id, this.name});

  factory DistrictsWorkplacesModel.fromJson(Map<String, dynamic> json) =>
      _$DistrictsWorkplacesModelFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictsWorkplacesModelToJson(this);
}
