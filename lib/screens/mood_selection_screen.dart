import 'package:flutter/material.dart';
import 'mood_intensity_screen.dart'; // Import the MoodIntensityScreen
import 'package:my_first_app/colors/colors.dart';

class MoodSelectionScreen extends StatelessWidget {
  const MoodSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mood Tracker",
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
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Tell Me About your ',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Mood',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 84, 177, 243),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Add a SizedBox for the vertical gap
              const SizedBox(height: 30),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                mainAxisSpacing: 15,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
                children: [
                  _buildMoodCard(context, 'Happy', 'assets/images/happy.jpeg',
                      AppColors.baseColor),
                  _buildMoodCard(context, 'Sad', 'assets/images/sad.jpg',
                      AppColors.baseColor),
                  _buildMoodCard(context, 'Stressed',
                      'assets/images/stressed.jpg', AppColors.baseColor),
                  _buildMoodCard(context, 'Anxious',
                      'assets/images/anxious.jpeg', AppColors.baseColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodCard(
      BuildContext context, String mood, String imagePath, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MoodIntensityScreen(mood: mood),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 100,
            ),
            const SizedBox(height: 16),
            Text(
              mood,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
