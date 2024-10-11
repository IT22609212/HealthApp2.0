import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MedicineDetailScreen extends StatelessWidget {
  final DocumentSnapshot medicine;

  const MedicineDetailScreen({Key? key, required this.medicine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine['medicine_name']),
        backgroundColor: const Color(0xFF377DE6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dosage: ${medicine['dosage']}',
                style: const TextStyle(fontSize: 18)),
            Text('Medicine Type: ${medicine['medicine_type']}',
                style: const TextStyle(fontSize: 18)),
            Text('Reminder Time: ${medicine['reminder_time']}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
