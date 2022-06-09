import 'package:json_annotation/json_annotation.dart';
part 'statistic_invoice_model.g.dart';

@JsonSerializable()
class StatisticInvoiceModel {
  int? id;
  String? code;
  @JsonKey(name: 'customer_avatar', defaultValue: '')
  String? customerAvatar;
  double? total;

  StatisticInvoiceModel({this.id, this.code, this.customerAvatar, this.total});

  factory StatisticInvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticInvoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticInvoiceModelToJson(this);
}
