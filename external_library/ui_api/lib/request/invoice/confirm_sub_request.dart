import 'package:json_annotation/json_annotation.dart';

part 'confirm_sub_request.g.dart';

@JsonSerializable()
class ConfirmSubRequest {
  @JsonKey(name: 'invoice_id')
  int? invoiceId;
  String? symptom;
  @JsonKey(name: 'test_method')
  String? testMethod;
  @JsonKey(name: 'disease_name')
  String? diseaseName;
  String? treatments;
  @JsonKey(name: 'appointment_next_time')
  String? appointmentNextTime;
  String? comment;
  String? summary;

  ConfirmSubRequest({
    this.invoiceId,
    this.symptom,
    this.testMethod,
    this.diseaseName,
    this.treatments,
    this.appointmentNextTime,
    this.comment,
    this.summary,
  });

  factory ConfirmSubRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmSubRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmSubRequestToJson(this);

}
