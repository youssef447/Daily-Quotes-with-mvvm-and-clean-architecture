import 'package:dailyquotes/core/utils/appColors.dart';
import 'package:dailyquotes/core/utils/defaultDialog.dart';
import 'package:dailyquotes/core/utils/globales.dart';
import 'package:dailyquotes/view-model/TabsCubit/popularCubit.dart';
import 'package:dailyquotes/view-model/TabsCubit/randomCubit.dart';
import 'package:dailyquotes/view-model/TabsCubit/todayCubit.dart';
import 'package:dailyquotes/view-model/homeCubit.dart';
import 'package:dailyquotes/view-model/homeStates.dart';
import 'package:dailyquotes/view/errorScreen.dart';
import 'package:dailyquotes/view/tabs/myQuotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/defaultAwesomeDialog.dart';
import '../../view-model/TabsCubit/myQuotesCubit.dart';
import '../tabs/popularScreen.dart';
import '../tabs/randomScreen.dart';
import '../tabs/todayScreen.dart';
part 'customTabs.dart';
part 'customAppBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeCubit()..getNotificationShapeCaches(),
            ),
            BlocProvider(
              create: (context) => TodayCubit()..getTodayQuote(),
            ),
            BlocProvider(
              create: (context) => PopularCubit()..getPopularQuotes(),
            ),
            BlocProvider(
              create: (context) => RandomCubit(),
            ),
            BlocProvider(
              create: (context) => MyQuotesCubit()..getMyQuotes(),
            ),
          ],
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
                TodayScreen(longRectangle: cubit.longRectangle),
                PopularScreen(longRectangle: cubit.longRectangle),
                RandomScreen(longRectangle: cubit.longRectangle),
                MyQuotes(longRectangle: cubit.longRectangle),
              ];

              return state is GetShapeLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : state is GetShapeErrorState
                      ? ErrorScreen(
                          errMsg: state.err,
                          retry: () async {
                            await cubit.getNotificationShapeCaches();
                          })
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              CustomAppBar(
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
                              CustomTabs(
                                todayOnTap: () {
                                  cubit.changeTab(0);
                                },
                                todayColor: cubit.currentTabIndex == 0
                                    ? AppColors.selectedItemColor
                                    : AppColors.unselectedItemColor,
                                popularOnTap: () {
                                  cubit.changeTab(1);
                                },
                                popularColor: cubit.currentTabIndex == 1
                                    ? AppColors.selectedItemColor
                                    : AppColors.unselectedItemColor,
                                randomOnTap: () {
                                  cubit.changeTab(2);
                                },
                                randomColor: cubit.currentTabIndex == 2
                                    ? AppColors.selectedItemColor
                                    : AppColors.unselectedItemColor,
                                myQuotesOnTap: () {
                                  cubit.changeTab(3);
                                },
                                myQuotesColor: cubit.currentTabIndex == 3
                                    ? AppColors.selectedItemColor
                                    : AppColors.unselectedItemColor,
                              ),
                              Expanded(
                                child: tabs[cubit.currentTabIndex],
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
