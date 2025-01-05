import 'package:dailyquotes/core/routes/page_transition.dart';
import 'package:dailyquotes/presentation/home_page/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../../presentation/custom_color_theme/ui/pages/color_picker_page.dart';
import '../theme/colors/app_colors.dart';
import 'app_routes.dart';

abstract class AppRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Get arguments and route name
    // final args = settings.arguments as Map<String, dynamic>? ?? {};
    final routeName = settings.name;

    // Define your routes with corresponding transitions
    switch (routeName) {
      case AppRoutes.home:
        return PageTransitionHelper.buildPageRoute(
          const HomePage(),
          PageTransitionType.fade,
        );

      case AppRoutes.customColorTheme:
        return PageTransitionHelper.buildPageRoute(
          const ColorPickerPage(),
          PageTransitionType.diagonalWithScale,
          duration: const Duration(milliseconds: 700),
        );

      default:
        return PageTransitionHelper.buildPageRoute(
          Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
                child: Center(child: Text('No route defined for $routeName'))),
          ),
          PageTransitionType.fade,
        );
    }
  }
}
