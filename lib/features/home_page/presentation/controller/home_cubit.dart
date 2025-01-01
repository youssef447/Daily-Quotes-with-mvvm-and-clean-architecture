import 'package:dailyquotes/features/home_page/presentation/controller/home_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/services/Network/local/cach_helper.dart';
import '../../../../core/services/notifications/awesome_notification_service.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  late bool longRectangle;

  getNotificationShapeCaches() async {
    emit(GetShapeLoadingState());
    try {
      longRectangle = CacheHelper.getData(key: 'Long') ?? false;

      emit(GetShapeSuccessState());
    } catch (e) {
      emit(GetShapeErrorState(e.toString()));
    }
  }

  changeShape(bool val) async {
    await CacheHelper.saveData(key: 'Long', value: val);
    longRectangle = val;
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
  myquotes,
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
      case QuoteTab.myquotes:
        return 'My Quotes';
    }
  }
}
