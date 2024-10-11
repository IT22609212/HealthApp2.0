import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/activity.dart';
import 'activity_description_screen.dart';
import 'study_mode_screen.dart'; // Import StudyModeScreen

class ActivitySuggestionScreen extends StatelessWidget {
  final String mood;

  const ActivitySuggestionScreen({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    // Get suggested activities based on the selected mood
    final List<Activity> suggestedActivities = _getSuggestedActivities(mood);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button with 10px vertical gap
          Padding(
            padding: const EdgeInsets.only(top: 35.0, left: 4.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.black, size: 35),
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
            ),
          ),
          const SizedBox(
              height:
                  30), // 20px vertical gap between back button and suggested activities
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                  color: Color.fromARGB(255, 9, 10, 10),
                ),
                children: [
                  const TextSpan(text: 'Suggested Activities for '),
                  TextSpan(
                    text: mood,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 69, 186, 248),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
              height: 16.0), // Vertical gap between text and activities list
          Expanded(
            child: ListView.builder(
              itemCount: suggestedActivities.length +
                  1, // +1 to account for the Study Mode card
              itemBuilder: (context, index) {
                // Check if the current item is the Study Mode card
                if (index == suggestedActivities.length) {
                  return _buildStudyModeCard(
                      context); // Build the Study Mode card
                }

                final activity = suggestedActivities[index];
                return _buildActivityCard(context, activity);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Activity> _getSuggestedActivities(String mood) {
    return moodActivities[mood] ?? [];
  }

  Widget _buildActivityCard(BuildContext context, Activity activity) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 2,
      color: const Color.fromARGB(255, 190, 229, 249),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: Container(
            width: 80,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                activity.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            activity.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            _truncateText(activity.description, 40),
            style: const TextStyle(
              color: Color(0xFF0077B6),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ActivityDescriptionScreen(activity: activity),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStudyModeCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 15), // 30px gap above and below
      child: Card(
        margin: const EdgeInsets.only(top: 30), // 30px gap from activity cards
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: const Color.fromARGB(
            255, 92, 199, 249), // Blue color for the Study Mode card
        child: SizedBox(
          height: 115, // Increased vertical height of the card by 15px
          child: ListTile(
            title: const Text(
              'Study Mode',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 251, 250, 250),
                fontSize: 20, // Increased font size
              ),
            ),
            subtitle: const Text(
              'Boost your productivity with focused study tips.',
              style: TextStyle(
                color: Color.fromARGB(255, 253, 252, 252),
                fontSize: 16, // Increased subtitle font size
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios,
                  color: Color.fromARGB(
                      255, 250, 250, 250)), // Keep the icon white
              onPressed: () {
                // Navigate to StudyModeScreen on tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudyModeScreen(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}
