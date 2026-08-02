import 'package:alarm_app/alarm_home_screen.dart';
import 'package:alarm_app/alarm_triggered_screen.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

// Global instance for triggering notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Start the background Android Alarm service
  await AndroidAlarmManager.initialize();

  // Setup notification configurations for Android
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    settings: initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // This is triggered when the user taps on the notification
      // Redirect to the Full Screen Alarm view using GetX
      debugPrint('Notification tapped with id: ${response.id}');
      Get.toNamed('/alarm_screen');
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Alarm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: AlarmHomeScreen(),
      getPages: [
        GetPage(name: '/alarm_screen', page: () => AlarmTriggeredScreen()),
      ],
    );
  }
}