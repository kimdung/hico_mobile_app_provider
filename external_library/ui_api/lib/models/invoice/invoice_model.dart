import 'package:get/utils.dart';
import 'package:hico/data/app_data_global.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:ui_api/models/home/services_model.dart';
import 'package:ui_api/models/invoice/cancel_reason_model.dart';
import 'package:ui_api/models/invoice/sub_invoice_model.dart';

import 'invoice_status.dart';
part 'invoice_model.g.dart';

@JsonSerializable()
class InvoiceModel {
  int? id;
  String? code;
  @JsonKey(name: 'customer_id', defaultValue: 0)
  int? customerId;
  @JsonKey(name: 'customer_avatar', defaultValue: '')
  String? customerAvatar;
  @JsonKey(name: 'customer_name', defaultValue: '')
  String? customerName;
  @JsonKey(name: 'customer_address', defaultValue: '')
  String? customerAddress;
  @JsonKey(name: 'customer_tube_station_nearest', defaultValue: '')
  String? customerTubeStationNearest;
  @JsonKey(name: 'service_id', defaultValue: 0)
  int? serviceId;
  @JsonKey(name: 'service_name', defaultValue: '')
  String? serviceName;
  @JsonKey(name: 'working_form', defaultValue: 0)
  int? workingForm;
  int? status;
  ServiceModel? service;
  @JsonKey(name: 'working_date', defaultValue: '')
  String? workingDate;
  @JsonKey(name: 'working_time', defaultValue: '')
  String? workingTime;
  @JsonKey(name: 'extra_time', defaultValue: '')
  String? extraTime;
  double? hours;
  @JsonKey(name: 'payment_type', defaultValue: 0)
  int? paymentType;
  @JsonKey(name: 'traveling_costs', defaultValue: 0)
  int? travelingCosts;
  @JsonKey(name: 'tmp_total', defaultValue: 0)
  int? tmpTotal;
  int? total;
  CancelReasonModel? cancel;
  @JsonKey(name: 'sub_invoice')
  List<SubInvoiceModel>? subInvoice;
  @JsonKey(name: 'created_at', defaultValue: '')
  String? createdAt;
  @JsonKey(name: 'is_fined', defaultValue: 0)
  int? isFined;
  @JsonKey(name: 'supplier_start', defaultValue: '')
  String? supplierStart;

  InvoiceModel(
      {this.id,
      this.code,
      this.customerId,
      this.customerAvatar,
      this.customerName,
      this.customerAddress,
      this.customerTubeStationNearest,
      this.workingForm,
      this.status,
      this.service,
      this.workingDate,
      this.workingTime,
      this.hours,
      this.paymentType,
      this.travelingCosts,
      this.tmpTotal,
      this.total,
      this.cancel,
      this.subInvoice,
      this.createdAt,
      this.isFined,
      this.supplierStart});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);

  String getChatChannel() {
    return '${AppDataGlobal.userInfo?.id}-$customerId';
  }

  String getCallChannel() {
    return '${AppDataGlobal.userInfo?.id}-$customerId';
  }

  User getCustomer() {
    return User(
      id: customerId.toString(),
      name: customerName,
      image: customerAvatar,
    );
  }

  InvoiceStatus? getStatus() {
    return InvoiceStatus.status
        .firstWhereOrNull((element) => element.id == status);
  }
}
