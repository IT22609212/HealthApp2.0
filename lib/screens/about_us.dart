 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// Assuming you have a custom color setup
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/colors/colors.dart';
import 'package:my_first_app/navbar/top_nav.dart';

class AboutPage extends StatefulWidget {
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 
                ],
              ),
            ),
          ),

          // Scrollable Contact Info Section Container
          Positioned(
            top: 80, // Position below the header container
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
                child: ContactInfoSection(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// Widget for contact information sections

Widget ContactInfoSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center the column's children
      children: [
       
        SizedBox(height: 20),
        Text(
          'SLIIT',
          textAlign: TextAlign.center, // Center the text
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 10),
        ContactCard(
          content:
              'Sayun Hetti:IT2212345789\nYashoda: IT22123456\nSamadhi: IT22366368\nMuhammed.H : IT22609212',
        ),
      
        SizedBox(height: 20),
        Center(
          child: Text(
            'Follow us',
            textAlign: TextAlign.center, // Center the text
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        SizedBox(height: 10), // Add some spacing before the icons
        Center(
          // Centers the row horizontally
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Aligns icons in the center
            children: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                onPressed: () {
                 
                },
              ),
              SizedBox(width: 20),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.purple),
                onPressed: () {
                 
                },
              ),
              SizedBox(width: 20),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.xTwitter, color: Colors.blue),
                onPressed: () {
                  
                     
                },
              ),
              SizedBox(width: 20),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.blue),
                onPressed: () {
                  
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Widget for each contact card
Widget ContactCard({required String content}) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 10.0),
    elevation: 5, // Adds a subtle shadow for a professional look
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      width: double.infinity, // Full width for the card
      padding: const EdgeInsets.all(20.0), // Padding for better content spacing
      decoration: BoxDecoration(
        color:
            Color.fromARGB(255, 255, 255, 255), // Light gray background color
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppColors.baseColor, // Blue border color (custom blue color)
          width: 2.0, // Thickness of the border
        ),
      ),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 14,
          color: const Color.fromARGB(255, 22, 22, 22), // Darker color for text
        ),
      ),
    ),
  );
}
