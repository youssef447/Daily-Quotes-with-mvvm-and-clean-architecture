import 'package:dailyquotes/core/utils/globales.dart';

import 'package:dailyquotes/presentation/custom_color_theme/controller/custom_color_theme_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/injection.dart';
import 'core/constants/api_constants.dart';
import 'core/routes/app_route_generator.dart';
import 'core/routes/app_routes.dart';
import 'core/services/Network/local/cach_helper.dart';
import 'core/services/Network/remote/dio_helper.dart';
import 'core/services/background/work_manager_service.dart';
import 'core/services/notifications/awesome_notification_service.dart';

import 'core/theme/colors/app_colors.dart';
import 'core/utils/bloc_observer.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'presentation/custom_color_theme/controller/custom_color_theme_states.dart';
import 'presentation/home_page/controller/home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configurationDependencies();
  await initUiConfigs();
  await initNetworkServices();
  await initNotifications();

  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class AppColorsProvider extends InheritedWidget {
  final AppColors appColors;
  const AppColorsProvider(
      {super.key, required this.appColors, required super.child});

  static AppColorsProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppColorsProvider>()!;
  @override
  bool updateShouldNotify(covariant AppColorsProvider oldWidget) {
    print(
        'should update ${oldWidget.appColors.primary != appColors.primary || oldWidget.appColors.secondaryPrimary != appColors.secondaryPrimary || oldWidget.appColors.background != appColors.background}');
    return true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => CustomColorThemeController()..getTheme(),
              ),
              BlocProvider(
                create: (_) => HomeCubit()..getNotificationShapeCaches(),
              ),
            ],
            child:
                BlocBuilder<CustomColorThemeController, CustomColorThemeStates>(
                    buildWhen: (previous, current) {
              return current is ConfigThemeStateSuccess;
            }, builder: (context, _) {
              return MaterialApp(
                title: 'Daily Quotes',
                debugShowCheckedModeBanner: false,
                initialRoute: AppRoutes.home,
                builder: (context, child) {
                  return AppColorsProvider(
                    appColors: AppColors.instance,
                    child: child!,
                  );
                },
                onGenerateRoute: AppRouteGenerator.generateRoute,
              );
            }),
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
    await WorkManagerService.init();
  }
}

/// Initializes some UI configurations before running the app.
/// It does the following:
/// 1. Preserves the splash screen until the app is fully initialized.
/// 2. Sets the preferred orientations for the app.
/// 3. Sets the [BlocObserver] for the app.

Future<void> initUiConfigs() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Bloc.observer = MyBlocObserver();
}
