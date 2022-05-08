import 'package:json_annotation/json_annotation.dart';
import 'package:ui_api/models/user/login_model.dart';
import 'package:ui_api/models/user/user_info_model.dart';
import 'package:ui_api/response/base_response.dart';

part 'upload_response.g.dart';

@JsonSerializable()
class UploadResponse extends BaseResponse {
  @JsonKey(name: 'data')
  String? data;

  UploadResponse(this.data);

  factory UploadResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadResponseToJson(this);
}
