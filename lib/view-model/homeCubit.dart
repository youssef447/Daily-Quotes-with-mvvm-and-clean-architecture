import 'package:dailyquotes/view-model/homeStates.dart';
import 'package:dailyquotes/view/tabs/popularScreen.dart';
import 'package:dailyquotes/view/tabs/randomScreen.dart';
import 'package:dailyquotes/view/tabs/todayScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentTabIndex = 0;
  final List<Widget> tabs = [
   const TodayScreen(),
  const  PopularScreen(),
   const RandomScreen(),
  ];
  changeTab(int index) {
    currentTabIndex = index;
    emit(ChangeTabState());
  }
}
