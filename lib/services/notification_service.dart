import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize plugin
  Future<void> initializeNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  // Schedule notification
  Future<void> scheduleNotification(String medicineName, TimeOfDay time) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      Random().nextInt(10000), // Unique notification ID
      'Medicine Reminder',
      'It\'s time to take your $medicineName',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'medicine_channel',
          'Medication Reminder',
          channelDescription: 'This channel is used for medicine reminders.',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Trigger every day at the same time
    );
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
