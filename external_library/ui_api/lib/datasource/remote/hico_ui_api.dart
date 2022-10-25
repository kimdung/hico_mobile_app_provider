import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
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
import '../../response/notifications/notification_unread_response.dart';
import '../../response/user/upload_certificate_response.dart';
import '../../response/user/upload_response.dart';
import '../../response/wallet/topup_history_response.dart';
import '../../response/wallet/topup_komaju_response.dart';
import '../../response/wallet/topup_response.dart';

part 'hico_ui_api.g.dart';

@RestApi()
abstract class HicoUIAPI {
  factory HicoUIAPI(Dio dio) = _HicoUIAPI;

  @POST('/v1/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  //Login Line
  @POST('/v1/auth/loginWithLine')
  Future<LoginResponse> loginLine(@Body() LoginRequest request);

  //Login GG
  @POST('/v1/auth/loginWithGoogle')
  Future<LoginResponse> loginGG(@Body() LoginRequest request);

  //Login FB
  @POST('/v1/auth/loginWithFacebook')
  Future<LoginResponse> loginFB(@Body() LoginRequest request);

  //master data
  @GET('/v1/masterData')
  Future<MasterDataResponse> masterData();

  // news
  @GET('/v1/news/list')
  Future<NewsListResponse> newsList(
    @Query('limit') int limit,
    @Query('offset') int offset,
  );
  // news detail
  @GET('/v1/news/detail')
  Future<NewsDetailResponse> newsDetail(
    @Query('news_id') int id,
  );

// notification
  @GET('/v1/notification/list')
  Future<NotificationListResponse> notificationList(
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  // notification detail
  @GET('/v1/notification/detail')
  Future<NotificationDetailResponse> notificationDetail(
    @Query('notification_id') int id,
  );

  // notification count unread
  @GET('/v1/notification/count_notify_unread')
  Future<NotificationUnreadResponse> notificationUnRead();

  //master data
  @GET('/v1/auth/logout')
  Future<BaseResponse> logout();

  //Register
  @POST('/v1/auth/register')
  Future<BaseResponse> register(@Body() RegisterRequest request);

  //Register Otp
  @POST('/v1/auth/active')
  Future<LoginResponse> registerOtp(@Body() RegisterOtpRequest request);

  //resend Otp
  @POST('/v1/auth/resendActive')
  Future<BaseResponse> resendOtp(
    @Query('email') String email,
  );

  //updateLangCode
  @POST('/v1/updateLangCode')
  Future<BaseResponse> updateLangCode(
    @Query('lang_code') String code,
  );

  //updateLangCode
  @POST('/v1/password/change')
  Future<BaseResponse> changePassword(@Body() ChangePassRequest request);

  //update avatar
  @POST('/v1/user/update/avatar')
  Future<UserResponse> updateAvatar(@Part() File avatar_image);

  // get info
  @GET('/v1/user/me')
  Future<UserResponse> getInfo();

//contact
  @POST('/v1/contact')
  Future<BaseResponse> contact(@Body() ContactRequest request);

  //invoice
  @GET('/v1/supplier/invoice/list')
  Future<InvoiceHistoryResponse> invoiceHistory(
    @Query('key_words') String searchWord,
    @Query('status') int status,
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  //invoice detail
  @GET('/v1/supplier/invoice/detail')
  Future<InvoiceDetailResponse> invoiceDetail(
    @Query('invoice_id') int id,
  );

  //invoice confirm
  @POST('/v1/supplier/invoice/confirm')
  Future<BaseResponse> invoiceConfirm(
    @Query('invoice_id') int id,
    @Query('status') int status,
  );

  //invoice cancel
  @POST('/v1/supplier/invoice/cancel')
  Future<BaseResponse> invoiceCancel(
    @Query('invoice_id') int id,
    @Query('reason') String reason,
  );

  //invoice start
  @POST('/v1/supplier/invoice/begin')
  Future<BaseResponse> invoiceStart(
    @Query('invoice_id') int id,
  );

  //invoice completed
  @POST('/v1/supplier/invoice/completed')
  Future<BaseResponse> invoiceCompleted(
    @Query('invoice_id') int id,
  );

  //Rating list
  @GET('/v1/supplier/invoice/listReview')
  Future<RatingResponse> listReview(
    @Query('number_star') int star,
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  //Statistics
  @GET('/v1/supplier/invoice/statistics')
  Future<StatisticsResponse> statistics();

  //Statistics Invoice
  @GET('/v1/supplier/invoice/invoiceCompleteList')
  Future<StatisticInvoiceResponse> statisticsInvoice(
    @Query('limit') int limit,
    @Query('offset') int offset,
    @Query('key_words') String keyWords,
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
    @Query('status') int status,
  );

//get address
  @GET('/v1/address/list')
  Future<AddressResponse> addressList(
    @Query('limit') int limit,
    @Query('offset') int offset,
    @Query('code') String code,
  );

  //update infor
  @POST('/v1/user/update')
  @MultiPart()
  Future<UserResponse> updateProfile(
    @Query('name') String name,
    @Query('gender') int gender,
    @Query('date_of_birth') String dateOfBirth,
    @Query('email') String email,
    @Query('phone_number') String phoneNumber,
    @Query('bank_id') int bankId,
    @Query('bank_branch_name') String bankBranchName,
    @Query('bank_account_holder') String bankAccountHolder,
    @Query('bank_account_number') String bankAccountNumber,
    @Query('address_id') int addressId,
    @Query('address') String address,
    @Query('nearest_station') String nearestStation,
    @Query('education') String education,
    @Query('level') String level,
    @Query('experience') String experience,
    @Query('number_of_years_in_japan') int numberOfYearsInJapan,
    @Query('interpretation_experience') int interpretationExperience,
    @Query('translation_experience') int translationExperience,
    @Query('interpretation_experience_detail')
        String interpretationExperienceDetail,
    @Query('translation_experience_detail') String translationExperienceDetail,
    @Query('remove_curriculum_vitae_files') String removeCurriculumVitaeFiles,
    @Query('remove_work_experience_files') String removeWorkExperienceFiles,
    @Query('remove_documents_certificate')
        List<int> removeDocumentsCertificate, {
    @Part(value: 'document_front_side') File? documentFrontSide,
    @Part(value: 'document_back_side') File? documentBackSide,
  });

  //service categories
  @GET('/v1/customer/category/list')
  Future<ServiceCategoriesResponse> serviceCategories(
    @Query('limit') int limit,
    @Query('offset') int offset,
    @Query('searchWord') String searchWord,
  );

  //service list
  @GET('/v1/customer/service/list/byCategory')
  Future<ServiceListResponse> serviceList(
    @Query('limit') int limit,
    @Query('offset') int offset,
    @Query('service_category_id') int id,
    @Query('searchWord') String searchWord,
  );

  //get district
  @GET('/v1/listDistrictByProvince')
  Future<DistrictResponse> getDistrict(
    @Query('province_id') int id,
  );

  //update service
  @POST('/v1/user/updateUserService')
  Future<BaseResponse> updateService(
    @Body() UpdateServiceRequest request,
  );

  //request update service
  @POST('/v1/user/requestUpdateService')
  Future<BaseResponse> requestUpdateService();

  //check UserTime
  @POST('/v1/user/checkUserTime')
  Future<BaseResponse> checkUserTime(
    @Body() UpdateServiceRequest request,
  );

  //Forgotpass
  @POST('/v1/password/forget')
  Future<BaseResponse> forgetPassword(
    @Query('email') String email,
  );

  //ResetPass otp
  @POST('/api/v1/password/checkOTPForgotPassword')
  Future<BaseResponse> forgetPasswordOtp(
    @Query('code') String code,
    @Query('email') String email,
  );

  //ResetPass
  @POST('/v1/password/reset')
  Future<BaseResponse> resetPassword(
    @Query('code') String code,
    @Query('email') String email,
    @Query('new_password') String password,
  );

  // Get bank list
  @GET('/v1/bank/list/customer')
  Future<BankResponse> banks();

  //Get Token
  @POST('/v1/conversation/createToken')
  Future<ChatTokenResponse> createChatToken();

  //Get call token
  @POST('/v1/agoraCall/createToken')
  Future<CallTokenResponse> getCallToken(
      @Query('channel') String channel, @Query('invoice_id') int? invoiceId);

  @POST('/v1/supplier/invoice/beginOnline')
  Future<BaseResponse> beginCall(@Query('invoice_id') int invoiceId);

  @POST('/v1/supplier/invoice/end')
  Future<BaseResponse> endCall(@Query('invoice_id') int invoiceId);

  @POST('/v1/agoraCall/sendFCMToCall')
  Future<BaseResponse> sendCallNotification(
      @Query('invoice_id') int? invoiceId,
      @Query('callId') String? callId,
      @Query('callIsVideo') bool? callIsVideo,
      @Query('callerName') String? callerName,
      @Query('callerPic') String? callerPic);

  @POST('/v1/agoraCall/sendFCMMissedCall')
  Future<BaseResponse> sendMissCall(@Query('invoice_id') int invoiceId);

  //invoice confirm sub
  @POST('/v1/supplier/invoice/workContent')
  Future<BaseResponse> confirmSub(@Body() ConfirmSubRequest request);

  //invoice confirm sub
  @POST('/v1/user/requestUpdate')
  Future<BaseResponse> requestUpdate();

  /* Wallet */
  @GET('/v1/payIn/list')
  Future<TopupHistoryResponse> topupHistory(
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  @POST('/v1/payIn/createPayInCode')
  Future<TopupResponse> topupBank(@Query('amount') double amount);

  @MultiPart()
  @POST('/v1/payIn/createPayInBank')
  Future<TopupResponse> topupBankConfirm(
    @Part(name: 'image') File imageBill,
    @Query('pay_in_code') String payInCode,
    @Query('note') String note,
  );

  @POST('/v1/payIn/createPayInKomoju')
  Future<TopupKomajuResponse> topupKomaju(
    @Query('amount') double amount,
    @Query('type') int type,
  );

  @GET('/v1/ipnKomoju')
  Future<TopupResponse> topupKomojuResult(
      @Query('session_id') String sessionId);

  @POST('/v1/payIn/createPayInStripe')
  Future<TopupResponse> createPayInStripe(
      @Query('payment_method_id') String paymentMethodId,
      @Query('name') String name,
      @Query('amount') double amount);

  //update file
  @POST('/v1/user/uploadFileUser')
  Future<UploadResponse> uploadFile(@Part() File file, @Query('type') int type);

  //update file
  @POST('/v1/user/uploadCetificateFileUser')
  Future<UploadCertificateResponse> uploadCetificateFile(
      @Part() File file, @Query('type') int type);

  @GET('/v1/supplier/invoice/subDetail')
  Future<BookingExtendResponse> subDetail(
      @Query('invoice_id') int invoiceId, @Query('sub_id') int subId);

  @POST('/v1/supplier/invoice/subConfirm')
  Future<BaseResponse> subConfirm(@Body() BookingExtendRequest request);

  @POST('/v1/user/deleteUser')
  Future<BaseResponse> deleteUser();
}
