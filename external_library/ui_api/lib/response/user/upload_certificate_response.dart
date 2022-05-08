import 'package:json_annotation/json_annotation.dart';
import 'package:ui_api/models/user/login_model.dart';
import 'package:ui_api/models/user/user_info_model.dart';
import 'package:ui_api/response/base_response.dart';

import '../../models/user/documents_certificate_model.dart';

part 'upload_certificate_response.g.dart';

@JsonSerializable()
class UploadCertificateResponse extends BaseResponse {
  @JsonKey(name: 'data')
  DocumentsCertificateModel? data;

  UploadCertificateResponse(this.data);

  factory UploadCertificateResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadCertificateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadCertificateResponseToJson(this);
}
