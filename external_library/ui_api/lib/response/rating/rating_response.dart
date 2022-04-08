import 'package:json_annotation/json_annotation.dart';
import 'package:ui_api/models/home/home_model.dart';
import 'package:ui_api/models/home/service_category_model.dart';
import 'package:ui_api/models/master_data/master_data_model.dart';
import 'package:ui_api/models/rating/rating_model.dart';
import 'package:ui_api/models/service_categories/data_service_categories_model.dart';
import 'package:ui_api/response/base_response.dart';

part 'rating_response.g.dart';

@JsonSerializable()
class RatingResponse extends BaseResponse {
  @JsonKey(name: 'data')
  RatingInfoModel? data;

  RatingResponse({this.data});

  factory RatingResponse.fromJson(Map<String, dynamic> json) =>
      _$RatingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RatingResponseToJson(this);
}

@JsonSerializable()
class RatingInfoModel {
  List<RatingModel>? rows;
  int? recordsTotal;
  int? total;
  int? totalFirst;
  int? totalSecond;
  int? totalThird;
  int? totalFourth;
  int? totalFifth;

  RatingInfoModel(
      {this.rows,
      this.recordsTotal,
      this.total,
      this.totalFirst,
      this.totalSecond,
      this.totalThird,
      this.totalFourth,
      this.totalFifth});
  factory RatingInfoModel.fromJson(Map<String, dynamic> json) =>
      _$RatingInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingInfoModelToJson(this);
}
