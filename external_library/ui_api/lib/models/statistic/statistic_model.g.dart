// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticModel _$StatisticModelFromJson(Map<String, dynamic> json) =>
    StatisticModel(
      balance: (json['balance'] as num?)?.toDouble(),
      earnedTotal: (json['earned_total'] as num?)?.toDouble(),
      invoiceComplete: (json['invoice_complete'] as num?)?.toDouble(),
      invoiceCancelByCustomer:
          (json['invoice_cancel_by_customer'] as num?)?.toDouble(),
      paid: (json['paid'] as num?)?.toDouble(),
      remain: (json['remain'] as num?)?.toDouble(),
      finedAmount: (json['fined_amount'] as num?)?.toDouble(),
      cancelTimes: (json['cancel_times'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StatisticModelToJson(StatisticModel instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'earned_total': instance.earnedTotal,
      'invoice_complete': instance.invoiceComplete,
      'invoice_cancel_by_customer': instance.invoiceCancelByCustomer,
      'paid': instance.paid,
      'remain': instance.remain,
      'fined_amount': instance.finedAmount,
      'cancel_times': instance.cancelTimes,
    };
