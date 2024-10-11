import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'challenges.dart';

void main() {
  runApp(DailyTasks());
}

class DailyTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DailyChallengesPage(),
    );
  }
}

class DailyChallengesPage extends StatefulWidget {
  final String initialDifficulty;

  DailyChallengesPage({this.initialDifficulty = 'Medium'});

  @override
  _DailyChallengesPageState createState() => _DailyChallengesPageState();
}

class _DailyChallengesPageState extends State<DailyChallengesPage> {
  late String difficulty;
  List<Timer?> timers =
      List.generate(20, (index) => null); // Assuming 6 challenges

  Timer? _timer;

  void startTimer(int index) {
    if (timers[index] != null)
      return; // Prevent multiple timers for the same index

    setState(() {
      challenges[index]['timeRemaining'] =
          challenges[index]['difficulty'][difficulty]['duration'] * 60;
      challenges[index]['isPaused'] = false; // Set paused state to false
    });

    timers[index] = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (challenges[index]['timeRemaining'] > 0) {
          challenges[index]['timeRemaining']--;
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
        challenges[index]['isPaused'] = true; // Mark the challenge as paused
      });
    }
  }

  void resumeTimer(int index) {
    if (timers[index] == null && challenges[index]['timeRemaining'] > 0) {
      timers[index] = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (challenges[index]['timeRemaining'] > 0) {
            challenges[index]['timeRemaining']--;
          } else {
            timer.cancel();
            timers[index] = null; // Clear the timer reference
          }
        });
      });
      setState(() {
        challenges[index]['isPaused'] = false; // Set paused state to false
      });
    }
  }

  void stopTimer(int index) {
    if (timers[index] != null) {
      timers[index]?.cancel(); // Cancel the timer
      timers[index] = null; // Clear the timer reference
    }
    setState(() {
      challenges[index]['timeRemaining'] = 0; // Reset time remaining
      challenges[index]['isPaused'] = false; // Mark as not paused
    });
  }

  List<String> factsYouNeedToKnow = [
    "Staying hydrated boosts energy.",
    "Exercise releases endorphins for a better mood.",
    "Sleep enhances brain function and immunity.",
    "Mindfulness meditation reduces stress and enhances focus.",
    "Social connections improve mental health and longevity."
  ];

  int currentSetIndex = 0; // Add this to your state
  int startIndex = 0;

  void refreshTasks() {
    setState(() {
      startIndex += 4; // Move to the next set of 4 tasks
      if (startIndex >= challenges.length) {
        startIndex = 0; // Reset to the beginning if at the end
      }
    });
  }

  String currentTip = "";
  late Timer _tipTimer;
  int _currentIndex = 0;
  int refreshCount = 0; // Initialize the refresh count

  void _showDifficultySelector() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Difficulty"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Easy"),
                onTap: () {
                  setState(() {
                    difficulty = 'Easy';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Medium"),
                onTap: () {
                  setState(() {
                    difficulty = 'Medium';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Hard"),
                onTap: () {
                  setState(() {
                    difficulty = 'Hard';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
    // Get only the displayed challenges based on the current set index
    final startIndex = currentSetIndex * 4; // Calculate the start index
    final displayedChallenges = challenges.skip(startIndex).take(4).toList();

    return displayedChallenges
        .every((challenge) => challenge['isDone'] == true);
  }

  double get totalProgress {
    num totalProgressPoints = 0;
    num totalTasks = 4;

    for (var challenge in challenges) {
      totalProgressPoints += challenge['isDone'] ? challenge['progress'] : 0;
    }

    return totalTasks > 0
        ? (totalProgressPoints / (totalTasks * 100))
        : 0.0; // Normalize progress
  }

  bool get isRefreshButtonVisible {
    // Check if any challenge is done
    return !challenges.any((challenge) => challenge['isDone']);
  }

  @override
  Widget build(BuildContext context) {
    const maxRefreshCount = 3;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HCA HealthCare",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today\'s Challenges',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.black),
                  onPressed: _showDifficultySelector,
                ),
              ],
            ),

            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: difficulty == 'Easy'
                        ? Colors.green
                        : difficulty == 'Medium'
                            ? const Color.fromARGB(255, 112, 82, 247)
                            : const Color.fromARGB(255, 235, 87, 77),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    difficulty,
                    style: const TextStyle(
                        color: Colors.black, fontStyle: FontStyle.italic),
                  ),
                ),
                if (isRefreshButtonVisible) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ElevatedButton(
                      onPressed: refreshCount < maxRefreshCount
                          ? () {
                              setState(() {
                                // Update the current set index to cycle through the tasks
                                currentSetIndex = (currentSetIndex + 1) %
                                    ((challenges.length ~/ 4) + 1);
                                refreshCount++; // Increment the refresh count
                              });
                            }
                          : null, // Disable the button if limit is reached
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Button background color
                        shadowColor: Colors.black, // Shadow color
                        elevation: 5, // Elevation for shadow effect
                        disabledBackgroundColor:
                            Colors.grey, // Disabled button background color
                      ),
                      child: refreshCount < maxRefreshCount
                          ? Text(
                              "Refresh Tasks (${maxRefreshCount - refreshCount} remaining)",
                              style: const TextStyle(
                                  color: Colors.black), // Text color black
                            )
                          : const Text(
                              "You have reached your limit",
                              style: TextStyle(
                                  color: Colors.black), // Text color black
                            ),
                    ),
                  ),
                ]
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 166, 206, 240), // Background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
                // Black border
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // Shadow color
                    spreadRadius: 2, // Shadow spread
                    blurRadius: 5, // Shadow blur
                    offset: const Offset(2, 2), // Shadow position (X, Y)
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Overall Progress",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: MediaQuery.of(context).size.width *
                                  totalProgress,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.lightBlueAccent],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Text(
                              "${(totalProgress * 100).toStringAsFixed(0)}%",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Other widgets can be added here
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ReorderableListView(
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final item = challenges.removeAt(oldIndex);
                          challenges.insert(newIndex, item);
                        });
                      },
                      children: List.generate(
                        4,
                        (index) {
                          int startIndex = currentSetIndex *
                              4; // Calculate start index based on current set
                          final actualIndex = startIndex + index;

                          // Check if the index is for existing challenges
                          if (index < 4) {
                            // Ensure we don't exceed the available challenges
                            if (actualIndex < challenges.length) {
                              final challenge = challenges[actualIndex];
                              final currentDifficulty =
                                  challenge['difficulty'][difficulty];
                              final timeRemaining = challenge['timeRemaining'];
                              return ChallengeTile(
                                  key: Key(
                                      '$actualIndex'), // Use actualIndex for key
                                  title: challenge['title'] ?? "Untitled",
                                  time: currentDifficulty['time'],
                                  progress: challenge['progress'] ?? 0,
                                  instructions:
                                      currentDifficulty['instructions'],
                                  isDone: challenge['isDone'] ?? false,
                                  isExpanded: challenge['isExpanded'] ?? false,
                                  isPriority: challenge['isPriority'] ?? false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      challenge['isDone'] = value!;
                                      challenge['showTick'] =
                                          challenge['isDone'] == true;
                                      challenge['progress'] =
                                          challenge['isDone'] ? 100 : 0;
                                    });
                                  },
                                  onExpansionChanged: (bool expanded) {
                                    setState(() {
                                      challenge['isExpanded'] = expanded;
                                    });
                                  },
                                  onPriorityChanged: () {
                                    setState(() {
                                      // Toggle priority
                                      challenge['isPriority'] =
                                          !(challenge['isPriority'] ?? false);

                                      // Get the current index of the challenge in the list
                                      final currentIndex =
                                          challenges.indexOf(challenge);

                                      // If the challenge is now a priority and is not already in the first 3 blocks
                                      if (challenge['isPriority'] == true &&
                                          currentIndex > 0) {
                                        // Calculate the new index, moving it 3 positions up but ensuring it doesn't go below 0
                                        final newIndex = (currentIndex - 3) < 0
                                            ? 0
                                            : currentIndex - 3;
                                        // Remove the challenge from its current position
                                        final removedChallenge =
                                            challenges.removeAt(currentIndex);
                                        // Insert it at the new calculated position
                                        challenges.insert(
                                            newIndex, removedChallenge);
                                      }
                                    });
                                  },
                                  trailing: challenge['isDone'] == true
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size:
                                              24, // Green tick when task is done
                                        )
                                      : timeRemaining > 0
                                          ? Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  formatTime(timeRemaining),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        if (timeRemaining > 0) {
                                                          if (challenge[
                                                              'isPaused']) {
                                                            resumeTimer(
                                                                actualIndex);
                                                          } else {
                                                            pauseTimer(
                                                                actualIndex);
                                                          }
                                                        } else {
                                                          startTimer(
                                                              actualIndex); // Start the timer if it's not running
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        minimumSize:
                                                            const Size(30, 30),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        challenge['isPaused']
                                                            ? Icons.play_arrow
                                                            : Icons.pause,
                                                        size: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        minimumSize:
                                                            const Size(30, 30),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                      onPressed: () => stopTimer(
                                                          actualIndex), // Call stopTimer here
                                                      child: const Icon(
                                                        Icons.stop,
                                                        size: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                minimumSize: const Size(30, 30),
                                              ),
                                              onPressed: () =>
                                                  startTimer(actualIndex),
                                              child: const Row(
                                                mainAxisSize: MainAxisSize
                                                    .min, // Keep the button as small as the content
                                                children: [
                                                  // Space between icon and text
                                                  Text(
                                                    'Begin',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .black), // Optional: Set text color to black
                                                  ),
                                                ],
                                              ),
                                            ));
                            } else {
                              return Container(); // Return an empty container if out of bounds
                            }
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),

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
            const SizedBox(height: 5),

            if (allChallengesCompleted())
              Center(
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Call the function to update the task set for the next day

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
    );
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }
}

