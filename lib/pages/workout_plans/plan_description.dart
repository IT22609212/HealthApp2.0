import 'package:flutter/material.dart';
import 'dart:async'; // For Timer
import 'workout_plans.dart';

class PlanDescriptionScreen extends StatelessWidget {
  final String category;
  final int planNumber;

  const PlanDescriptionScreen({
    super.key,
    required this.category,
    required this.planNumber,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve plan data based on category and plan number
    final planDetails = planData[category]?[planNumber];
    if (planDetails == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Plan Details')),
        body: const Center(child: Text('No plan details available.')),
      );
    }

    final totalTime = planDetails['time'];
    final effectiveness = planDetails['effectiveness'];
    final exercises = planDetails['exercises'] as List<Exercise>;

    return Scaffold(
      appBar: AppBar(
        title: Text('$category ➔ Plan $planNumber'),
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Header with time and effectiveness
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Total time
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.timer, size: 35, color: Colors.blue),
                        Text(
                          '$totalTime mins',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Effectiveness
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Effectiveness',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                        Text(
                          '$effectiveness%',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Exercise cards
              Column(
                children: exercises.map((exercise) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ExerciseCard(exercise: exercise),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseCard extends StatefulWidget {
  final Exercise exercise;

  const ExerciseCard({super.key, required this.exercise});

  @override
  // ignore: library_private_types_in_public_api
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  Timer? timer;
  int remainingTime = 0;
  bool isRunning = false;
  bool showSwapOptions = false;
  SwapExercise? selectedSwapExercise;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.exercise.time * 60; // Convert to seconds
  }

  void startTimer() {
    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    setState(() {
      timer?.cancel();
      isRunning = false;
    });
  }

  void restartTimer() {
    setState(() {
      stopTimer();
      remainingTime = widget.exercise.time * 60; // Reset to initial value
    });
  }

  String get timerDisplay {
    return '${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}';
  }

  // Method to show swap exercise options
  void showSwapExerciseOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        final swapExercise = widget.exercise.swapExercise;
        final exercise = widget.exercise.name;

        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 450, // Adjust height as necessary based on content
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Exercise Image
                Center(
                  // Center the image for better alignment
                  child: Image.asset(
                    swapExercise.image,
                    width: 250,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),

                // Exercise Name and Details
                Text(
                  '${swapExercise.name} for $exercise',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Reps: ${swapExercise.reps}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'Sets: ${swapExercise.sets}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Effectiveness Change: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '${swapExercise.effectivenessChange}%',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: swapExercise.effectivenessChange < 0
                            ? Colors.red // Red for less than 0
                            : swapExercise.effectivenessChange > 0
                                ? Colors.green // Green for greater than 0
                                : Colors.black, // Grey for equal to 0
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Advantages Section
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Advantages:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        swapExercise.advantage,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Disadvantages Section
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Disadvantages:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        swapExercise.disadvantage,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top section with image
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: AspectRatio(
                aspectRatio: 16 / 9, // Adjust the aspect ratio as necessary
                child: Image.asset(
                  widget.exercise.image,
                  fit: BoxFit
                      .contain, // Use BoxFit.contain to ensure the image is fully visible
                  height: 150,
                  width: double.infinity,
                ),
              ),
            ),
          ),

          // Middle section with text details
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.blue.shade500],
              ),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.exercise.name,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 27, 14, 14)),
                ),
                const SizedBox(height: 4),
                Text(
                  '${widget.exercise.reps} Reps  |  ${widget.exercise.sets} Sets',
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 10),
                // Timer display
                Text(
                  timerDisplay,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
          ),

          // Bottom section with buttons
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Swap Exercise Button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade300,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 12.0,
                          ),
                        ),
                        onPressed: showSwapExerciseOptions, // Open bottom sheet
                        icon: const Icon(Icons.swap_horiz),
                        label: const Text('Swap'),
                      ),

                      // Start/Stop and Restart Buttons
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isRunning ? Icons.stop : Icons.play_arrow,
                              size: 24,
                            ),
                            color: Colors.green,
                            onPressed: isRunning ? stopTimer : startTimer,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.replay,
                              size: 24,
                            ),
                            color: Colors.orange,
                            onPressed: restartTimer,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}


// import 'package:flutter/material.dart';
// import 'workout_plans.dart';

// class PlanDescriptionScreen extends StatelessWidget {
//   final String category;
//   final int planNumber;

//   const PlanDescriptionScreen({
//     super.key,
//     required this.category,
//     required this.planNumber,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Retrieve plan data based on category and plan number
//     final planDetails = planData[category]?[planNumber];
//     if (planDetails == null) {
//       return Scaffold(
//         appBar: AppBar(title: const Text('Plan Details')),
//         body: const Center(child: Text('No plan details available.')),
//       );
//     }

//     final totalTime = planDetails['time'];
//     final effectiveness = planDetails['effectiveness'];
//     final exercises = planDetails['exercises'] as List<Exercise>;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$category ➔ Plan $planNumber'),
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               // Header with time and effectiveness
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   // Total time
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade100,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 5,
//                           offset: Offset(2, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         const Icon(Icons.timer, size: 40, color: Colors.blue),
//                         Text(
//                           '$totalTime mins',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Effectiveness
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade100,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 5,
//                           offset: Offset(2, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         const Text(
//                           'Effectiveness',
//                           style: TextStyle(fontSize: 18, color: Colors.blue),
//                         ),
//                         Text(
//                           '$effectiveness%',
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // Exercise cards
//               Column(
//                 children: exercises.map((exercise) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Card(
//                       elevation: 4, // Adds shadow to the card
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 20), // Add side margins
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           // Top section with image
//                           Container(
//                             padding: const EdgeInsets.all(8.0),
//                             decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(15),
//                               ),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: const BorderRadius.vertical(
//                                 top: Radius.circular(15),
//                               ),
//                               child: Image.asset(
//                                 exercise.image,
//                                 height: 150, // Keep height as required
//                                 fit: BoxFit
//                                     .cover, // Ensure image covers entire height
//                                 width: double.infinity,
//                               ),
//                             ),
//                           ),

//                           // Middle section with text details
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16.0, vertical: 12.0),
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Colors.blue.shade300,
//                                   Colors.blue.shade500
//                                 ],
//                               ),
//                               borderRadius: const BorderRadius.vertical(
//                                 bottom: Radius.circular(10),
//                               ),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   exercise.name,
//                                   style: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                     height:
//                                         4), // Add spacing between text and details
//                                 Text(
//                                   '${exercise.reps} Reps  |  ${exercise.sets} Sets',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.white70,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // Bottom section with buttons
//                           Container(
//                             padding: const EdgeInsets.all(8.0),
//                             decoration: BoxDecoration(
//                               color: Colors.blue.shade50,
//                               borderRadius: const BorderRadius.vertical(
//                                 bottom: Radius.circular(15),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 // SWAP Button on the bottom left
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Handle swap button functionality
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors
//                                         .blueAccent, // Change button color
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20, vertical: 12),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   child: const Text(
//                                     'SWAP',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),

//                                 // Start Button on the bottom right
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Handle start button functionality
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         Colors.green, // Change button color
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20, vertical: 12),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   child: Text(
//                                     'Start ➔ ${exercise.time} mins',
//                                     style: const TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
