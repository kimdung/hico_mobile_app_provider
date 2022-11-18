import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'base/di.dart';
import 'shared/constants/common.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, // Color for Android
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light, // for IOS.
    ),
  );
  await Firebase.initializeApp();

  if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.instance.webAndDesktopInitialize(
      appId: "1329834907365798",
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
  }

  await DependencyInjection.init(DEV_ENVIRONMENT);
  runApp(App());
  configLoading();
}
