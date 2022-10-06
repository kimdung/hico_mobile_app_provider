import 'package:json_annotation/json_annotation.dart';
import 'package:ui_api/response/base_response.dart';

import '../../models/invoice/invoice_extend_model.dart';

part 'booking_extend_response.g.dart';

@JsonSerializable()
class BookingExtendResponse extends BaseResponse {
  @JsonKey(name: 'data')
  InvoiceExtendModel? data;

  BookingExtendResponse({this.data});

  factory BookingExtendResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingExtendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingExtendResponseToJson(this);
}
