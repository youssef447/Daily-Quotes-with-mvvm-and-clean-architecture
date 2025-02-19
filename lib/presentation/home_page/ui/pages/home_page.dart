import 'package:dailyquotes/core/extensions/context_extension.dart';

import 'package:dailyquotes/core/widgets/dialogs/default_alert_dialog.dart';
import 'package:dailyquotes/core/theme/text/app_text_styles.dart';
import 'package:dailyquotes/core/theme/text/app_font_weights.dart';
import 'package:dailyquotes/core/utils/globales.dart';

import 'package:dailyquotes/core/widgets/error_page.dart';
import 'package:dailyquotes/main.dart';
import 'package:dailyquotes/presentation/home_page/controller/home_cubit.dart';
import 'package:dailyquotes/presentation/home_page/controller/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:dailyquotes/core/routes/app_routes.dart';
import 'package:dailyquotes/core/widgets/dialogs/default_awesome_dialog.dart';
import 'package:dailyquotes/core/widgets/loading/default_loading_indicator.dart';

import 'package:dailyquotes/core/constants/assets.dart';
import 'package:dailyquotes/core/enums/card_shape.dart';
import 'package:dailyquotes/core/helpers/spacing_helper.dart';

part '../widgets/home_tabs.dart';
part '../widgets/home_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsProvider.of(context).appColors.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is ChangeNotificationErrorState) {
              AwesomeDialogUtil.error(
                context: context,
                body: 'Error Adjusting Notification, ${state.err}',
                title: 'Failed',
              );
            }
            if (state is ChangeNotificationSuccessState) {
              Navigator.of(context).pop();
              AwesomeDialogUtil.sucess(
                context: context,
                body: noitificationsEnabled
                    ? 'Notifications are now Enabled !'
                    : 'Notifications are now Disabled !',
                title: 'Done',
              );
            }
          },
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();

            if (state is GetShapeLoadingState) {
              return const DefaultLoadingIndicator();
            }

            if (state is GetShapeErrorState) {
              return ErrorPage(
                  errMsg: state.err,
                  retry: () async {
                    await cubit.getNotificationShapeCaches();
                  });
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                children: [
                  HomeAppbar(
                      cubit: cubit,
                      longRectOnTap: () {
                        cubit.changeShape(CardShape.rectangle);
                      },
                      longColor: cubit.cardShape == CardShape.rectangle
                          ? AppColorsProvider.of(context).appColors.primary
                          : AppColorsProvider.of(context).appColors.textBG,
                      squareOnTap: () {
                        cubit.changeShape(CardShape.square);
                      },
                      squareColor: cubit.cardShape == CardShape.square
                          ? AppColorsProvider.of(context).appColors.primary
                          : AppColorsProvider.of(context).appColors.textBG),
                  const HomeTabs(),
                  verticalSpace(12),
                  Expanded(
                    child: cubit.getCurrentTab(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
