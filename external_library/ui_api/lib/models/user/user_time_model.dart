import 'package:json_annotation/json_annotation.dart';
part 'user_time_model.g.dart';

@JsonSerializable()
class UserTimeModel {
  String? date;
  List<UserTimeListModel>? list;

  UserTimeModel({this.date, this.list});

  factory UserTimeModel.fromJson(Map<String, dynamic> json) =>
      _$UserTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserTimeModelToJson(this);

  String getTime() {
    return (list ?? []).map((e) => e.getTime()).join(', ');
  }
}

@JsonSerializable()
class UserTimeListModel {
  int? id;
  String? date;
  @JsonKey(name: 'begin_time', defaultValue: '')
  String? beginTime;
  @JsonKey(name: 'end_time', defaultValue: '')
  String? endTime;
  @JsonKey(name: 'check_offline', defaultValue: 0)
  int? checkOffline;

  UserTimeListModel({
    this.id,
    this.date,
    this.beginTime,
    this.endTime,
    this.checkOffline,
  });

  factory UserTimeListModel.fromJson(Map<String, dynamic> json) =>
      _$UserTimeListModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserTimeListModelToJson(this);
  String getTime() {
    return '$beginTime-$endTime';
  }
}
