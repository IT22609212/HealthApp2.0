import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'challenges.dart';

void main() {
  runApp(const TempDailyTasks());
}

class TempDailyTasks extends StatelessWidget {
  const TempDailyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TempDailyTasksPage(),
    );
  }
}

class TempDailyTasksPage extends StatefulWidget {
  final String initialDifficulty;

  const TempDailyTasksPage({super.key, this.initialDifficulty = 'Easy'});

  @override
  // ignore: library_private_types_in_public_api
  _TempDailyTasksPageState createState() => _TempDailyTasksPageState();
}

class _TempDailyTasksPageState extends State<TempDailyTasksPage> {
  late String difficulty;
  List<Timer?> timers = List.generate(10, (index) => null);

  List<Map<String, dynamic>> temporaryTasks = [];

  Timer? _timer;
  void _showTaskCreationDialog() {
    if (challenges.isEmpty ||
        !challenges[0]['difficulty'].containsKey(difficulty)) {
      print("No challenges available or invalid difficulty key.");
      return;
    }

    // Default values from the first challenge
    String selectedTitle = challenges[0]['title'];
    String selectedInstructions =
        challenges[0]['difficulty'][difficulty]['instructions'];
    String selectedtime = challenges[0]['difficulty'][difficulty]['time'];
    int selectedDuration = challenges[0]['difficulty'][difficulty]['duration'];
    int selectedtimeRemaining = challenges[0]['timeRemaining'];

    // Show dialog
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Create Temporary Task"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<String>(
                      hint: const Text("Select Title"),
                      value: selectedTitle,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTitle = newValue!;
                          // Update the selected instructions and duration based on the selected title
                          final selectedChallenge = challenges.firstWhere(
                            (challenge) => challenge['title'] == selectedTitle,
                            orElse: () => challenges[
                                0], // Fallback to first challenge if not found
                          );
                          selectedInstructions = selectedChallenge['difficulty']
                              [difficulty]['instructions'];
                          selectedDuration = selectedChallenge['difficulty']
                              [difficulty]['duration'];
                          selectedtime = selectedChallenge['difficulty']
                              [difficulty]['time'];
                          selectedtimeRemaining =
                              selectedChallenge['timeRemaining'];
                          print("Selected Title: $selectedTitle"); // Debug
                        });
                      },
                      items:
                          challenges.map<DropdownMenuItem<String>>((challenge) {
                        return DropdownMenuItem<String>(
                          value: challenge['title'],
                          child: Text(challenge['title']),
                        );
                      }).toList(),
                    ),

                    // Display selected instructions and duration
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Instructions: $selectedInstructions"),
                          const SizedBox(height: 8.0),
                          //Text("Duration: $selectedDuration mins"),
                          //Text("timeRemaining: $selectedtimeRemaining mins"),
                          Text("time: $selectedtime "),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (selectedTitle.isNotEmpty) {
                      setState(() {
                        temporaryTasks.add({
                          "title": selectedTitle,
                          "timeRemaining": selectedtimeRemaining,
                          "time": selectedtime,
                          "instructions":
                              selectedInstructions, // Add instructions
                          "duration": selectedDuration, // Add duration
                          "isDone": false,
                          "isExpanded": false,
                        });
                      });
                      Navigator.of(context).pop(); // Close dialog
                    } else {
                      print("Please select both title and time."); // Debug
                    }
                  },
                  child: const Text("Create"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: const Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showCustomTaskCreationDialog() {
    String customTitle = '';
    String customDescript = '';
    String customDuration = '';
    String errorMessage = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Create Your Own Task"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: "Task Title"),
                    onChanged: (value) {
                      setState(() {
                        customTitle = value;
                      });
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: "Detailed Description"),
                    onChanged: (value) {
                      setState(() {
                        customDescript = value;
                      });
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: "Duration (in minutes)"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        customDuration = value;
                      });
                    },
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Convert duration to an integer
                    int? duration = int.tryParse(customDuration);

                    // Validate inputs
                    if (customTitle.isEmpty ||
                        customDescript.isEmpty ||
                        customDuration.isEmpty ||
                        duration == null ||
                        duration <= 0) {
                      // Show error message if validation fails
                      setState(() {
                        errorMessage =
                            "All fields are required and duration must be greater than zero.";
                      });
                    } else {
                      // Add the new task if validation passes
                      setState(() {
                        temporaryTasks.add({
                          "title": customTitle,
                          "instructions": customDescript,
                          "duration": duration,
                          "time": "$customDuration min",
                          "timeRemaining": 0,
                          "isDone": false,
                          "isExpanded": false,
                        });
                        errorMessage = '';
                      });
                      Navigator.of(context).pop(); // Close dialog
                    }
                  },
                  child: const Text("Create Task"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showTaskTypeSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Task Type"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Add Existing Task"),
                onTap: () {
                  Navigator.of(context).pop();
                  _showTaskCreationDialog(); // Existing task addition
                },
              ),
              ListTile(
                title: const Text("Create Your Own Task"),
                onTap: () {
                  Navigator.of(context).pop();
                  _showCustomTaskCreationDialog(); // New task creation
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void startTimer(int index) {
    if (timers[index] != null)
      return; // Prevent multiple timers for the same index

    setState(() {
      temporaryTasks[index]['timeRemaining'] =
          temporaryTasks[index]['duration'] * 60;
      temporaryTasks[index]['isPaused'] = false; // Set paused state to false
    });

    timers[index] = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (temporaryTasks[index]['timeRemaining'] > 0) {
          temporaryTasks[index]['timeRemaining']--;
        } else {
          timer.cancel();
          timers[index] = null; // Clear the timer reference
        }
      });
    });
  }

  void pauseTimer(int index) {
    if (timers[index] != null) {
      timers[index]?.cancel(); // Pause the timer
      timers[index] = null; // Clear the timer reference
      setState(() {
        temporaryTasks[index]['isPaused'] =
            true; // Mark the challenge as paused
      });
    }
  }

  void resumeTimer(int index) {
    if (timers[index] == null && temporaryTasks[index]['timeRemaining'] > 0) {
      timers[index] = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (temporaryTasks[index]['timeRemaining'] > 0) {
            temporaryTasks[index]['timeRemaining']--;
          } else {
            timer.cancel();
            timers[index] = null; // Clear the timer reference
          }
        });
      });
      setState(() {
        temporaryTasks[index]['isPaused'] = false; // Set paused state to false
      });
    }
  }

  void stopTimer(int index) {
    if (timers[index] != null) {
      timers[index]?.cancel(); // Cancel the timer
      timers[index] = null; // Clear the timer reference
    }
    setState(() {
      temporaryTasks[index]['timeRemaining'] = 0; // Reset time remaining
      temporaryTasks[index]['isPaused'] = false; // Mark as not paused
    });
  }

  List<String> factsYouNeedToKnow = [
    "Did you know that staying hydrated can boost your energy levels?",
    "Exercise releases endorphins, which can improve your mood.",
    "Sleep is crucial; it helps your brain function and boosts your immune system.",
    "Regular stretching can improve flexibility and reduce muscle tension.",
    "Eating a balanced diet can help maintain a healthy weight and energy.",
    "Mindfulness meditation can reduce stress and enhance focus.",
    "Taking breaks during work can improve productivity and reduce fatigue.",
    "Social connections can significantly improve mental health and longevity.",
    "Spending time outdoors can boost your vitamin D levels and mood.",
    "Laughter is linked to lower stress levels and better heart health."
  ];
  int currentSetIndex = 0; // Add this to your state
  int startIndex = 0;

  String currentTip = "";
  late Timer _tipTimer;
  int _currentIndex = 0;
  int refreshCount = 0; // Initialize the refresh count

  @override
  void initState() {
    super.initState();
    difficulty = widget.initialDifficulty;
    currentTip = factsYouNeedToKnow[_currentIndex];

    // Start the timer to change tips every 10 seconds for testing
    _tipTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % factsYouNeedToKnow.length;
        currentTip = factsYouNeedToKnow[_currentIndex];
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tipTimer.cancel();
    super.dispose();
  }

  bool allChallengesCompleted() {
    // Check if all temporary tasks are marked as done
    return temporaryTasks.every((tempTask) => tempTask['isDone'] == true);
  }

  bool isAllEditMode = false;
  @override
  Widget build(BuildContext context) {
    bool isTempListTooShort = temporaryTasks.length < 4;
    return Scaffold(
       appBar: AppBar(
        title: const Text(
          'HCA HealthCare',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 32, 107, 219),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
        onPressed: () {
            Navigator.of(context).pop(); // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width *
              0.05, // 5% margin on left and right
          vertical: MediaQuery.of(context).size.height *
              0.02, // 2% margin on top and bottom
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Your Plan',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            if (isTempListTooShort)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "The challenge plan is empty or contains less than 4 challenges.So Add more tasks.",
                  style: TextStyle(
                    color: Colors.red, // Red text for the warning
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (temporaryTasks.isNotEmpty) ...[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isAllEditMode =
                        !isAllEditMode; // Toggle edit mode for all tasks
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black, // Set background color to black
                ),
                child: Text(
                  isAllEditMode ? 'Done' : 'Edit',
                  style: const TextStyle(
                      color: Colors.white), // Set text color to white
                ),
              ),
            ],

            const SizedBox(height: 20),
            Expanded(
              child: AbsorbPointer(
                absorbing: isTempListTooShort && !isAllEditMode,
                child: ReorderableListView(
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final item = temporaryTasks.removeAt(oldIndex);
                      temporaryTasks.insert(newIndex, item);
                    });
                  },
                  children: List.generate(
                    temporaryTasks.length,
                    (index) {
                      final tempTask = temporaryTasks[index];

                      return TempChallengeTile(
                        key: Key('temp_$index'),
                        isEditMode: isAllEditMode, // Pass edit mode state
                        title: tempTask['title'] ?? "Untitled",
                        time: tempTask['time'] ?? "All Day",
                        instructions: tempTask['instructions'],
                        isDone: tempTask['isDone'] ?? false,
                        isExpanded: tempTask['isExpanded'] ?? false,
                        isPriority: tempTask['isPriority'] ?? false,
                        onChanged: (bool? value) {
                          setState(() {
                            tempTask['isDone'] = value!;
                            tempTask['showTick'] = tempTask['isDone'] == true;
                          });
                        },
                        onExpansionChanged: (bool expanded) {
                          setState(() {
                            tempTask['isExpanded'] = expanded;
                          });
                        },
                        onPriorityChanged: () {
                          setState(() {
                            // Toggle priority
                            tempTask['isPriority'] =
                                !(tempTask['isPriority'] ?? false);

                            // Get the current index of the temp task in the list
                            final currentIndex =
                                temporaryTasks.indexOf(tempTask);

                            // If the temp task is now a priority
                            if (tempTask['isPriority'] == true &&
                                currentIndex > 0) {
                              // Remove the temp task from its current position
                              final removedTempTask =
                                  temporaryTasks.removeAt(currentIndex);
                              // Insert it at the top of the list (index 0)
                              temporaryTasks.insert(0, removedTempTask);
                            }
                          });
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Show delete button only in edit mode
                            if (isAllEditMode) ...[
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    temporaryTasks.removeAt(index);
                                  });
                                },
                              ),
                            ] else ...[
                              tempTask['isDone'] == true
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Color.fromARGB(255, 2, 255, 10),
                                      size: 24, // Green tick when task is done
                                    )
                                  : (tempTask['timeRemaining'] ?? 0) >
                                          0 // Null check for timeRemaining
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              formatTime(tempTask[
                                                      'timeRemaining'] ??
                                                  0), // Ensure non-null value
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if ((tempTask[
                                                                'timeRemaining'] ??
                                                            0) >
                                                        0) {
                                                      if (tempTask[
                                                              'isPaused'] ??
                                                          false) {
                                                        resumeTimer(
                                                            index); // Resume the timer
                                                      } else {
                                                        pauseTimer(
                                                            index); // Pause the timer
                                                      }
                                                    } else {
                                                      startTimer(
                                                          index); // Start the timer if it's not running
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    minimumSize:
                                                        const Size(30, 30),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                  child: Icon(
                                                      (tempTask['isPaused'] ??
                                                              false)
                                                          ? Icons.play_arrow
                                                          : Icons.pause,
                                                      size: 16,
                                                      color: Colors.black),
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    minimumSize:
                                                        const Size(30, 30),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                  onPressed: () => stopTimer(
                                                      index), // Call stopTimer here
                                                  child: const Icon(Icons.stop,
                                                      size: 16,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(4),
                                            minimumSize: const Size(30, 30),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 255, 255),
                                          ),
                                          onPressed: () => startTimer(index),
                                          child: const Text(
                                            'Start',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                          ),
                                        ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            //motiv tips
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  currentTip,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),

            if (allChallengesCompleted() && temporaryTasks.isNotEmpty)
              Center(
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        // Clear temporary tasks when all challenges are completed
                        temporaryTasks.clear();
                      });

                      // Navigate to the congratulations page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CongratulationsPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 42, 35, 193),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "All Done!",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskTypeSelectionDialog(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }
}

