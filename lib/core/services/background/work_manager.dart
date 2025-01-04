import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dailyquotes/data/repositories/quote_repo.dart';
import '../../../data/data_sources/quote_local_service.dart';
import '../../../data/data_sources/quote_remote_service.dart';
import '../../theme/colors/app_colors.dart';
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
    if (DateTime.now().hour == 20 /* && DateTime.now().minute == 58 */) {
      print('sakaaa');
      await Workmanager().registerOneOffTask(
        'id1',
        'show simple notification',
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
      );
    }
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

  Workmanager().executeTask(
    (taskName, inputData) {
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
            color: AppColors.primary,
          ),
        ],
      );

      return Future.value(true);
    },
  );
}
