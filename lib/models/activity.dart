// lib/models/activity.dart

class Activity {
  final String title;
  final String description;
  final String imagePath; // Added imagePath property
  final String time; // Added time property

  Activity({
    required this.title,
    required this.description,
    required this.imagePath, // Include imagePath in the constructor
    required this.time, // Include time in the constructor
  });
}
