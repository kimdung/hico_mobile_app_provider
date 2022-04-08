import 'package:json_annotation/json_annotation.dart';
part 'statistic_model.g.dart';

@JsonSerializable()
class StatisticModel {
  double? total;
  double? paid;
  double? remain;
  @JsonKey(name: 'cancel_times')
  double? cancelTimes;

  StatisticModel({this.total, this.paid, this.remain, this.cancelTimes});

  factory StatisticModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticModelToJson(this);
}
