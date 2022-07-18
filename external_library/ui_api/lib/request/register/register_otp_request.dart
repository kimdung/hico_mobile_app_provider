import 'package:json_annotation/json_annotation.dart';

part 'register_otp_request.g.dart';

@JsonSerializable()
class RegisterOtpRequest {
  final String email;
  final String code;@JsonKey(name: 'device_identifier', defaultValue: '')
  final String? deviceIdentifier;

  RegisterOtpRequest(this.email, this.code,this.deviceIdentifier);

  factory RegisterOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterOtpRequestToJson(this);
}
