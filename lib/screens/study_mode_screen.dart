import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class StudyModeScreen extends StatefulWidget {
  const StudyModeScreen({super.key});

  @override
  _StudyModeScreenState createState() => _StudyModeScreenState();
}

class _StudyModeScreenState extends State<StudyModeScreen> {
  final List<String> motivationalTips = [
    'Break your study sessions into achievable tasks to maintain focus and track progress.',
    'After completing a task, give yourself a small reward, like a break or snack.',
    'Keep your study space tidy and your materials organized to reduce distractions.',
    'Remind yourself of your progress and accomplishments to stay motivated.',
    'Use mnemonic devices or memory techniques to help remember key information.',
    'Take short, regular breaks to avoid burnout and maintain concentration.',
    'Set specific, achievable goals for each study session to stay focused.',
    'Try different study methods to find what works best for you.',
    'Stay hydrated and eat healthy snacks to keep your energy levels up.',
    'Visualize your success to boost motivation and confidence.',
  ];

  late List<String> displayedTips;
  Duration remainingTime = Duration.zero;
  Timer? _timer;
  double moodValue = 50;
  double motivationValue = 50;
  String? selectedEnvironment;
  DateTime? _startTime;
  DateTime? _endTime;

  @override
  void initState() {
    super.initState();
    _selectRandomTips();
  }

  void _selectRandomTips() {
    final random = Random();
    displayedTips = List.generate(
        2, (_) => motivationalTips[random.nextInt(motivationalTips.length)]);
  }

  void _startTimer(Duration duration) {
    _timer?.cancel();

    _startTime = DateTime.now();
    _endTime = _startTime!.add(duration);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = _endTime!.difference(DateTime.now());
        if (remainingTime <= Duration.zero) {
          _timer?.cancel();
          remainingTime = Duration.zero;
          _showTimeOverDialog();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      remainingTime = Duration.zero;
    });
  }

  void _resumeTimer() {
    if (_endTime != null && _endTime!.isAfter(DateTime.now())) {
      remainingTime = _endTime!.difference(DateTime.now());
      _startTimer(remainingTime);
    }
  }

  String _formatDuration(Duration duration) {
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _showTimeOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFE1F5FE),
          title: const Text('Your Study Session is Over. Take a Break!',
              style: TextStyle(color: Colors.black, fontSize: 18)),
          actions: [
            TextButton(
              child:
                  const Text('OK', style: TextStyle(color: Color(0xFF03A9F4))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _suggestStudy() {
    String category = _categorizeUser();

    String suggestionMessage;
    int? studyTime;

    if (category == 'Not Ready') {
      suggestionMessage =
          'It\'s not a good time to study now. Take a break and try again later.';
    } else if (category == 'Short Study') {
      suggestionMessage =
          'You can study for 15 minutes. Do you want to start the timer?';
      studyTime = 15;
    } else if (category == 'Full Study') {
      suggestionMessage =
          'You can study for 25 minutes. Do you want to start the timer?';
      studyTime = 25;
    } else {
      suggestionMessage = 'Your input doesn\'t match any category.';
    }

    _showSuggestionDialog('Suggestion', suggestionMessage,
        studyTime: studyTime);
  }

  String _categorizeUser() {
    if (moodValue < 50 &&
        motivationValue < 50 &&
        selectedEnvironment == 'Busy') {
      return 'Not Ready';
    } else if (moodValue >= 50 &&
        motivationValue >= 50 &&
        selectedEnvironment == 'Busy') {
      return 'Short Study';
    } else if (moodValue >= 50 &&
        motivationValue >= 50 &&
        selectedEnvironment == 'Calm') {
      return 'Full Study';
    }
    return 'Not Ready';
  }

  void _showSuggestionDialog(String title, String content, {int? studyTime}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFE1F5FE),
          title: Text(title,
              style: const TextStyle(color: Colors.black, fontSize: 18)),
          content: Text(content, style: const TextStyle(color: Colors.black)),
          actions: [
            if (studyTime != null)
              TextButton(
                child: const Text('Start Timer',
                    style: TextStyle(color: Color(0xFF03A9F4))),
                onPressed: () {
                  Navigator.of(context).pop();
                  _startTimer(Duration(minutes: studyTime));
                },
              ),
            TextButton(
              child: const Text('cancel',
                  style: TextStyle(color: Color(0xFF03A9F4))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_endTime != null && remainingTime > Duration.zero) {
      _resumeTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                  height: 50), // Gap between screen head and back button
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Motivational Tips',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 57, 57, 58),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  'assets/images/study.jpg',
                  width: 300,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              ...displayedTips.map((tip) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: const Color.fromARGB(255, 184, 226, 246),
                      child: Padding(
                        padding: const EdgeInsets.all(17),
                        child: Text(
                          tip,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  'Start Studying with Us',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mood',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: moodValue,
                            min: 0,
                            max: 100,
                            activeColor:
                                const Color.fromARGB(255, 27, 183, 234),
                            inactiveColor:
                                const Color(0xFF03A9F4).withOpacity(0.2),
                            onChanged: (value) {
                              setState(() {
                                moodValue = value;
                              });
                            },
                          ),
                        ),
                        Text('${moodValue.round()}%'),
                      ],
                    ),
                    const Text('Motivation',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: motivationValue,
                            min: 0,
                            max: 100,
                            activeColor:
                                const Color.fromARGB(255, 27, 183, 234),
                            inactiveColor:
                                const Color(0xFF03A9F4).withOpacity(0.2),
                            onChanged: (value) {
                              setState(() {
                                motivationValue = value;
                              });
                            },
                          ),
                        ),
                        Text('${motivationValue.round()}%'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Select Environment',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Align buttons to the left
                      children: ['Calm', 'Busy', 'Outdoor']
                          .map((env) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        5.0), // Set horizontal gap to 5px
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedEnvironment == env
                                        ? Colors.blue
                                        : Colors.lightBlue[100],
                                    foregroundColor: selectedEnvironment == env
                                        ? Colors.white
                                        : Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedEnvironment = env;
                                    });
                                  },
                                  child: Text(env),
                                ),
                              ))
                          .toList(),
                    ),

                    const SizedBox(
                        height: 30), // Increased vertical gap to 30px
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 92, 199, 249),
                          minimumSize:
                              const Size(250, 45), // Increased button size
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        onPressed: _suggestStudy,
                        child: const Text(
                          'Get Study Suggestion',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.white), // Increased font size
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.black),
                        const SizedBox(width: 8),
                        Text(
                          'Remaining Time: ${_formatDuration(remainingTime)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 92, 199, 249),
                          minimumSize: const Size(150, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        onPressed: _stopTimer,
                        child: const Text(
                          'Stop Timer',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
