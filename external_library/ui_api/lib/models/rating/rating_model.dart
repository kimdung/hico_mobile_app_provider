import 'package:json_annotation/json_annotation.dart';
part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel {
  int? id;
  @JsonKey(name: 'invoice_code', defaultValue: '')
  String? invoiceCode;
  String? content;
  @JsonKey(name: 'number_star')
  int? numberStar;
  @JsonKey(name: 'created_at', defaultValue: '')
  String? createdAt;
  @JsonKey(name: 'customer_avatar', defaultValue: '')
  String? customerAvatar;
  @JsonKey(name: 'service_name', defaultValue: '')
  String? serviceName;

  RatingModel(
      {this.id,
      this.invoiceCode,
      this.content,
      this.numberStar,
      this.createdAt,
      this.customerAvatar,
      this.serviceName});

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);
}
