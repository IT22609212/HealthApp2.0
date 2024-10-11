import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'plan_description.dart';

class HydrationReminderScreen extends StatelessWidget {
  final String category;
  final int planNumber;

  const HydrationReminderScreen({
    super.key,
    required this.category,
    required this.planNumber,
  });

  // Function to get the hydration level and required amount based on category and planNumber
  Map<String, dynamic> getHydrationData() {
    double waterPercentage = 0.0;
    String waterAmount = '';

    // Define hydration content for each category and plan number
    switch (category) {
      case 'Average':
        if (planNumber == 1) {
          waterPercentage = 0.80;
          waterAmount = '700 ml';
        } else if (planNumber == 2) {
          waterPercentage = 0.65;
          waterAmount = '500 ml';
        } else if (planNumber == 3) {
          waterPercentage = 0.90;
          waterAmount = '800 ml';
        }
        break;
      case 'Underweight':
        if (planNumber == 1) {
          waterPercentage = 0.50;
          waterAmount = '300 ml';
        } else if (planNumber == 2) {
          waterPercentage = 0.60;
          waterAmount = '400 ml';
        } else if (planNumber == 3) {
          waterPercentage = 0.70;
          waterAmount = '500 ml';
        }
        break;
      case 'Overweight':
        if (planNumber == 1) {
          waterPercentage = 0.85;
          waterAmount = '750 ml';
        } else if (planNumber == 2) {
          waterPercentage = 0.75;
          waterAmount = '600 ml';
        } else if (planNumber == 3) {
          waterPercentage = 0.95;
          waterAmount = '850 ml';
        }
        break;
    }
    return {'percentage': waterPercentage, 'amount': waterAmount};
  }

  @override
  Widget build(BuildContext context) {
    final hydrationData = getHydrationData();

    return Scaffold(
      appBar: AppBar(
        title: Text('$category ➔ Plan $planNumber'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/hydration.gif'), // Change to the actual path of your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // "Take a Break" Text with Drop Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                // Outlined Text (this creates the border effect)
                                Text(
                                  'TAKE A',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2.0
                                      ..color = Colors.white, // Border color
                                  ),
                                ),
                                // Filled Text (placed on top)
                                Text(
                                  'TAKE A',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade800,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 2.0,
                                        color: Colors.grey.shade600,
                                        offset: const Offset(2.0, 2.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                // Outlined Text (this creates the border effect)
                                Text(
                                  'BREAK',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2.0
                                      ..color = Colors.white, // Border color
                                  ),
                                ),
                                // Filled Text (placed on top)
                                Text(
                                  'BREAK',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade800,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 2.0,
                                        color: Colors.grey.shade600,
                                        offset: const Offset(2.0, 2.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.water_drop,
                                color: Color.fromARGB(255, 14, 200, 224),
                                size: 30),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Hydration Level Circular Indicator
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: hydrationData['percentage'],
                  center: Text(
                    '${(hydrationData['percentage'] * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.blue,
                  backgroundColor: Colors.grey.shade300,
                ),
                const SizedBox(height: 20),
                // Hydration requirement text
                const Text(
                  'Hydration level required to continue',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                // Water intake amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Drink  ➔ ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        hydrationData['amount'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Continue Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade200,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to NextScreen and pass the category and planNumber values
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlanDescriptionScreen(
                          category: category,
                          planNumber: planNumber,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
