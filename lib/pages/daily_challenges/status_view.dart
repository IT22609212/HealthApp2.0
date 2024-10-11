import 'package:flutter/material.dart';
import 'package:my_first_app/navbar/bottom_nav.dart';
import 'package:my_first_app/screens/dashboard.dart';
import 'daily_tasks.dart';
import 'temp_tasks.dart';

void main() {
  runApp(StatusUpdatePage());
}

class StatusUpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StatusUpdateScreen(),
    );
  }
}

class StatusUpdateScreen extends StatelessWidget {
  final List<Map<String, String>> statuses = [
    {"label": "Busy", "mode": "Easy"},
    {"label": "Bit Busy", "mode": "Medium"},
    {"label": "Free", "mode": "Hard"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Status Update',
          style: TextStyle(color:Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 32, 107, 219),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage(),
            )); // Navigate back to the main screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: 250,
                      color: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back),
                          Text(
                            'Daily Challenges',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Let us know the status of Your schedule',
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: statuses.map((status) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DailyChallengesPage(
                                      initialDifficulty:
                                          status["mode"]!), // Pass the mode
                                ),
                              );
                            },
                            child: Text(
                              status["label"]!,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(
                                  color: Colors.blueAccent, width: 2),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_circle_left_rounded,
                            color: Color.fromARGB(255, 3, 3, 3)),
                        const SizedBox(width: 80),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 58, 71, 255),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Text(
                            "We will adjust the tasks that match your routine",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(9),
            child: Text(
              'Or You can Create your own plan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TempDailyTasksPage(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