class TempChallengeTile extends StatelessWidget {
  final String title;
  final String time;
  final String instructions;
  final bool isDone;
  final bool isExpanded;
  final bool isPriority;
  final ValueChanged<bool?>? onChanged;
  final ValueChanged<bool>? onExpansionChanged;
  final VoidCallback? onPriorityChanged; // Callback for priority toggle
  final Widget trailing;
  final bool isEditMode; // New parameter to indicate edit mode
  final VoidCallback? onDelete; // Callback for delete action

  const TempChallengeTile({
    Key? key,
    required this.title,
    required this.time,
    required this.instructions,
    required this.isDone,
    required this.isExpanded,
    required this.isPriority,
    required this.onChanged,
    required this.onExpansionChanged,
    required this.onPriorityChanged, // Add this field
    required this.trailing,
    required this.isEditMode, // Initialize new parameter
    this.onDelete, // Initialize delete callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isPriority
          ? const Color.fromARGB(255, 249, 249, 249)
          : Colors.white, // Highlight priority tasks
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
      elevation: 5, // Adjust the elevation to control shadow intensity
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(251, 0, 85, 255)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), // Rounded top-left corner
            bottomRight: Radius.circular(20), // Rounded bottom-right corner
          ),
          border: Border.all(
            color: Colors.black, // Color of the border
            width: 2.0, // Width of the border
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text(
                time,
                style: const TextStyle(color: Colors.black),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isEditMode) ...[
                    // Show priority star only when not in edit mode
                    IconButton(
                      icon: Icon(
                        isPriority
                            ? Icons.star
                            : Icons.star_border, // Star icon
                        color: isPriority
                            ? const Color.fromARGB(255, 255, 0, 0)
                            : const Color.fromARGB(
                                255, 0, 0, 0), // Red if priority
                        size: 20, // Smaller size
                      ),
                      onPressed: onPriorityChanged, // Toggle priority
                    ),
                  ],
                  trailing, // Existing trailing widget
                ],
              ),
              leading: !isEditMode // Show checkbox only when not in edit mode
                  ? Checkbox(
                      value: isDone,
                      onChanged: onChanged,
                    )
                  : null, // Do not render checkbox in edit mode
              onTap: () {
                if (!isEditMode) {
                  // Only toggle expansion if not in edit mode
                  onExpansionChanged!(!isExpanded);
                }
              },
            ),
            if (isExpanded) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  instructions,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// The Congratulations page
