import 'package:dailyquotes/presentation/home_page/presentation/controller/home_states.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/enums/card_shape.dart';
import '../../../../core/utils/globales.dart';
import '../../../../core/services/Network/local/cach_helper.dart';
import '../../../../core/services/notifications/awesome_notification_service.dart';
import '../../../my_quotes_page/presentation/ui/pages/my_quotes_page.dart';
import '../../../popular_quotes_page/presentation/ui/pages/popular_quotes_page.dart';
import '../../../random_quote_page/presentation/ui/pages/random_quote_page.dart';
import '../../../today_quote_page/presentation/ui/pages/today_quote_page.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  Widget getCurrentTab() {
    switch (currentTab) {
      case QuoteTab.today:
        return TodayQuotePage();
      case QuoteTab.popular:
        return PopularQuotesPage();
      case QuoteTab.random:
        return RandomQuotePage();
      case QuoteTab.MyQuotesPage:
        return MyQuotesPage();
    }
  }

  late CardShape cardShape;

  getNotificationShapeCaches() async {
    emit(GetShapeLoadingState());
    try {
      cardShape = (CacheHelper.getData(key: 'square') as bool?) ?? false
          ? CardShape.square
          : CardShape.rectangle;

      emit(GetShapeSuccessState());
    } catch (e) {
      emit(GetShapeErrorState(e.toString()));
    }
  }

  changeShape(CardShape val) async {
    await CacheHelper.saveData(key: 'square', value: val == CardShape.square);
    cardShape = val;
    emit(ChangeShapeState());
  }

  QuoteTab currentTab = QuoteTab.today;

  changeTab(QuoteTab tab) {
    currentTab = tab;
    emit(ChangeTabState());
  }

  changeNotification() {
    emit(ChangeNotificationLoadingState());
    if (noitificationsEnabled == true) {
      locators
          .get<AwesomeNotificationService>()
          .cancelNotificatons()
          .then((value) {
        noitificationsEnabled = false;
        emit(ChangeNotificationSuccessState());
      }).catchError((onError) {
        emit(ChangeNotificationErrorState(onError.toString()));
      });
    } else {
      locators.get<AwesomeNotificationService>().init().then(
        (value) async {
          await CacheHelper.saveData(key: 'notifications', value: true);

          noitificationsEnabled = true;
          emit(ChangeNotificationSuccessState());
        },
      ).catchError((onError) {
        emit(ChangeNotificationErrorState(onError.toString()));
      });
    }
  }
}

enum QuoteTab {
  today,
  popular,
  random,
  MyQuotesPage,
}

extension QuoteTabExtension on QuoteTab {
  String get getName {
    switch (this) {
      case QuoteTab.today:
        return 'Today';
      case QuoteTab.popular:
        return 'Popular';
      case QuoteTab.random:
        return 'Random';
      case QuoteTab.MyQuotesPage:
        return 'My Quotes';
    }
  }
}
