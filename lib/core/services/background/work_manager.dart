import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dailyquotes/core/services/Network/local/cach_helper.dart';
import 'package:dailyquotes/data/repositories/quote_repo.dart';
import '../../../data/data_sources/quote_local_service.dart';
import '../../../data/data_sources/quote_remote_service.dart';
import '../notifications/awesome_notification_service.dart';
import 'package:workmanager/workmanager.dart';

abstract class WorkManagerService {
  static void registerMyTask() async {
    //register my task
    /*   await Workmanager().registerPeriodicTask(
      'id1',
      'show simple notification',
      frequency: const Duration(minutes: 15),
    ); */

    // if (DateTime.now().hour == 8 && DateTime.now().minute == 0) {
    await Workmanager().registerOneOffTask(
      'id1',
      'show simple notification',
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
    //  }
  }

  //init work manager service
  static Future<void> init() async {
    await Workmanager().initialize(
      actionTask,
      isInDebugMode: false,
    );
    registerMyTask();
  }

  static void cancelTask(String id) {
    Workmanager().cancelAll();
  }
}

@pragma('vm-entry-point')
void actionTask() async {
  //show notification

  String? quote;

  final res = await QuoteRepo(
    remoteService: QuoteRemoteService(),
    localService: QuoteLocalService(),
  ).reqTodayQuote();
  if (res.isError) {
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
    // return Future.value(true);
  }
}
