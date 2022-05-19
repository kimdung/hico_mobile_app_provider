import 'dart:io';

import 'package:ui_api/datasource/remote/hico_ui_api.dart';
import 'package:ui_api/request/general/bank_response.dart';
import 'package:ui_api/request/general/contact_request.dart';
import 'package:ui_api/request/login/login_request.dart';
import 'package:ui_api/request/register/register_otp_request.dart';
import 'package:ui_api/request/register/register_request.dart';
import 'package:ui_api/request/service/update_service_request.dart';
import 'package:ui_api/request/user/changepass_request.dart';
import 'package:ui_api/response/base_response.dart';
import 'package:ui_api/response/general/address_response.dart';
import 'package:ui_api/response/general/district_response.dart';
import 'package:ui_api/response/general/master_data_response.dart';
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
import 'package:ui_api/response/user/login_response.dart';
import 'package:ui_api/response/user/user_response.dart';

import '../../request/invoice/booking_extend_request.dart';
import '../../request/invoice/confirm_sub_request.dart';
import '../../response/call/call_token_response.dart';
import '../../response/chat/chat_token_response.dart';
import '../../response/invoice/booking_extend_response.dart';
import '../../response/user/upload_certificate_response.dart';
import '../../response/user/upload_response.dart';
import '../../response/wallet/topup_history_response.dart';
import '../../response/wallet/topup_komaju_response.dart';
import '../../response/wallet/topup_response.dart';
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
      String keyWords, String startDate, String endDate, int status) {
    return _api.statisticsInvoice(
        limit, offset, keyWords, startDate, endDate, status);
  }

//address list
  @override
  Future<AddressResponse> addressList(int limit, int offset, String code) {
    return _api.addressList(limit, offset, code);
  }

  //statistics
  @override
  Future<UserResponse> updateProfile(
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
    String level,
    String experience,
    int numberOfYearsInJapan,
    int interpretationExperience,
    int translationExperience,
    String tranlationExpericenDetail,
    String interpretationExperienceDetail,
    String removeCurriculumVitaeFiles,
    String removeWorkExperienceFiles,
    List<int> removeDocumentsCertificate,
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
      level,
      experience,
      numberOfYearsInJapan,
      interpretationExperience,
      translationExperience,
      tranlationExpericenDetail,
      interpretationExperienceDetail,
      removeCurriculumVitaeFiles,
      removeWorkExperienceFiles,
      removeDocumentsCertificate,
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

  @override
  Future<BaseResponse> confirmSub(ConfirmSubRequest request) {
    return _api.confirmSub(request);
  }

  @override
  Future<BaseResponse> requestUpdate() {
    return _api.requestUpdate();
  }

  @override
  Future<TopupHistoryResponse> topupHistory(int limit, int offset) {
    return _api.topupHistory(limit, offset);
  }

  @override
  Future<TopupResponse> topupBank(double amount) {
    return _api.topupBank(amount);
  }

  @override
  Future<TopupKomajuResponse> topupKomaju(double amount, int type) {
    return _api.topupKomaju(amount, type);
  }

  @override
  Future<TopupResponse> topupBankConfirm(
      File imageBill, String payInCode, String note) {
    return _api.topupBankConfirm(imageBill, payInCode, note);
  }

  @override
  Future<TopupResponse> topupKomojuResult(String sessionId) {
    return _api.topupKomojuResult(sessionId);
  }

  @override
  Future<TopupResponse> topupStripe(
      String paymentMethodId, String name, double amount) {
    return _api.createPayInStripe(paymentMethodId, name, amount);
  }

  @override
  Future<UploadResponse> uploadFile(File file, int type) {
    return _api.uploadFile(file, type);
  }

  @override
  Future<UploadCertificateResponse> uploadCetificateFile(File file, int type) {
    return _api.uploadCetificateFile(file, type);
  }

  @override
  Future<BookingExtendResponse> subDetail(int invoiceId, int subId) {
    return _api.subDetail(invoiceId, subId);
  }

  @override
  Future<BaseResponse> subConfirm(BookingExtendRequest request) {
    return _api.subConfirm(request);
  }

  @override
  Future<BaseResponse> beginCall(int invoiceId) {
    return _api.beginCall(invoiceId);
  }

  @override
  Future<BaseResponse> endCall(int invoiceId) {
    return _api.endCall(invoiceId);
  }
}
