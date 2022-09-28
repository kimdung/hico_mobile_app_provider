import 'package:json_annotation/json_annotation.dart';
part 'sub_invoice_model.g.dart';

@JsonSerializable()
class SubInvoiceModel {
  int? minutes;
  double? price;
  @JsonKey(name: 'payment_status')
  int? paymentStatus;

  SubInvoiceModel({this.minutes, this.price, this.paymentStatus});

  factory SubInvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$SubInvoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubInvoiceModelToJson(this);
}
