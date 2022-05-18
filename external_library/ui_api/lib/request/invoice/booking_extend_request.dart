import 'package:json_annotation/json_annotation.dart';
import 'package:ui_api/models/home/services_model.dart';
import 'package:ui_api/models/supplier/supplier_info_model.dart';
import 'package:ui_api/request/supplier/supplier_request.dart';

part 'booking_extend_request.g.dart';

@JsonSerializable()
class BookingExtendRequest {
  @JsonKey(name: 'invoice_id')
  int? invoiceId;
  @JsonKey(name: 'sub_id')
  int? subId;
  int? status;


  BookingExtendRequest({
    this.invoiceId,
    this.subId,
    this.status,
  });

  factory BookingExtendRequest.fromJson(Map<String, dynamic> json) =>
      _$BookingExtendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BookingExtendRequestToJson(this);
}
