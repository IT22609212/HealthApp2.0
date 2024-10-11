import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_app/colors/colors.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
  @override
  Size get preferredSize => Size.fromHeight(76.0); // Set height here
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(76.0),
      child: Padding(
        padding: EdgeInsets.only(top: 9.0),
        child: CustomAppBar(),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // removes back button
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjusts alignment
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ProfilePage(),
                  //   ),
                  // );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                        'lib/assets/images/40ywomen.jpg'), // Use AssetImage
                    radius: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HEY 👋',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '@Sama',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Icon(
                        Icons.arrow_drop_down_circle,
                        size: 16.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Notification and Settings Icons
          // Row(
          //   children: [
          //     IconButton(
          //       icon: const Icon(Icons.notifications_none, color: Colors.white),
          //       onPressed: () {
          //         // Handle notification press
          //       },
          //     ),
          //     IconButton(
          //       icon: const Icon(Icons.settings, color: Colors.white),
          //       onPressed: () {
          //         // Navigator.push(
          //         //   context,
          //         //   MaterialPageRoute(
          //         //     builder: (context) => AppSettingsPage(),
          //         //   ),
          //         // );
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
      elevation: 2, // Add this line for shadow
      backgroundColor: AppColors.baseColor,
    );
  }
}
