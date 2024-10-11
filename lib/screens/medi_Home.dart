import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_first_app/screens/AddMedicine.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/screens/edit_medicine_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class MediHome extends StatefulWidget {
  MediHome({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MediHome> {
  final String appName = 'My Medicine App';
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  // Initialize the notification settings
  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones(); // Initialize time zones
  }

  // Function to schedule notification
  Future<void> scheduleNotification(
      String medicineName, TimeOfDay reminderTime) async {
    debugPrint('Scheduling notification for $medicineName at $reminderTime');
    try {
      // Convert TimeOfDay to DateTime
      final now = DateTime.now();
      DateTime scheduledTime = DateTime(
          now.year, now.month, now.day, reminderTime.hour, reminderTime.minute);

      // If the time has already passed today, schedule for tomorrow
      if (scheduledTime.isBefore(now)) {
        scheduledTime = scheduledTime.add(const Duration(days: 1));
      }

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'medicine_reminders_channel',
        'Medicine Reminders',
        channelDescription: 'Channel for medicine reminder notifications',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0, // Unique ID
        'Medication Reminder',
        'Time to take your medicine: $medicineName',
        tz.TZDateTime.from(scheduledTime, tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      // Handle any scheduling errors
      debugPrint('Error scheduling notification: $e');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MyHomePage(
      title: "Medication Reminder",
      scheduleNotification: scheduleNotification,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final Future<void> Function(String, TimeOfDay) scheduleNotification;

  const MyHomePage(
      {Key? key, required this.title, required this.scheduleNotification})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.white), // Change text color to white
        ),
        backgroundColor: const Color.fromARGB(255, 32, 107, 219),
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Colors.white), // Change button color to white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                'lib/assets/images/home.png',
                width: 665,
                height: 280,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16.0),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('medicines')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Column(
                    children: [
                      SizedBox(height: 8.0),
                      Text('Total Reminders: 0',
                          style: TextStyle(color: Colors.black)),
                      SizedBox(height: 8.0),
                      Center(child: Text('No reminders found')),
                    ],
                  );
                }

                final medicines = snapshot.data!.docs;

                return Column(
                  children: [
                    Text(
                      'Total Reminders: ${medicines.length}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: medicines.length,
                      itemBuilder: (context, index) {
                        final medicine = medicines[index];
                        final medicineType = medicine['medicine_type'];

                        IconData medicineIcon =
                            getIconForMedicineType(medicineType);
                        return Stack(
                          children: [
                            Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 4),
                                    Icon(medicineIcon,
                                        size: 50.0,
                                        color: const Color.fromRGBO(
                                            32, 107, 219, 1)),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      medicine['medicine_name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.access_time,
                                          size: 18.0,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          '${medicine['reminder_time']}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              size: 20.0,
                                              color: Color.fromARGB(
                                                  255, 43, 121, 33)),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: EditMedicineScreen(
                                                    medicine: medicine),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 26,
                              right: 8,
                              child: IconButton(
                                icon: const Icon(Icons.delete,
                                    size: 16.0,
                                    color: Color.fromARGB(255, 179, 57, 57)),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('medicines')
                                      .doc(medicine.id)
                                      .delete();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Medicine deleted successfully')),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final medicine = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddMedicine()),
          );

          // Schedule notification for the new medicine if it's added
          if (medicine != null) {
            await widget.scheduleNotification(
                medicine['medicine_name'], medicine['reminder_time']);
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromRGBO(32, 107, 219, 1),
      ),
    );
  }

  IconData getIconForMedicineType(String medicineType) {
    switch (medicineType) {
      case 'Tablets':
        return FontAwesomeIcons.tablets;
      case 'Capsules':
        return FontAwesomeIcons.capsules;
      case 'Syrup':
        return FontAwesomeIcons.wineBottle;
      case 'Injection':
        return FontAwesomeIcons.syringe;
      default:
        return Icons.medication; // Default icon
    }
  }
}
