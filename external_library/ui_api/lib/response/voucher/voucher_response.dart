import 'package:json_annotation/json_annotation.dart';
import 'package:ui_api/models/voucher/list_voucher_model.dart';
import 'package:ui_api/response/base_response.dart';

part 'voucher_response.g.dart';

@JsonSerializable()
class VoucherResponse extends BaseResponse {
  @JsonKey(name: 'data')
  ListVoucherModel? data;

  VoucherResponse({this.data});

  factory VoucherResponse.fromJson(Map<String, dynamic> json) =>
      _$VoucherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherResponseToJson(this);
}
