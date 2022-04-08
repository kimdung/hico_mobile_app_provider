// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) => InvoiceModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      customerId: json['customer_id'] as int? ?? 0,
      customerAvatar: json['customer_avatar'] as String? ?? '',
      customerName: json['customer_name'] as String? ?? '',
      customerAddress: json['customer_address'] as String? ?? '',
      customerTubeStationNearest:
          json['customer_tube_station_nearest'] as String? ?? '',
      workingForm: json['working_form'] as int? ?? 0,
      status: json['status'] as int?,
      service: json['service'] == null
          ? null
          : ServiceModel.fromJson(json['service'] as Map<String, dynamic>),
      workingDate: json['working_date'] as String? ?? '',
      workingTime: json['working_time'] as String? ?? '',
      hours: (json['hours'] as num?)?.toDouble(),
      paymentType: json['payment_type'] as int? ?? 0,
      travelingCosts: json['traveling_costs'] as int? ?? 0,
      tmpTotal: json['tmp_total'] as int? ?? 0,
      total: json['total'] as int?,
      cancel: json['cancel'] == null
          ? null
          : CancelReasonModel.fromJson(json['cancel'] as Map<String, dynamic>),
      subInvoice: (json['sub_invoice'] as List<dynamic>?)
          ?.map((e) => SubInvoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String? ?? '',
      isFined: json['is_fined'] as int? ?? 0,
      supplierStart: json['supplier_start'] as String? ?? '',
    )
      ..serviceId = json['service_id'] as int? ?? 0
      ..serviceName = json['service_name'] as String? ?? '';

Map<String, dynamic> _$InvoiceModelToJson(InvoiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'customer_id': instance.customerId,
      'customer_avatar': instance.customerAvatar,
      'customer_name': instance.customerName,
      'customer_address': instance.customerAddress,
      'customer_tube_station_nearest': instance.customerTubeStationNearest,
      'service_id': instance.serviceId,
      'service_name': instance.serviceName,
      'working_form': instance.workingForm,
      'status': instance.status,
      'service': instance.service,
      'working_date': instance.workingDate,
      'working_time': instance.workingTime,
      'hours': instance.hours,
      'payment_type': instance.paymentType,
      'traveling_costs': instance.travelingCosts,
      'tmp_total': instance.tmpTotal,
      'total': instance.total,
      'cancel': instance.cancel,
      'sub_invoice': instance.subInvoice,
      'created_at': instance.createdAt,
      'is_fined': instance.isFined,
      'supplier_start': instance.supplierStart,
    };
