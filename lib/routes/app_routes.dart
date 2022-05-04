part of 'app_pages.dart';

abstract class Routes {
  static const SPLASH = '/';
  static const LANGUAGE = '/language';
  static const ONBOARDING = '/onboarding';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const REGISTER_OTP = '/register_otp';
  static const REGISTER_SUCCESS = '/register_success';

  static const FORGOT_PASSWORD = '/forgot_password';
  static const FORGOT_PASSWORD_OTP = '/forgot_password_otp';
  static const FORGOT_PASSWORD_CHANGE = '/forgot_password_change';

  static const MAIN = '/main';

  static const HOME = '/home';
  static const ORDER_LIST = '/order_list';
  static const ORDER_DETAIL = '/order_detail';
  static const NOTIFICATION = '/notification';
  static const NOTIFICATION_DETAIL = '/notification_detail';
  static const NEWS = '/news';
  static const NEWS_DETAIL = '/news_detail';
  static const ACCOUNT = '/account';
  static const CONFIG = '/config';
  static const CONTACT = '/contact';
  static const BANK = '/bank';
  static const CHANGE_PASS = '/change_pass';
  static const POLICY = '/policy';
  static const PAYMENT_POLICY = '/payment_policy';
  static const TERMS_OF_USE = '/terms_of_use';
  static const SUPPORT = '/support';
  static const STATISTIC = '/statistic';
  static const PROFILE = '/profile';
  static const PROFILE_UPDATE = '/profile_update';
  static const SERVICE = '/service';
  static const UPDATE_SERVICE = '/update_service';
  static const CATEGORY_SERVICE = '/category_service';
  static const ADDRESS_SERVICE = '/address_service';
  static const TIME_SERVICE = '/time_service';
  static const RATING = '/rating';
  static const CHAT = '/chat';
  static const VOICE_CALL = '/voice-call';
  static const VIDEO_CALL = '/video-call';
  static const MEDICAL = '/medical';

  static const WALLET = '/wallet/wallet';
  static const TOPUP_BANK = '/wallet/topup-bank';
  static const TOPUP_STRIPE = '/wallet/topup-stripe';
  static const TOPUP_DETAIL = '/wallet/topup-detail';
  static const TOPUP_KOMOJU = '/wallet/topup-komoju';
}
