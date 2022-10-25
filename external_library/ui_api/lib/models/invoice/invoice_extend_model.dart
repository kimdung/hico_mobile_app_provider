import 'package:get/utils.dart';
import 'package:hico/data/app_data_global.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:ui_api/models/home/services_model.dart';
import 'package:ui_api/models/invoice/cancel_reason_model.dart';
import 'package:ui_api/models/invoice/sub_invoice_model.dart';

import 'invoice_status.dart';
part 'invoice_extend_model.g.dart';

@JsonSerializable()
class InvoiceExtendModel {

  @JsonKey(name: 'working_form', defaultValue: 0)
  int? workingForm;
  @JsonKey(name: 'customer_name', defaultValue: '')
  String? customerName;
  ServiceModel? service;
  int? minutes;
  @JsonKey(name: 'working_date', defaultValue: '')
  String? workingDate;
  @JsonKey(name: 'tmp_total', defaultValue: 0)
  int? tmpTotal;
  int? total;
  @JsonKey(name: 'invoice_status', defaultValue: 0)
  int? invoiceStatus;

  InvoiceExtendModel(
      {
      this.workingForm,
      this.customerName,
      this.service,
      this.minutes,
      this.workingDate,
      this.tmpTotal,
      this.total,
      this.invoiceStatus,
      });
  
  factory InvoiceExtendModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceExtendModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceExtendModelToJson(this);
}
