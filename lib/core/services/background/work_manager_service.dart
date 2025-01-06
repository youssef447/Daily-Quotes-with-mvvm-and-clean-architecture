import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dailyquotes/core/constants/api_constants.dart';
import 'package:dailyquotes/core/services/Network/local/cach_helper.dart';
import 'package:dailyquotes/core/services/Network/remote/dio_helper.dart';
import 'package:dailyquotes/data/repositories/quote_repo.dart';
import 'package:flutter/material.dart';
import '../../../data/data_sources/quote_local_service.dart';
import '../../../data/data_sources/quote_remote_service.dart';
import '../notifications/awesome_notification_service.dart';
import 'package:workmanager/workmanager.dart';

abstract class WorkManagerService {
  ///init work manager service
  static Future<void> init() async {
    await Workmanager().initialize(
      actionTasks,
      isInDebugMode: false,
    );
    registerMyTask();
  }

  static void registerMyTask() async {
    if (DateTime.now().hour == 8 &&
        DateTime.now().minute == 0 &&
        DateTime.now().second == 0) {
      await Workmanager().registerOneOffTask(
        'UNIQUE1',
        'show simple notification',
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
      );
      //add more
    }
  }

  static void cancelTasks() {
    Workmanager().cancelAll();
  }

  static void cancelTaskByID(String id) {
    Workmanager().cancelByUniqueName(id);
  }
}

@pragma('vm-entry-point')
void actionTasks() async {
  //show notification
  WidgetsFlutterBinding.ensureInitialized();
  String? quote;

  DioHelper.init(baseUrl: ApiConstants.baseUrl);
  await CacheHelper.init();
  final repo = QuoteRepo(
    remoteService: QuoteRemoteService(),
    localService: QuoteLocalService(),
  );
  final res = await repo.reqTodayQuote();

  if (res.isError) {
    //indicating that the task has failed to request new quote from repo when user opens the app
    await CacheHelper.saveData(key: 'success', value: false);
    return;
  }
  quote = res.data!.quote;

  try {
    Workmanager().executeTask(
      (taskName, inputData) async {
        await AwesomeNotificationService().showNotification(
          payload: {
            'type': 'share',
            'quote': quote!,
            'author': res.data!.author,
          },
          title: 'Today\'s Quote',
          body: quote,
          actionButtons: [
            NotificationActionButton(
              key: 'Share',
              label: 'Share Now',
            ),
          ],
        );
        await CacheHelper.saveData(key: 'success', value: true);
        return Future.value(true);
      },
    );
  } catch (e) {
    //indicating that the task has failed to request new quote from repo when user opens the app
    await CacheHelper.saveData(key: 'success', value: false);
  }
}
