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
    await registerMyTask();
  }

  static Future<void> registerMyTask() async {
    await Workmanager().registerPeriodicTask(
      'today_quote',
      'notification_task',
      constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresDeviceIdle: false,
          requiresStorageNotLow: false),
    );
  }

  static Future<void> cancelTasks() async {
    await Workmanager().cancelAll();
  }

  static Future<void> cancelTaskByID({required String uniqueName}) async {
    await Workmanager().cancelByUniqueName(uniqueName);
  }
}

@pragma('vm-entry-point')
void actionTasks() async {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      //show notification
      WidgetsFlutterBinding.ensureInitialized();
      await CacheHelper.init();
      DateTime? cachedDate;

      if (CacheHelper.containsKey('cached_date')) {
        cachedDate =
            DateTime.parse(await CacheHelper.getData(key: 'cached_date'));
      }

      if (DateTime.now().hour == 8 && DateTime.now().day != cachedDate?.day) {
        String? quote;
        DioHelper.init(baseUrl: ApiConstants.baseUrl);

        final repo = QuoteRepo(
          remoteService: QuoteRemoteService(),
          localService: QuoteLocalService(),
        );
        final res = await repo.reqTodayQuote();

        if (res.isError) {
          //indicating that the task has failed to request new quote from repo when user opens the app
          await CacheHelper.saveData(key: 'success', value: false);
        } else {
          await repo.cacheTodayQuote(res.data!);
          quote = res.data!.quote;
          await CacheHelper.saveData(key: 'success', value: true);
          await CacheHelper.saveData(
              key: 'cached_date', value: DateTime.now().toString());
        }
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
      }
      return Future.value(true);
    } catch (e) {
      //indicating that the task has failed to request new quote from repo when user opens the app
      await CacheHelper.saveData(key: 'success', value: false);
      return Future.value(false);
    }
  });
}
