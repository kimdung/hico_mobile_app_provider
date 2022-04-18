import 'dart:io';

import 'package:ui_api/datasource/remote/hico_ui_api.dart';
import 'package:ui_api/request/general/bank_response.dart';
import 'package:ui_api/request/general/contact_request.dart';
import 'package:ui_api/request/general/filter_request.dart';
import 'package:ui_api/request/invoice/booking_request.dart';
import 'package:ui_api/request/login/login_request.dart';
import 'package:ui_api/request/register/register_otp_request.dart';
import 'package:ui_api/request/register/register_request.dart';
import 'package:ui_api/request/service/update_service_request.dart';
import 'package:ui_api/request/supplier/supplier_request.dart';
import 'package:ui_api/request/user/avatar_request.dart';
import 'package:ui_api/request/user/changepass_request.dart';
import 'package:ui_api/request/user/update_bank_request.dart';
import 'package:ui_api/request/user/update_info_request.dart';
import 'package:ui_api/response/base_response.dart';
import 'package:ui_api/response/general/address_response.dart';
import 'package:ui_api/response/general/district_response.dart';
import 'package:ui_api/response/general/general_response.dart';
import 'package:ui_api/response/general/master_data_response.dart';
import 'package:ui_api/response/home/home_response.dart';
import 'package:ui_api/response/invoice/booking_response.dart';
import 'package:ui_api/response/invoice/invoice_detail_response.dart';
import 'package:ui_api/response/invoice/invoice_history_response.dart';
import 'package:ui_api/response/news/news_detail_response.dart';
import 'package:ui_api/response/news/news_list_response.dart';
import 'package:ui_api/response/notifications/notification_detail_response.dart';
import 'package:ui_api/response/notifications/notification_list_response.dart';
import 'package:ui_api/response/rating/rating_response.dart';
import 'package:ui_api/response/service/service_categories_response.dart';
import 'package:ui_api/response/service/service_list_response.dart';
import 'package:ui_api/response/statistic/statistic_invoice_response.dart';
import 'package:ui_api/response/statistic/statistic_response.dart';
import 'package:ui_api/response/supplier/supplier_profile_response.dart';
import 'package:ui_api/response/supplier/supplier_response.dart';
import 'package:ui_api/response/user/login_response.dart';
import 'package:ui_api/response/user/user_response.dart';
import 'package:ui_api/response/voucher/check_voucher_response.dart';
import 'package:ui_api/response/voucher/voucher_response.dart';

import '../../response/call/call_token_response.dart';
import '../../response/chat/chat_token_response.dart';
import '../hico_ui_repository.dart';

class HicoUIRepositoryImpl extends HicoUIRepository {
  final HicoUIAPI _api;

