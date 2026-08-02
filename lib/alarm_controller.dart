import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:alarm_app/alarm_background.dart';

// Global instance for triggering notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AlarmController extends GetxController {
  final titleController = TextEditingController();
  
  // Observable variable to store and update selected time reactively
  var selectedTime = const TimeOfDay(hour: 0, minute: 0).obs;

  // Function to show Flutter built-in time picker
  void pickTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      selectedTime.value = time;
    }
  }

  // Function to schedule the alarm based on user inputs
  void setAlarm() async {
    final now = DateTime.now();
    var alarmDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.value.hour,
      selectedTime.value.minute,
    );

    // If the chosen time has already passed today, set it for tomorrow
    if (alarmDateTime.isBefore(now)) {
      alarmDateTime = alarmDateTime.add(const Duration(days: 1));
    }

    debugPrint("Scheduling alarm at: $alarmDateTime");

    // Registering the exact alarm to the Android system OS
    await AndroidAlarmManager.oneShotAt(
      alarmDateTime,
      0, // Unique ID for this specific alarm
      alarmCallbackBackground, // Top-level function to trigger when time arrives
      exact: true, // Ensures high precision timing
      wakeup: true, // Forces screen wake up if phone is locked
    );

    // Show a quick success feedback message
    Get.snackbar(
      'Alarm Set', 
      'Set successfully for ${selectedTime.value.format(Get.context!)}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}

// =========================================================================
// CRITICAL: Top-level background callback function (Must reside outside any class)
// =========================================================================
@pragma('vm:entry-point')
void alarmCallback() async {
  debugPrint("!!! ALARM CALLBACK TRIGGERED FROM OS !!!");
  
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'alarm_channel_id',
    'Critical Alarms',
    channelDescription: 'Used for full-screen alarm overlay windows',
    importance: Importance.max,
    priority: Priority.high,
    fullScreenIntent: true, // Key property to trigger full screen behavior
    playSound: true,
  );
  
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Corrected naming parameters for latest flutter_local_notifications plugin
  await flutterLocalNotificationsPlugin.show(
    id: 0,
    title: 'Alarm Ringing',
    body: 'Tap to view and dismiss',
    notificationDetails: platformChannelSpecifics,
  );

  // If the app is active in the background or foreground, immediately push the full-screen view
  if (Get.context != null) {
    debugPrint("Context found, redirecting directly to alarm screen.");
    Get.toNamed('/alarm_screen');
  }
}