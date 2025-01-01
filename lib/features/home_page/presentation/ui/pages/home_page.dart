import 'package:dailyquotes/core/theme/app_colors.dart';
import 'package:dailyquotes/core/Widgets/dialogs/default_alert_dialog.dart';
import 'package:dailyquotes/core/utils/utils.dart';

import 'package:dailyquotes/features/home_page/presentation/controller/home_cubit.dart';
import 'package:dailyquotes/features/home_page/presentation/controller/home_states.dart';
import 'package:dailyquotes/core/Widgets/error_page.dart';
import 'package:dailyquotes/features/my_quotes_page/presentation/ui/pages/my_quotes_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/Widgets/dialogs/default_awesome_dialog.dart';
import '../../../../../core/Widgets/loading/default_loading_indicator.dart';

import '../../../../popular_quotes_page/presentation/ui/pages/popular_quotes_page.dart';
import '../../../../random_quote_page/presentation/ui/pages/random_quote_page.dart';
import '../../../../today_quote_page/presentation/ui/pages/today_quote_page.dart';

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
              var cubit = HomeCubit.get(context);
              final List<Widget> tabs = [
                TodayQuotePage(longRectangle: cubit.longRectangle),
                PopularScreen(longRectangle: cubit.longRectangle),
                RandomScreen(longRectangle: cubit.longRectangle),
                MyQuotes(longRectangle: cubit.longRectangle),
              ];

              return state is GetShapeLoadingState
                  ? const DefaultLoadingIndicator()
                  : state is GetShapeErrorState
                      ? ErrorPage(
                          errMsg: state.err,
                          retry: () async {
                            await cubit.getNotificationShapeCaches();
                          })
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              CustomAppbar(
                                cubit: cubit,
                                longRectOnTap: () {
                                  cubit.changeShape(true);
                                },
                                longColor: cubit.longRectangle
                                    ? AppColors.selectedItemColor
                                    : Colors.white,
                                squareOnTap: () {
                                  cubit.changeShape(false);
                                },
                                squareColor: cubit.longRectangle
                                    ? Colors.white
                                    : AppColors.selectedItemColor,
                              ),
                              const CustomTabs(),
                              Expanded(
                                child: tabs[cubit.currentTab.index],
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
