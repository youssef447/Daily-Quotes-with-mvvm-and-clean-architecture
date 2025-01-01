import 'package:dailyquotes/core/theme/app_colors.dart';
import 'package:dailyquotes/core/Widgets/dialogs/default_alert_dialog.dart';
import 'package:dailyquotes/core/theme/app_text_styles.dart';
import 'package:dailyquotes/core/theme/text/app_font_weights.dart';
import 'package:dailyquotes/core/utils/globales.dart';

import 'package:dailyquotes/features/home_page/presentation/controller/home_cubit.dart';
import 'package:dailyquotes/features/home_page/presentation/controller/home_states.dart';
import 'package:dailyquotes/core/Widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/Widgets/dialogs/default_awesome_dialog.dart';
import '../../../../../core/Widgets/loading/default_loading_indicator.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../core/enums/card_shape.dart';
import '../../../../../core/helpers/spacing_helper.dart';

part '../widgets/customTabs.dart';
part '../widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => HomeCubit()..getNotificationShapeCaches(),
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
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    CustomAppbar(
                        cubit: cubit,
                        longRectOnTap: () {
                          cubit.changeShape(CardShape.rectangle);
                        },
                        longColor: cubit.cardShape == CardShape.rectangle
                            ? AppColors.selectedItemColor
                            : Colors.white,
                        squareOnTap: () {
                          cubit.changeShape(CardShape.square);
                        },
                        squareColor: cubit.cardShape == CardShape.square
                            ? AppColors.selectedItemColor
                            : Colors.white),
                    const CustomTabs(),
                    Expanded(
                      child: cubit.getCurrentTab(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
