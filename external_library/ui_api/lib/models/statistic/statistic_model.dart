import 'package:json_annotation/json_annotation.dart';
part 'statistic_model.g.dart';

@JsonSerializable()
class StatisticModel {

  double? balance;
  @JsonKey(name: 'earned_total')
  double? earnedTotal;
  @JsonKey(name: 'invoice_complete')
  double? invoiceComplete;
  @JsonKey(name: 'invoice_cancel_by_customer')
  double? invoiceCancelByCustomer;
  double? paid;
  double? remain;
  @JsonKey(name: 'fined_amount')
  double? finedAmount;
  @JsonKey(name: 'cancel_times')
  double? cancelTimes;

  StatisticModel(
      {this.balance,
      this.earnedTotal,
      this.invoiceComplete,
      this.invoiceCancelByCustomer,
      this.paid,
      this.remain,
      this.finedAmount,
      this.cancelTimes});

  factory StatisticModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticModelToJson(this);
}
