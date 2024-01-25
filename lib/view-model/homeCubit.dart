import 'package:dailyquotes/model/services/Network/local/awesomeNotificationService.dart';
import 'package:dailyquotes/model/services/Network/local/cach_helper.dart';
import 'package:dailyquotes/view-model/homeStates.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/Di/injection.dart';
import '../core/utils/globales.dart';

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

  int currentTabIndex = 0;

  changeTab(int index) {
    currentTabIndex = index;
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
