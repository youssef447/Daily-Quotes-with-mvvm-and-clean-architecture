import 'package:bloc/bloc.dart';
import 'package:dailyquotes/core/utils/globales.dart';
import 'package:dailyquotes/core/utils/themes.dart';
import 'package:dailyquotes/model/services/Network/local/awesomeNotificationService.dart';
import 'package:dailyquotes/view/HomePage/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/Di/injection.dart';
import 'core/utils/apiConstants.dart';
import 'model/services/Network/local/cach_helper.dart';
import 'model/services/Network/remote/dio_helper.dart';
import 'view-model/blocObserver.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding binding = WidgetsFlutterBinding
      .ensureInitialized(); //عشان اتاكد انه هيخلص كل الawaits قبل الرن
  FlutterNativeSplash.preserve(
    widgetsBinding: binding,
  );
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await CacheHelper.init();
  DioHelper.init(baseUrl: ApiConstants.baseUrl);
  configurationDependencies();
  noitificationsEnabled = CacheHelper.getData(key: 'notifications') ?? true;
  if (noitificationsEnabled) {
    await locators.get<AwesomeNotificationService>().init();
  }

  Bloc.observer = MyBlocObserver();
  
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height - AppBar().preferredSize.height;
    width = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            title: 'Daily Quotes',
            //navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: darkTheme,
            home: const HomeScreen(),
          );
        });
  }
}
