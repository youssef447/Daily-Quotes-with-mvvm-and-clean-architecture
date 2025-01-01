import 'package:bloc/bloc.dart';
import 'package:dailyquotes/core/utils/utils.dart';
import 'package:dailyquotes/core/theme/themes.dart';

import 'package:dailyquotes/features/home_page/presentation/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/injection.dart';
import 'core/constants/api_constants.dart';
import 'core/services/Network/local/cach_helper.dart';
import 'core/services/Network/remote/dio_helper.dart';

import 'core/utils/blocObserver.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/services/notifications/awesome_notification_service.dart';

void main() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();

  await initUiConfigs(binding);

  await initNetworkServices();
  configurationDependencies();
  await initNotifications();

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
        designSize: const Size(375, 812),
        /* fontSizeResolver: (fontSize, instance) =>
          FontSizeResolvers.height(fontSize, instance), */
        builder: (context, child) {
          return MaterialApp(
            title: 'Daily Quotes',
            //navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: darkTheme,
            home: const HomePage(),
          );
        });
  }
}

/// Initializes network-related services.
Future<void> initNetworkServices() async {
  await CacheHelper.init();
  DioHelper.init(baseUrl: ApiConstants.baseUrl);
}

/// Initialize notification service if it's enabled in the cache.
/// If cache has no value, it's the first time, so we request permission
/// and store the value in the cache.
/// If the value is `false`, we don't initialize the service.
Future<void> initNotifications() async {
  noitificationsEnabled = CacheHelper.getData(key: 'notifications') ?? true;
  //if null this means that's the first time requestion permission cuz when refused we store false value
  if (noitificationsEnabled) {
    await locators.get<AwesomeNotificationService>().init();
  }
}

/// Initializes some UI configurations before running the app.
/// It does the following:
/// 1. Preserves the splash screen until the app is fully initialized.
/// 2. Sets the preferred orientations for the app.
/// 3. Sets the [BlocObserver] for the app.

Future<void> initUiConfigs(WidgetsBinding binding) async {
  FlutterNativeSplash.preserve(
    widgetsBinding: binding,
  );
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Bloc.observer = MyBlocObserver();
}
