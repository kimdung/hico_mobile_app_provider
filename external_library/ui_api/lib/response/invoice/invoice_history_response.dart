import 'package:json_annotation/json_annotation.dart';
import 'package:ui_api/models/invoice/invoice_model.dart';
import 'package:ui_api/response/base_response.dart';

part 'invoice_history_response.g.dart';

@JsonSerializable()
class InvoiceHistoryResponse extends BaseResponse {
  @JsonKey(name: 'data')
  InvoiceList? data;

  InvoiceHistoryResponse({this.data});

  factory InvoiceHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoiceHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceHistoryResponseToJson(this);
}

@JsonSerializable()
class InvoiceList extends BaseResponse {
  @JsonKey(name: 'rows')
  List<InvoiceModel>? rows;

  InvoiceList({this.rows});

  factory InvoiceList.fromJson(Map<String, dynamic> json) =>
      _$InvoiceListFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceListToJson(this);
}
