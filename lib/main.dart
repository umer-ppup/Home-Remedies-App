import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_remedies/language/language_data.dart';
import 'package:home_remedies/modules/splash/splash_screen.dart';
import 'package:home_remedies/shared/constants/color_resources.dart';
import 'package:home_remedies/shared/constants/string_resources.dart';
import 'package:home_remedies/shared/constants/theme_resources.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ColorResources.colorBlue,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light, // status bar color
  ));
  await GetStorage.init(StringResources.storageName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(), // your translations
      locale: Locale('en', 'US'), // translations will be displayed in that locale
      fallbackLocale: Locale('en', 'UK'),
      debugShowCheckedModeBanner: false,
      theme: getLightThemeData(),
      darkTheme: getLightThemeData(),
      home: SplashScreen(),
      title: StringResources.appName,
      builder: EasyLoading.init()
    );
  }
}