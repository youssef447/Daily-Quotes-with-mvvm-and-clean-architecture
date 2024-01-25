/* import 'dart:async';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final LocalNotificationService _localNotificationService =
      LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _localNotificationService;
  }

  LocalNotificationService._internal();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('icon');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      //  onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (notificationResponse) {},
    );
  }

  NotificationDetails notificationDetails() {
    const String channelId = 'channelId';
    const String channelName = 'channelName';

    return const NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        playSound: true,
        sound: UriAndroidNotificationSound('notification'),
      ),
      iOS: DarwinNotificationDetails(
        sound: 'notification',
        presentSound: true,
      ),
    );
  }

  Future<void> secduleTime({
    required int id,
    required DateTime secduleDateTime,
    String? title,
    String? body,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        secduleDateTime,
        tz.local,
      ),
      notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) async {
    //Handle notification tapped logic here
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }
}
 */