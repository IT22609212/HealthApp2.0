import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MedicineService {
  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  TimeOfDay? selectedTime;
  String selectedMedicineType = '';

  // Collection reference
  final CollectionReference _medicineCollection =
      FirebaseFirestore.instance.collection('medicines');

  void dispose() {
    medicineNameController.dispose();
    dosageController.dispose();
  }

  // Create (Already implemented)
  Future<void> postDataToFirebase(BuildContext context) async {
    if (medicineNameController.text.isEmpty ||
        dosageController.text.isEmpty ||
        selectedMedicineType.isEmpty ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields.')),
      );
      return;
    }

    final medicineData = {
      'medicine_name': medicineNameController.text,
      'dosage': dosageController.text,
      'medicine_type': selectedMedicineType,
      'reminder_time': selectedTime?.format(context),
    };

    try {
      await _medicineCollection.add(medicineData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicine added successfully!')),
      );

      // Reset form
      medicineNameController.clear();
      dosageController.clear();
      selectedMedicineType = '';
      selectedTime = null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add medicine.')),
      );
    }
  }

  // Read all
  Stream<QuerySnapshot> getAllMedicines() {
    return _medicineCollection.snapshots();
  }

  // Read by ID
  Future<DocumentSnapshot> getMedicineById(String id) async {
    try {
      return await _medicineCollection.doc(id).get();
    } catch (e) {
      throw Exception("Failed to fetch medicine: $e");
    }
  }

  // Update
  Future<void> updateMedicine(
      String id, Map<String, dynamic> updatedData, BuildContext context) async {
    try {
      await _medicineCollection.doc(id).update(updatedData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicine updated successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update medicine.')),
      );
    }
  }

  // Delete
  Future<void> deleteMedicine(String id, BuildContext context) async {
    try {
      await _medicineCollection.doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicine deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete medicine.')),
      );
    }
  }
}
