import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void alarmCallbackBackground() async {
  // Background isolate: initialize a local plugin instance.
  final FlutterLocalNotificationsPlugin backgroundPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await backgroundPlugin.initialize(settings: initializationSettings);

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'alarm_channel_id',
    'Critical Alarms',
    channelDescription: 'Used for full-screen alarm overlay windows',
    importance: Importance.max,
    priority: Priority.high,
    fullScreenIntent: true,
    playSound: true,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await backgroundPlugin.show(
    id: 0,
    title: 'Alarm Ringing',
    body: 'Tap to view and dismiss',
    notificationDetails: platformChannelSpecifics,
  );
}