class ChallengeTile extends StatelessWidget {
  final String title;
  final String time;
  final String instructions;
  final int progress;
  final bool isDone;
  final bool isExpanded;
  final bool isPriority; // New field for priority
  final ValueChanged<bool?>? onChanged;
  final ValueChanged<bool>? onExpansionChanged;
  final VoidCallback? onPriorityChanged; // Callback for priority toggle
  final Widget trailing;

  const ChallengeTile({
    Key? key,
    required this.title,
    required this.time,
    required this.instructions,
    required this.progress,
    required this.isDone,
    required this.isExpanded,
    required this.isPriority, // Add this field
    required this.onChanged,
    required this.onExpansionChanged,
    required this.onPriorityChanged, // Add this field
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 0),
      elevation: 10,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(250, 72, 128, 239),
              Color.fromARGB(255, 255, 255, 255)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), // Rounded top-left corner
            bottomRight: Radius.circular(20), // Rounded bottom-right corner
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text(
                time as String,
                style: TextStyle(color: Colors.black),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isPriority ? Icons.star : Icons.star_border, // Star icon
                      color: isPriority
                          ? const Color.fromARGB(255, 255, 17, 0)
                          : const Color.fromARGB(
                              255, 0, 0, 0), // Red if priority
                      size: 20, // Smaller size
                    ),
                    onPressed: onPriorityChanged, // Toggle priority
                  ),
                  trailing, // Existing trailing widget
                ],
              ),
              leading: Checkbox(
                value: isDone,
                onChanged: onChanged,
              ),
              onTap: () {
                onExpansionChanged!(!isExpanded);
              },
            ),
            if (isExpanded) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  instructions,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
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

  @override
  Widget build(BuildContext context) {
    // Generate a random index to select a tip
    final randomIndex = Random().nextInt(tips.length);
    final motivationalTip = tips[randomIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Status Update',
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
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // Online image
                    Image.asset(
                      'assets/images/re1.jpg', // Replace with your online image URL
                      width: double
                          .infinity, // Set width to fit the whole container
                      height: 200, // Set the desired height
                      fit: BoxFit.cover, // Cover the entire space
                    ),
                    const SizedBox(height: 10),

                    // Congratulations message with animated text
                    const AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 500),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 56, 155, 236),
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
