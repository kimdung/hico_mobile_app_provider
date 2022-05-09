import 'package:json_annotation/json_annotation.dart';
part 'services_model.g.dart';

@JsonSerializable()
class ServiceModel {
  @JsonKey(name: 'category_name', defaultValue: '')
  String? categoryName;
  int? id;
  String? name;
  @JsonKey(name: 'display_image', defaultValue: '')
  String? displayImage;
  int? price;
  @JsonKey(name: 'is_medical')
  int? isMedical;
  @JsonKey(name: 'min_hours')
  int? minHours;
  @JsonKey(name: 'offline_price_min')
  int? offlinePriceMin;
  @JsonKey(name: 'hours')
  double? hours;

  ServiceModel(
      {this.categoryName,
      this.id,
      this.name,
      this.displayImage,
      this.price,
      this.isMedical,
      this.minHours,
      this.offlinePriceMin,
      this.hours});

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
