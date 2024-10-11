import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EditMedicineScreen extends StatefulWidget {
  final DocumentSnapshot medicine;

  const EditMedicineScreen({required this.medicine});

  @override
  _EditMedicineScreenState createState() => _EditMedicineScreenState();
}

class _EditMedicineScreenState extends State<EditMedicineScreen> {
  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  TimeOfDay? selectedTime;
  String selectedMedicineType = '';

  @override
  void initState() {
    super.initState();
    medicineNameController.text = widget.medicine['medicine_name'] ?? '';
    dosageController.text = widget.medicine['dosage'] ?? '';
    selectedMedicineType = widget.medicine['medicine_type'] ?? '';

    try {
      String reminderTime = widget.medicine['reminder_time'] ?? '';
      if (reminderTime.isNotEmpty) {
        final format = DateFormat.jm(); // Handles 12-hour format with AM/PM
        final time = format.parse(reminderTime);
        selectedTime = TimeOfDay.fromDateTime(time);
      } else {
        selectedTime = TimeOfDay.now();
      }
    } catch (e) {
      print('Error parsing reminder_time: $e');
      selectedTime = TimeOfDay.now();
    }
  }

  Future<void> _updateMedicine() async {
    await FirebaseFirestore.instance
        .collection('medicines')
        .doc(widget.medicine.id)
        .update({
      'medicine_name': medicineNameController.text,
      'dosage': dosageController.text,
      'medicine_type': selectedMedicineType,
      'reminder_time': selectedTime!.format(context),
    });

    Navigator.of(context).pop(); // Close the dialog after saving
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  void dispose() {
    medicineNameController.dispose();
    dosageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Edit Medicine',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          SizedBox(height: 16),

          // Medicine name input field
          TextField(
            controller: medicineNameController,
            decoration: InputDecoration(
              labelText: 'Medicine Name',
              labelStyle: TextStyle(fontSize: 14, color: Colors.grey[700]),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 12),

          // Dosage input field
          TextField(
            controller: dosageController,
            decoration: InputDecoration(
              labelText: 'Dosage',
              labelStyle: TextStyle(fontSize: 14, color: Colors.grey[700]),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 12),

          // Reminder time selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reminder Time:',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              TextButton(
                onPressed: () => _selectTime(context),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  backgroundColor: Colors.blueAccent,
                  minimumSize: Size(60, 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  selectedTime != null
                      ? selectedTime!.format(context)
                      : 'Select Time',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Save button
          Center(
            child: ElevatedButton(
              onPressed: _updateMedicine,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                backgroundColor: Colors.blueAccent,
                minimumSize: Size(80, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
