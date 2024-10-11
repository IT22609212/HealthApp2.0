import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/screens/medi_Home.dart';
import 'package:my_first_app/services/medicine_service.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final MedicineService medicineService = MedicineService();

  void dispose() {
    medicineService.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.grey[900]!,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.black,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != medicineService.selectedTime) {
      setState(() {
        medicineService.selectedTime = picked;
      });
    }
  }

  void _selectMedicineType(String type) {
    setState(() {
      medicineService.selectedMedicineType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Medicine'),
        backgroundColor: const Color(0xFF377DE6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Medicine Name:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: medicineService.medicineNameController,
                  decoration: InputDecoration(
                    labelText: 'Enter medicine name',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dosage in Mg:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: medicineService.dosageController,
                  decoration: InputDecoration(
                    labelText: 'Dosage',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Select Medicine Type',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildMedicineIcon(
                    context,
                    FontAwesomeIcons.tablets,
                    'Tablets',
                  ),
                  _buildMedicineIcon(
                    context,
                    FontAwesomeIcons.capsules,
                    'Capsules',
                  ),
                  _buildMedicineIcon(
                    context,
                    FontAwesomeIcons.wineBottle,
                    'Syrup',
                  ),
                  _buildMedicineIcon(
                    context,
                    FontAwesomeIcons.syringe,
                    'Injection',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                const Text(
                  'Remind me every',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: DropdownButton<String>(
                    items: <String>['1hour', '8hour', '12hour', 'Everyday']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                    hint: const Text('Select Time'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF377DE6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  medicineService.selectedTime != null
                      ? 'Selected Time: ${medicineService.selectedTime!.format(context)}'
                      : 'Select Time',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  medicineService.postDataToFirebase(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MediHome()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF377DE6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 38,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineIcon(BuildContext context, IconData icon, String type) {
    return GestureDetector(
      onTap: () => _selectMedicineType(type),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 60.0,
              color: medicineService.selectedMedicineType == type
                  ? const Color.fromARGB(255, 4, 2, 97)
                  : const Color(0xFF2196F3),
              shadows: [
                Shadow(
                  offset: const Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              type,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
