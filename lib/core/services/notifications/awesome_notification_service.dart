import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:share_plus/share_plus.dart';

import '../../utils/globales.dart';
import '../Network/local/cach_helper.dart';

class AwesomeNotificationService {
  final AwesomeNotifications _service;
  AwesomeNotificationService() : _service = AwesomeNotifications();

  List<NotificationChannel> channels = [
    NotificationChannel(
      channelKey: 'custom sound notifications',
      channelName: 'today quote channel',
      channelDescription: 'Notification channel for basic tests',
      playSound: true,
      soundSource: 'resource://raw/notification',
      importance: NotificationImportance.Max,
      defaultPrivacy: NotificationPrivacy.Public,
      channelShowBadge: true,
    ),
  ];
  Future<void> init() async {
    bool isAllowed = await checkPermission();
    if (isAllowed) {
      await _service.initialize(
        null, // 'res://drawable/icon',
        channels,
        debug: true,
      );

      await setListeners();
    }
  }

  Future<bool> checkPermission() async {
    bool isAllowed = await _service.isNotificationAllowed();

    if (!isAllowed) {
      isAllowed = await _service.requestPermissionToSendNotifications();
      if (!isAllowed) {
        CacheHelper.saveData(key: 'notifications', value: false);
      }
    }
    return isAllowed;
  }

  @pragma('vm-entry-point')
  setListeners() async {
    await _service.setListeners(

        /// Use this method to detect when a new notification or a schedule is created

        onNotificationCreatedMethod: (receivedNotification) async {},

        /// Use this method to detect every time that a new notification is displayed

        onNotificationDisplayedMethod: (receivedNotification) async {},

        /// Use this method to detect when the user taps on a notification or action button

        onActionReceivedMethod: _onActionReceivedMethod,

        /// Use this method to detect if the user dismissed a notification

        onDismissActionReceivedMethod: (receivedAction) async {});
  }

  Future<void> cancelNotificatons() async {
    await _service.cancelAll();
    await CacheHelper.saveData(key: 'notifications', value: false);
  }

  Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
  }) async {
    await _service.createNotification(
      content: NotificationContent(
        id: 21,
        channelKey: 'custom sound notifications',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
        criticalAlert: true,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationCalendar(
              hour: 00,
              minute: 00,
              timeZone:
                  await _service.getLocalTimeZoneIdentifier() //America/New_York
              )
          : null,
    );
  }
}

@pragma('vm-entry-point')
Future<void> _onActionReceivedMethod(receivedAction) async {
  if (receivedAction.payload != null &&
      receivedAction.payload!['type'] == 'share') {
    await Share.share(
      '“${receivedAction.payload!['quote']}”\n\n- ${receivedAction.payload!['author']}\n\n\n $sharingMyGit',
    );
  }
  /*  if (navigatorKey.currentState != null) {
            navigatorKey.currentState!
                .push(MaterialPageRoute(builder: (_) => TestScreen()));
          } */
}
