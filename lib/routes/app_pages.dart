import 'package:get/get.dart';

import '../modules/call/video_call/bindings/video_call_binding.dart';
import '../modules/call/video_call/views/video_call_view.dart';
import '../modules/call/voice_call/bindings/voice_call_binding.dart';
import '../modules/call/voice_call/views/voice_call_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_screen.dart';
import '../modules/config/bindings/config_binding.dart';
import '../modules/config/views/bank_screen.dart';
import '../modules/config/views/change_pass_screen.dart';
import '../modules/config/views/config_screen.dart';
import '../modules/config/views/contact_screen.dart';
import '../modules/config/views/payment_policy_screen.dart';
import '../modules/config/views/policy_screen.dart';
import '../modules/config/views/terms_of_use_screen.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_change_screen.dart';
import '../modules/forgot_password/views/forgot_password_otp_screen.dart';
import '../modules/forgot_password/views/forgot_password_screen.dart';
import '../modules/language/binding/language_binding.dart';
import '../modules/language/view/language_screen.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_screen.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_screen.dart';
import '../modules/medical/binding/medical_binding.dart';
import '../modules/medical/view/medical_screen.dart';
import '../modules/news_detail/bindings/news_detail_binding.dart';
import '../modules/news_detail/views/news_detail_screen.dart';
import '../modules/notification_detail/bindings/notification_detail_binding.dart';
import '../modules/notification_detail/views/notification_detail_screen.dart';
import '../modules/on_boarding/binding/on_boarding_binding.dart';
import '../modules/on_boarding/view/on_boarding_screen.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_screen.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/bindings/profile_update_binding.dart';
import '../modules/profile/views/profile_screen.dart';
import '../modules/profile/views/profile_update_screen.dart';
import '../modules/rating/bindings/rating_binding.dart';
import '../modules/rating/views/rating_screen.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_otp_screen.dart';
import '../modules/register/views/register_screen.dart';
import '../modules/register/views/register_success_screen.dart';
import '../modules/service/bindings/address_service_binding.dart';
import '../modules/service/bindings/category_service_binding.dart';
import '../modules/service/bindings/service_binding.dart';
import '../modules/service/bindings/time_service_binding.dart';
import '../modules/service/bindings/update_service_binding.dart';
import '../modules/service/views/address_service_screen.dart';
import '../modules/service/views/category_service_screen.dart';
import '../modules/service/views/service_screen.dart';
import '../modules/service/views/time_service_screen.dart';
import '../modules/service/views/update_service_screen.dart';
import '../modules/splash/binding/splash_binding.dart';
import '../modules/splash/view/splash_screen.dart';
import '../modules/statistic/bindings/statistic_binding.dart';
import '../modules/statistic/views/statistic_screen.dart';
import '../modules/support/bindings/support_binding.dart';
import '../modules/support/views/support_screen.dart';
import '../modules/wallet/topup_bank/bindings/topup_bank_binding.dart';
import '../modules/wallet/topup_bank/views/topup_bank_screen.dart';
import '../modules/wallet/topup_detail/bindings/topup_detail_binding.dart';
import '../modules/wallet/topup_detail/views/topup_detail_screen.dart';
import '../modules/wallet/topup_komoju/bindings/topup_komoju_binding.dart';
import '../modules/wallet/topup_komoju/views/topup_komoju_screen.dart';
import '../modules/wallet/topup_stripe/bindings/topup_stripe_binding.dart';
import '../modules/wallet/topup_stripe/views/topup_stripe_screen.dart';
import '../modules/wallet/wallet/bindings/wallet_binding.dart';
import '../modules/wallet/wallet/views/wallet_screen.dart';

part 'app_routes.dart';

const INITIAL = Routes.SPLASH;

