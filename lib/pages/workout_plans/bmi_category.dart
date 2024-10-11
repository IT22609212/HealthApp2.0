import 'package:flutter/material.dart';
import 'hydration_reminder.dart';

class CategoryScreen extends StatelessWidget {
  final String
      category; // This determines whether the category is underweight, average, or overweight.

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Plans'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Category text display
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Stack(
                    children: [
                      // Black bordered text (beneath)
                      Text(
                        'You\'re',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.black, // Black border color
                        ),
                      ),
                      // White filled text (on top)
                      const Text(
                        'You\'re',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Stack(
                    children: [
                      // Bordered text (beneath)
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.black, // Black border color
                        ),
                      ),
                      // Colored text (on top)
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 35,
                          color: category == 'Underweight'
                              ? const Color.fromARGB(255, 60, 156, 234)
                              : category == 'Average'
                                  ? const Color.fromARGB(255, 89, 208, 93)
                                  : const Color.fromARGB(255, 245, 61,
                                      48), // Color changes based on category
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Icon based on category
            Image.asset(
              category == 'Underweight'
                  ? 'assets/images/underweight_category.gif'
                  : category == 'Average'
                      ? 'assets/images/average_category.gif'
                      : 'assets/images/overweight_category.gif',
              height: 150, // Set height of the image
              width: 180, // Set width of the image
              fit: BoxFit
                  .contain, // You can use BoxFit to control how the image fits
            ),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Preferred plans',
                  style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // List of workout plans
            WorkoutPlan(
              planNumber: 1,
              image: category == 'Underweight'
                  ? 'assets/images/under_relax.png'
                  : category == 'Average'
                      ? 'assets/images/avg_high.png'
                      : 'assets/images/over_quick.png',
              intensity: category == 'Underweight'
                  ? 'Moderate \nIntensity'
                  : category == 'Average'
                      ? 'High \nIntensity'
                      : 'Moderate \nIntensity',
              description: category == 'Underweight'
                  ? 'Less \nEffective'
                  : category == 'Average'
                      ? 'Highly \nEffective'
                      : 'Moderately \nEffective',
              time: category == 'Underweight'
                  ? 'Relaxing'
                  : category == 'Average'
                      ? 'Quick'
                      : 'Slow',
              category: category == 'Underweight'
                  ? 'Underweight'
                  : category == 'Average'
                      ? 'Average'
                      : 'Overweight',
            ),
            WorkoutPlan(
              planNumber: 2,
              image: category == 'Underweight'
                  ? 'assets/images/under_moderate.png'
                  : category == 'Average'
                      ? 'assets/images/avg_relaxing.png'
                      : 'assets/images/over_high.png',
              intensity: category == 'Underweight'
                  ? 'High \nIntensity'
                  : category == 'Average'
                      ? 'Low \nIntensity'
                      : 'High \nIntensity',
              description: category == 'Underweight'
                  ? 'Moderately \nEffective'
                  : category == 'Average'
                      ? 'Less \nEffective'
                      : 'Highly \nEffective',
              time: category == 'Underweight'
                  ? 'Quick'
                  : category == 'Average'
                      ? 'Relaxing'
                      : 'Quick',
              category: category == 'Underweight'
                  ? 'Underweight'
                  : category == 'Average'
                      ? 'Average'
                      : 'Overweight',
            ),
            WorkoutPlan(
              planNumber: 3,
              image: category == 'Underweight'
                  ? 'assets/images/under_high.png'
                  : category == 'Average'
                      ? 'assets/images/avg_slow.png'
                      : 'assets/images/over_low.png',
              intensity: category == 'Underweight'
                  ? 'High \nIntensity'
                  : category == 'Average'
                      ? 'Moderate \nIntensity'
                      : 'Low \nIntensity',
              description: category == 'Underweight'
                  ? 'Highly \nEffective'
                  : category == 'Average'
                      ? 'Moderately \nEffective'
                      : 'Less \nEffective',
              time: category == 'Underweight'
                  ? 'Slow'
                  : category == 'Average'
                      ? 'Slow'
                      : 'Relaxing',
              category: category == 'Underweight'
                  ? 'Underweight'
                  : category == 'Average'
                      ? 'Average'
                      : 'Overweight',
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutPlan extends StatelessWidget {
  final int planNumber;
  final String image;
  final String intensity;
  final String description;
  final String time;
  final String category;

  const WorkoutPlan({
    super.key,
    required this.planNumber,
    required this.image,
    required this.intensity,
    required this.description,
    required this.time,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the hydration_reminder screen and pass category and planNumber
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HydrationReminderScreen(
              category: category,
              planNumber: planNumber,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 340,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 15, 159, 231),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  // Plan image
                  Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Plan details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PLAN $planNumber',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Container(
                            color: const Color.fromARGB(255, 92, 216,
                                250), // Set the background color for the text
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8), // Add some padding to the text
                            child: Text(
                              description,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            color: const Color.fromARGB(255, 14, 213,
                                227), // Set the background color for the text
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              intensity,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        color: const Color.fromARGB(255, 14, 213,
                            227), // Set the background color for the text
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          time,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
