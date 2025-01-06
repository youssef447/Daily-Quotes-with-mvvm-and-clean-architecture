import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dailyquotes/core/services/Network/local/cach_helper.dart';
import 'package:dailyquotes/data/repositories/quote_repo.dart';
import '../../../data/data_sources/quote_local_service.dart';
import '../../../data/data_sources/quote_remote_service.dart';
import '../notifications/awesome_notification_service.dart';
import 'package:workmanager/workmanager.dart';

abstract class WorkManagerService {
  ///init work manager service
  static Future<void> init() async {
    await Workmanager().initialize(
      todayQuoteNotification,
      isInDebugMode: false,
    );
    registerMyTask();
  }

  static void registerMyTask() async {
    // if (DateTime.now().hour == 8 && DateTime.now().minute == 0) {
    await Workmanager().registerOneOffTask(
      'UNIQUE1',
      'show simple notification',
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  static void cancelTasks() {
    Workmanager().cancelAll();
  }

  static void cancelTaskByID(String id) {
    Workmanager().cancelByUniqueName(id);
  }
}

@pragma('vm-entry-point')
void todayQuoteNotification() async {
  //show notification

  String? quote;
  print('a7aaaaaaaa');

  final repo = QuoteRepo(
    remoteService: QuoteRemoteService(),
    localService: QuoteLocalService(),
  );
  final res = await repo.reqTodayQuote();
  print('a7aaaaaaaa ${res.data?.quote}');
  if (res.isError) {
    //indicating that the task has failed to request new quote from repo when user opens the app
    await CacheHelper.saveData(key: 'success', value: false);
    return;
  }
  quote = res.data!.quote;

  try {
    Workmanager().executeTask(
      (taskName, inputData) async {
        AwesomeNotificationService().showNotification(
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
    print('a7a $e');
    // return Future.value(true);
  }
}
