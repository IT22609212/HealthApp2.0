import 'package:flutter/material.dart';
import 'package:my_first_app/colors/colors.dart';
import 'package:my_first_app/navbar/top_nav.dart';
import 'package:my_first_app/pages/daily_challenges/daily_tasks.dart';
import 'package:my_first_app/pages/daily_challenges/status_view.dart';
import 'package:my_first_app/pages/workout_plans/bmi_calculator.dart';
import 'package:my_first_app/screens/medi_Home.dart';
import 'package:my_first_app/screens/mood_selection_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import FontAwesome

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Stack(
        children: [
          // Blue Header Container
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200, // Fixed height for the header
              color: AppColors.baseColor, // Custom blue color
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),
            ),
          ),

          // Scrollable Contact Info Section Container
          Positioned(
            top: 50, // Adjusted position for better alignment
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.baseColorForG, // Background color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: ContactInfoSection(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Contact Info Section with GridView for Square Category Cards
Widget ContactInfoSection(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      children: [
        SizedBox(height: 20.0),

        // HCA Health Center Title
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.baseColor, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'HCA HEALTH CENTER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0), // Space between title and icons
              // Row for icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.pills, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MediHome()),
                      );
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.balanceScale,
                        color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BMICalculatorApp()),
                      );
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.tasks, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StatusUpdatePage()),
                      );
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.smile, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoodSelectionScreen()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),

        // GridView for Category Cards
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                // Wrap onTap function in a closure that takes no arguments
                category['onTap'](context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Set the card color to white
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // How much the shadow spreads
                      blurRadius: 5, // Softness of the shadow
                      offset: Offset(0, 3), // Shadow position (x, y)
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      category['icon'],
                      color: AppColors.baseColor, // Set icon color to baseColor
                      size: 40,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      category['title'],
                      style: TextStyle(
                        color:
                            AppColors.baseColor, // Set text color to baseColor
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

// List of Categories
List<Map<String, dynamic>> categories = [
  {
    'title': 'Medication Reminder',
    'icon': FontAwesomeIcons.pills,
    'color': const Color.fromARGB(255, 220, 230, 233),
    'onTap': (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MediHome()),
      );
    },
  },
  {
    'title': 'BMI Calculator',
    'icon': FontAwesomeIcons.balanceScale,
    'color': const Color.fromARGB(255, 220, 230, 233),
    'onTap': (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BMICalculatorApp()),
      );
    },
  },
  {
    'title': 'Daily Challenges',
    'icon': FontAwesomeIcons.tasks,
    'color': const Color.fromARGB(255, 220, 230, 233),
    'onTap': (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StatusUpdatePage()),
      );
    },
  },
  {
    'title': 'Mood Tracker',
    'icon': FontAwesomeIcons.smile,
    'color': const Color.fromARGB(255, 220, 230, 233),
    'onTap': (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MoodSelectionScreen()),
      );
    },
  },
];
