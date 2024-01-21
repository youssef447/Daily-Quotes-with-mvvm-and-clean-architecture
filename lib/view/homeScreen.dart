import 'package:dailyquotes/core/utils/appColors.dart';
import 'package:dailyquotes/view-model/TabsCubit/popularCubit.dart';
import 'package:dailyquotes/view-model/TabsCubit/randomCubit.dart';
import 'package:dailyquotes/view-model/TabsCubit/todayCubit.dart';
import 'package:dailyquotes/view-model/homeCubit.dart';
import 'package:dailyquotes/view-model/homeStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotez'),
        actions: const [
          Icon(
            Icons.space_dashboard_rounded,
          ),
          Icon(Icons.square),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(),
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
        ],
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        overlayColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                        onTap: () {
                          cubit.changeTab(0);
                        },
                        child: Text(
                          'Today',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: cubit.currentTabIndex == 0
                                        ? AppColors.selectedItemColor
                                        : AppColors.unselectedItemColor,
                                  ),
                        ),
                      ),
                      InkWell(
                        overlayColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        onTap: () {
                          cubit.changeTab(1);
                        },
                        child: Text(
                          'Popular',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: cubit.currentTabIndex == 1
                                        ? AppColors.selectedItemColor
                                        : AppColors.unselectedItemColor,
                                  ),
                        ),
                      ),
                      InkWell(
                        overlayColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        onTap: () {
                          cubit.changeTab(2);
                        },
                        child: Text(
                          'Random',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: cubit.currentTabIndex == 2
                                        ? AppColors.selectedItemColor
                                        : AppColors.unselectedItemColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: cubit.tabs[cubit.currentTabIndex],
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
