import 'package:flutter/material.dart';
import 'package:my_first_app/colors/colors.dart';
import 'package:my_first_app/pages/workout_plans/bmi_calculator.dart';
import 'package:my_first_app/screens/about_us.dart';
import 'package:my_first_app/screens/medi_Home.dart';
import 'package:my_first_app/screens/dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the widget based on the selected index
    Widget widget = Container(); // default empty container
    switch (_selectedIndex) {
      case 0:
        widget = DashBoard(); // Load the DashBoard screen
        break;

      case 1:
        widget = MediHome();
        break;
      case 2:
        widget =  AboutPage();
        break;
      // case 3:
      //   widget = AboutPage();
      //   break;
    }

    return Scaffold(
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Reminder',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.money_rounded),
          //   label: 'Bills',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
            
          ),
        ],
        currentIndex: _selectedIndex, // Highlight the selected item
        selectedItemColor: AppColors.baseColor, // Color for selected item
        unselectedItemColor: AppColors.bicon, // Color for unselected item
        onTap: _onItemTapped, // Handle taps
      ),
      body: widget, // Display the selected screen content
    );
  }
}
