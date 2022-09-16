import 'dart:io';

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

import '../request/invoice/booking_extend_request.dart';
import '../request/invoice/confirm_sub_request.dart';
import '../response/call/call_token_response.dart';
import '../response/chat/chat_token_response.dart';
import '../response/invoice/booking_extend_response.dart';
import '../response/notifications/notification_unread_response.dart';
import '../response/user/upload_certificate_response.dart';
import '../response/user/upload_response.dart';
import '../response/wallet/topup_history_response.dart';
import '../response/wallet/topup_komaju_response.dart';
import '../response/wallet/topup_response.dart';

abstract class HicoUIRepository {
  /* User */
  Future<LoginResponse> login(LoginRequest loginRequest);

  /* Line */
  Future<LoginResponse> loginLine(LoginRequest loginRequest);

  /* GG */
  Future<LoginResponse> loginGG(LoginRequest loginRequest);

  /* FB */
  Future<LoginResponse> loginFB(LoginRequest loginRequest);

  //logout
  Future<BaseResponse> logout();

  //Register
  Future<BaseResponse> register(RegisterRequest request);

  //Register Otp
  Future<LoginResponse> registerOtp(RegisterOtpRequest request);

  //resend Otp
  Future<BaseResponse> resendOtp(String email);

  //updateLangCode
  Future<BaseResponse> updateLangCode(String code);

  //changePass
  Future<BaseResponse> changePassword(ChangePassRequest request);

  //update avatar
  Future<UserResponse> updateAvatar(File image);

  //get info
  Future<UserResponse> getInfo();

  //contact
  Future<BaseResponse> contact(ContactRequest request);

  //masterdata
  Future<MasterDataResponse> masterData();

  //news list
  Future<NewsListResponse> newsList(int limit, int offset);

  //news detail
  Future<NewsDetailResponse> newsDetail(int id);

  //notification list
  Future<NotificationListResponse> notificationList(int limit, int offset);

  //notification detail
  Future<NotificationDetailResponse> notificationDetail(int id);

  Future<NotificationUnreadResponse> notificationUnRead();

//get list invoice historry
  Future<InvoiceHistoryResponse> invoiceHistory(
    String searchWord,
    int status,
    int limit,
    int offset,
  );

  //get invoice detail
  Future<InvoiceDetailResponse> invoiceDetail(
    int id,
  );

  //get invoice confirm
  Future<BaseResponse> invoiceConfirm(
    int id,
    int status,
  );

  //invoice detail: cancel
  Future<BaseResponse> invoiceCancel(
    int id,
    String reason,
  );

  //invoice detail: start
  Future<BaseResponse> invoiceStart(
    int id,
  );

  //invoice detail: editRequest
  Future<BaseResponse> invoiceCompleted(
    int id,
  );

  //rating list
  Future<RatingResponse> listReview(
    int star,
    int limit,
    int offset,
  );

  //statistics
  Future<StatisticsResponse> statistics();
  Future<StatisticInvoiceResponse> statisticsInvoice(int limit, int offset,
      String keyWords, String startDate, String endDate, int status);

  Future<BaseResponse> confirmSub(ConfirmSubRequest request);

  Future<BaseResponse> requestUpdate();

  //address list
  Future<AddressResponse> addressList(int limit, int offset, String code);

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
  );

  //Service categories
  Future<ServiceCategoriesResponse> serviceCategories(
      int limit, int offset, String searchWord);

  //Service list
  Future<ServiceListResponse> serviceList(
      int limit, int offset, int id, String searchWord);

  //get district list
  Future<DistrictResponse> getDistrict(int id);

  //update service
  Future<BaseResponse> updateService(UpdateServiceRequest request);

//update service
  Future<BaseResponse> requestUpdateService();

  //check UserTime
  Future<BaseResponse> checkUserTime(UpdateServiceRequest request);

  //check UserTime
  Future<BaseResponse> forgetPassword(String email);

  //check UserTime
  Future<BaseResponse> resetPassword(
      String code, String email, String password);

  //check UserTime
  Future<BankResponse> banks();

  // Create chat token
  Future<ChatTokenResponse> createChatToken();

  // Create call token
  Future<CallTokenResponse> getCallToken(String channel, int? invoiceId);

  Future<BaseResponse> beginCall(int invoiceId);

  Future<BaseResponse> endCall(int invoiceId);

  Future<BaseResponse> sendCallNotification(int invoiceId);

  Future<BaseResponse> sendMissCall(int invoiceId);

  /* Wallet */

  Future<TopupHistoryResponse> topupHistory(int limit, int offset);

  Future<TopupResponse> topupBank(double amount);

  Future<TopupResponse> topupBankConfirm(
      File imageBill, String payInCode, String note);

  Future<TopupKomajuResponse> topupKomaju(double amount, int type);

  Future<TopupResponse> topupKomojuResult(String sessionId);

  Future<TopupResponse> topupStripe(
      String paymentMethodId, String name, double amount);

  Future<UploadResponse> uploadFile(File file, int type);
  Future<UploadCertificateResponse> uploadCetificateFile(File file, int type);

  Future<BookingExtendResponse> subDetail(int invoiceId, int subId);

  Future<BaseResponse> subConfirm(BookingExtendRequest request);
  Future<BaseResponse> deleteUser();
}