  HicoUIRepositoryImpl(this._api);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return _api.login(loginRequest);
  }

  @override
  Future<LoginResponse> loginLine(LoginRequest loginRequest) {
    return _api.loginLine(loginRequest);
  }

  @override
  Future<LoginResponse> loginGG(LoginRequest loginRequest) {
    return _api.loginGG(loginRequest);
  }

  @override
  Future<LoginResponse> loginFB(LoginRequest loginRequest) {
    return _api.loginFB(loginRequest);
  }

  @override
  Future<BaseResponse> logout() {
    return _api.logout();
  }

  @override
  Future<BaseResponse> register(RegisterRequest request) {
    return _api.register(request);
  }

  @override
  Future<LoginResponse> registerOtp(RegisterOtpRequest request) {
    return _api.registerOtp(request);
  }

  @override
  Future<BaseResponse> resendOtp(String email) {
    return _api.resendOtp(email);
  }

  @override
  Future<BaseResponse> updateLangCode(String code) {
    return _api.updateLangCode(code);
  }

  @override
  Future<BaseResponse> changePassword(ChangePassRequest request) {
    return _api.changePassword(request);
  }

  @override
  Future<UserResponse> updateAvatar(File image) {
    return _api.updateAvatar(image);
  }

  @override
  Future<UserResponse> getInfo() {
    return _api.getInfo();
  }

  @override
  Future<BaseResponse> contact(ContactRequest request) {
    return _api.contact(request);
  }

  @override
  Future<MasterDataResponse> masterData() {
    return _api.masterData();
  }

  @override
  Future<NewsListResponse> newsList(int limit, int offset) {
    return _api.newsList(limit, offset);
  }

  @override
  Future<NewsDetailResponse> newsDetail(int id) {
    return _api.newsDetail(id);
  }

  @override
  Future<NotificationListResponse> notificationList(int limit, int offset) {
    return _api.notificationList(limit, offset);
  }

  @override
  Future<NotificationDetailResponse> notificationDetail(int id) {
    return _api.notificationDetail(id);
  }

  //invoice history
  @override
  Future<InvoiceHistoryResponse> invoiceHistory(
    String searchWord,
    int status,
    int limit,
    int offset,
  ) {
    return _api.invoiceHistory(searchWord, status, limit, offset);
  }

  //invoice detail
  @override
  Future<InvoiceDetailResponse> invoiceDetail(int id) {
    return _api.invoiceDetail(id);
  }

  //invoice confirm
  @override
  Future<BaseResponse> invoiceConfirm(int id, int status) {
    return _api.invoiceConfirm(id, status);
  }

  //invoice detail:cancel
  @override
  Future<BaseResponse> invoiceCancel(int id, String reason) {
    return _api.invoiceCancel(id, reason);
  }

  //invoice detail:start
  @override
  Future<BaseResponse> invoiceStart(int id) {
    return _api.invoiceStart(id);
  }

  //invoice detail:completed
  @override
  Future<BaseResponse> invoiceCompleted(int id) {
    return _api.invoiceCompleted(id);
  }

  //rating list
  @override
  Future<RatingResponse> listReview(int star, int limit, int offset) {
    return _api.listReview(star, limit, offset);
  }

  //statistics
  @override
  Future<StatisticsResponse> statistics() {
    return _api.statistics();
  }

  //statistics
  @override
  Future<StatisticInvoiceResponse> statisticsInvoice(int limit, int offset,
      String keyWords, String startDate, String endDate) {
    return _api.statisticsInvoice(limit, offset, keyWords, startDate, endDate);
  }

//address list
  @override
  Future<AddressResponse> addressList(int limit, int offset, String code) {
    return _api.addressList(limit, offset, code);
  }

  //statistics
  @override
  Future<UserResponse> updateProfile(
    File? avatarImage,
    String name,
    int gender,
    String dateOfBirth,
    String email,
    String phoneNumber,
    int bankId,
    String bankBranchName,
    String bankAccountHolder,
    String bankAccountNumber,
    int addressId,
    String address,
    String nearestStation,
    File? documentFrontSide,
    File? documentBackSide,
    String education,
    List<File> documentsCertificate,
    String level,
    String experience,
    int numberOfYearsInJapan,
    int translationExperience,
  ) {
    return _api.updateProfile(
      name,
      gender,
      dateOfBirth,
      email,
      phoneNumber,
      bankId,
      bankBranchName,
      bankAccountHolder,
      bankAccountNumber,
      addressId,
      address,
      nearestStation,
      education,
      documentsCertificate,
      level,
      experience,
      numberOfYearsInJapan,
      translationExperience,
      avatarImage: avatarImage,
      documentFrontSide: documentFrontSide,
      documentBackSide: documentBackSide,
    );
  }

  //servcice
  @override
  Future<ServiceCategoriesResponse> serviceCategories(
      int limit, int offset, String searchWord) {
    return _api.serviceCategories(limit, offset, searchWord);
  }

  @override
  Future<ServiceListResponse> serviceList(
      int limit, int offset, int id, String searchWord) {
    return _api.serviceList(limit, offset, id, searchWord);
  }

  @override
  Future<DistrictResponse> getDistrict(int id) {
    return _api.getDistrict(id);
  }

  @override
  Future<BaseResponse> updateService(UpdateServiceRequest request) {
    return _api.updateService(request);
  }

  @override
  Future<BaseResponse> checkUserTime(UpdateServiceRequest request) {
    return _api.checkUserTime(request);
  }

  @override
  Future<BaseResponse> forgetPassword(String email) {
    return _api.forgetPassword(email);
  }

  @override
  Future<BaseResponse> resetPassword(
      String code, String email, String password) {
    return _api.resetPassword(code, email, password);
  }

  @override
  Future<BankResponse> banks() {
    return _api.banks();
  }

  @override
  Future<ChatTokenResponse> createChatToken() {
    return _api.createChatToken();
  }

  @override
  Future<CallTokenResponse> getCallToken(String channel) {
    return _api.getCallToken(channel);
  }
}