class CongratulationsPage extends StatelessWidget {
  // List of motivational tips
  final List<String> tips = [
    "Believe in yourself!",
    "Stay positive and strong.",
    "Every day is a new beginning.",
    "You are capable of amazing things.",
    "Make today so awesome that yesterday gets jealous.",
    "Push yourself, because no one else is going to do it for you.",
    "Dream big, work hard, stay focused.",
    "The future depends on what you do today.",
    "Don't watch the clock; do what it does. Keep going.",
    "Success is not the key to happiness. Happiness is the key to success."
  ];

  CongratulationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate a random index to select a tip
    final randomIndex = Random().nextInt(tips.length);
    final motivationalTip = tips[randomIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 35),
          onPressed: () {},
        ),
        centerTitle: true,
        title: const Text(
          'HCA Healthcare',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width *
                0.05, // 5% margin on left and right
            vertical: MediaQuery.of(context).size.height *
                0.02, // 2% margin on top and bottom
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header section

              // Underlined sentence

              const Text(
                "All done. But Tomorrow Awaits Your arrival.",
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Keep up the good work",
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              // Container for image and congratulations text
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width *
                        0.05), // 5% margin on left and right
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // Online image
                    Image.asset(
                      'assets/images/re1.jpg', // Replace with your online image URL
                      width: double
                          .infinity, // Set width to fit the whole container
                      height: 150, // Set the desired height
                      fit: BoxFit.cover, // Cover the entire space
                    ),
                    const SizedBox(height: 10),

                    // Congratulations message with animated text
                    const AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 500),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      child: Text(
                        '🎉 Congratulations! You\'ve completed all tasks! 🎉',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: 20), // 5% margin on left and right
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Motivational Tip of the Day",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      motivationalTip,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width *
                      0.05, // 5% margin on left and right
                  vertical: MediaQuery.of(context).size.height *
                      0.02, // 2% margin on top and bottom
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // Use backgroundColor instead of primary
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Back to Challenges",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
