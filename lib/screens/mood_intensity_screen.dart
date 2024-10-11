import 'package:flutter/material.dart';
import 'activity_suggestion_screen.dart';

class MoodIntensityScreen extends StatefulWidget {
  final String mood;

  const MoodIntensityScreen({super.key, required this.mood});

  @override
  _MoodIntensityScreenState createState() => _MoodIntensityScreenState();
}

class _MoodIntensityScreenState extends State<MoodIntensityScreen> {
  double _intensity = 0.5;
  final List<String> _selectedMoodWords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                      height: 60), // Vertical gap of 20px before the Row
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new,
                            size: 30, color: Color.fromARGB(255, 61, 164, 247)),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(
                          width:
                              10), // Horizontal gap of 10px between back button and image
                      Center(
                        child: Image.asset(
                          'assets/images/image.png',
                          width: 300,
                          height: 130,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                      height:
                          10), // Vertical gap of 10px between header and body
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10), // Reduced vertical gap
                        const Text(
                          'Energy',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 46, 47, 47),
                              fontWeight: FontWeight.bold),
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight:
                                5, // Reduced thickness of the slider track
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 10),
                          ),
                          child: Slider(
                            value: _intensity,
                            min: 0.0,
                            max: 1.0,
                            divisions: 10,
                            label: '${(_intensity * 100).toStringAsFixed(0)}%',
                            onChanged: (value) =>
                                setState(() => _intensity = value),
                            activeColor: const Color(0xFF248FDD),
                            inactiveColor:
                                const Color.fromARGB(255, 105, 196, 242),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            children: [
                              TextSpan(text: 'Which Words describe your '),
                              TextSpan(
                                text: 'Mood',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 61, 164, 247)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                            height:
                                40), // Increased gap between "Which Words describe your Mood" and mood chips
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal:
                                  16), // Add horizontal padding to ensure equal gap
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 15,
                            children: [
                              _buildMoodChip('Sympathetic', emoji: '🤗'),
                              _buildMoodChip('Loved', emoji: '❤️'),
                              _buildMoodChip('Excited', emoji: '😃'),
                              _buildMoodChip('OK', emoji: '👌'),
                              _buildMoodChip('Nervous', emoji: '😰'),
                              _buildMoodChip('Sentimental', emoji: '🥺'),
                              _buildMoodChip('Thankful', emoji: '🙏'),
                              _buildMoodChip('Joyful', emoji: '😊'),
                              _buildMoodChip('Positive', emoji: '👍'),
                              _buildMoodChip('Up', emoji: '⬆️'),
                              _buildMoodChip('Average', emoji: '😐'),
                              _buildMoodChip('Optimistic', emoji: '🌞'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ActivitySuggestionScreen(mood: widget.mood),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 92, 199, 249),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Next', style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodChip(String label, {String? emoji}) {
    final isSelected = _selectedMoodWords.contains(label);
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (isSelected) {
            _selectedMoodWords.remove(label);
          } else {
            _selectedMoodWords.add(label);
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.lightBlue[100],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      child: Text(emoji != null ? '$emoji $label' : label),
    );
  }
}