final routePages = [
  GetPage(
    name: Routes.SPLASH,
    page: () => SplashScreen(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: Routes.LANGUAGE,
    page: () => LanguageScreen(),
    binding: LanguageBinding(),
  ),
  GetPage(
    name: Routes.ONBOARDING,
    page: () => OnBoardingScreen(),
    binding: OnBoardingBinding(),
  ),

  //login
  GetPage(
    name: Routes.LOGIN,
    page: () => LoginScreen(),
    binding: LoginBinding(),
  ),

  //register
  GetPage(
    name: Routes.REGISTER,
    page: () => RegisterScreen(),
    binding: RegisterBinding(),
  ),
  GetPage(
    name: Routes.REGISTER_OTP,
    page: () => RegisterOtpScreen(),
    binding: RegisterBinding(),
  ),
  GetPage(
    name: Routes.REGISTER_SUCCESS,
    page: () => RegisterSuccessScreen(),
    binding: RegisterBinding(),
  ),

  //forgot pass
  GetPage(
    name: Routes.FORGOT_PASSWORD,
    page: () => ForgotPasswordScreen(),
    binding: ForgotPasswordBinding(),
  ),
  GetPage(
    name: Routes.FORGOT_PASSWORD_OTP,
    page: () => ForgotPasswordOTPScreen(),
    binding: ForgotPasswordBinding(),
  ),
  GetPage(
    name: Routes.FORGOT_PASSWORD_CHANGE,
    page: () => ForgotPasswordChangeScreen(),
    binding: ForgotPasswordBinding(),
  ),
  GetPage(
    name: Routes.MAIN,
    page: () => MainScreen(),
    binding: MainBinding(),
  ),

  GetPage(
      name: Routes.ORDER_DETAIL,
      page: () => OrderScreen(),
      binding: OrderBinding()),

  //notification
  // GetPage(
  //     name: Routes.NOTIFICATION,
  //     page: () => NotificationScreen(),
  //     binding: NotificationBinding()),
  GetPage(
      name: Routes.NOTIFICATION_DETAIL,
      page: () => NotificationDetailScreen(),
      binding: NotificationDetailBinding()),

  //account
  // GetPage(name: Routes.NEWS, page: () => NewsScreen(), binding: NewsBinding()),
  // GetPage(
  //     name: Routes.ACCOUNT,
  //     page: () => AccountScreen(),
  //     binding: AccountBinding()),

  GetPage(
      name: Routes.NEWS_DETAIL,
      page: () => NewsDetailScreen(),
      binding: NewsDetailBinding()),
  GetPage(
      name: Routes.CONFIG,
      page: () => ConfigScreen(),
      binding: ConfigBinding()),
  GetPage(
      name: Routes.CONTACT,
      page: () => ContactScreen(),
      binding: ConfigBinding()),
  GetPage(
      name: Routes.BANK, page: () => BankScreen(), binding: ConfigBinding()),
  GetPage(
      name: Routes.CHANGE_PASS,
      page: () => ChangePassScreen(),
      binding: ConfigBinding()),
  GetPage(
      name: Routes.POLICY,
      page: () => PolicyScreen(),
      binding: ConfigBinding()),
  GetPage(
      name: Routes.PAYMENT_POLICY,
      page: () => PaymentPolicyScreen(),
      binding: ConfigBinding()),
  GetPage(
      name: Routes.TERMS_OF_USE,
      page: () => TermOfUseScreen(),
      binding: ConfigBinding()),
  GetPage(
      name: Routes.SUPPORT,
      page: () => SupportScreen(),
      binding: SupportBinding()),
  GetPage(
      name: Routes.STATISTIC,
      page: () => StatisticScreen(),
      binding: StatisticBinding()),
  GetPage(
      name: Routes.PROFILE,
      page: () => ProfileScreen(),
      binding: ProfileBinding()),
  GetPage(
      name: Routes.PROFILE_UPDATE,
      page: () => ProfileUpdateScreen(),
      binding: ProfileUpdateBinding()),
  GetPage(
      name: Routes.SERVICE,
      page: () => ServiceScreen(),
      binding: ServiceBinding()),
  GetPage(
      name: Routes.UPDATE_SERVICE,
      page: () => UpdateServiceScreen(),
      binding: UpdateServiceBinding()),
  GetPage(
      name: Routes.CATEGORY_SERVICE,
      page: () => CategoryServiceScreen(),
      binding: CategoryServiceBinding()),
  GetPage(
      name: Routes.ADDRESS_SERVICE,
      page: () => AddressServiceScreen(),
      binding: AddressServiceBinding()),
  GetPage(
      name: Routes.TIME_SERVICE,
      page: () => TimeServiceScreen(),
      binding: TimeServiceBinding()),
  GetPage(
      name: Routes.RATING,
      page: () => RatingScreen(),
      binding: RatingtBinding()),
  GetPage(
    name: Routes.CHAT,
    page: () => ChatScreen(),
    binding: ChatBinding(),
  ),
  GetPage(
    name: Routes.VOICE_CALL,
    page: () => VoiceCallView(),
    binding: VoiceCallBinding(),
  ),
  GetPage(
    name: Routes.VIDEO_CALL,
    page: () => VideoCallView(),
    binding: VideoCallBinding(),
  ),
  GetPage(
    name: Routes.MEDICAL,
    page: () => const MeidcalScreen(),
    binding: MedicalBinding(),
  ),
  GetPage(
    name: Routes.WALLET,
    page: () => WalletScreen(),
    binding: WalletBinding(),
  ),
  GetPage(
    name: Routes.TOPUP_BANK,
    page: () => TopupBankScreen(),
    binding: TopupBankBinding(),
  ),
  GetPage(
    name: Routes.TOPUP_STRIPE,
    page: () => TopupStripeScreen(),
    binding: TopupStripeBinding(),
  ),
  GetPage(
    name: Routes.TOPUP_DETAIL,
    page: () => TopupDetailScreen(),
    binding: TopupDetailBinding(),
  ),
  GetPage(
    name: Routes.TOPUP_KOMOJU,
    page: () => TopupKomojuScreen(),
    binding: TopupKomojuBinding(),
  ),
];
