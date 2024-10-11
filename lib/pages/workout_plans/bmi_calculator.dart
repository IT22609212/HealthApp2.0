import 'package:flutter/material.dart';
import 'package:my_first_app/navbar/bottom_nav.dart';
import 'package:my_first_app/screens/dashboard.dart';
import 'bmi_category.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
      home: const BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double height = 120; // Initial height value in cm
  double weight = 0.0; // Initial weight value in kg
  int age = 0; // Initial age
  String selectedGender = 'Not selected'; // Initial gender
  final TextEditingController _controllerHeight = TextEditingController();
  final TextEditingController _controllerWeight = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerHeight.text = height.toStringAsFixed(1);
    _controllerWeight.text = weight.toStringAsFixed(1);
    _controllerAge.text = age.toStringAsFixed(0);
  }

  void _updateHeight(String value) {
    double? newHeight = double.tryParse(value);
    if (newHeight != null) {
      setState(() {
        height = newHeight;
      });
    }
  }

  void _updateWeight(String value) {
    double? newWeight = double.tryParse(value);
    if (newWeight != null) {
      setState(() {
        weight = newWeight;
      });
    }
  }

  void _updateAge(String value) {
    int? newAge = int.tryParse(value);
    if (newAge != null) {
      setState(() {
        age = newAge;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BMI Calculator",
          style: TextStyle(color: Colors.white),
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
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Hide the keyboard on tap
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 16),
            // padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _genderButton('MALE', Icons.male, selectedGender == 'MALE'),
                    _genderButton(
                        'FEMALE', Icons.female, selectedGender == 'FEMALE'),
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  'Height(cm)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        controller: _controllerHeight,
                        keyboardType: TextInputType.number,
                        onSubmitted: (value) {
                          _updateHeight(value);
                        },
                        onChanged: (value) {
                          _updateHeight(value);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 231, 229, 229),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0), // Adjust padding
                        child: Slider(
                          value: height,
                          min: 50.0,
                          max: 280.0,
                          divisions: 120,
                          label: '${height.toStringAsFixed(1)} cm',
                          activeColor: Colors.blueAccent,
                          onChanged: (double newValue) {
                            setState(() {
                              height = newValue;
                              _controllerHeight.text =
                                  height.toStringAsFixed(1);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _weightControl('Weight(kg)', weight, (value) {
                      setState(() {
                        weight = value;
                      });
                    }),
                    _ageControl('Age', age, (value) {
                      setState(() {
                        age = value;
                      });
                    }),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 190,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            String errorMessage = "";
                            if (!(height >= 50.0 && height <= 280.0)) {
                              errorMessage += "Height: $height cm\n";
                            }
                            if (!(weight >= 10.0 && weight <= 650.0)) {
                              errorMessage += "Weight: $weight kg\n";
                            }
                            if (!(age >= 1 && age <= 120.0)) {
                              errorMessage += "Age: $age years\n";
                            }
                            if (selectedGender != 'MALE' &&
                                selectedGender != 'FEMALE') {
                              errorMessage += "Gender: $selectedGender\n";
                            }

                            if (errorMessage.isNotEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Invalid Input"),
                                    content: Text(
                                      "Please check the following values:\n$errorMessage \nThese values are not acceptable",
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              double heightInMeters = height / 100;
                              double bmi =
                                  weight / (heightInMeters * heightInMeters);

                              String category = "Unknown";

                              if (age < 18) {
                                if (bmi < 5) {
                                  category = "Underweight";
                                } else if (bmi >= 5 && bmi < 85) {
                                  category = "Average";
                                } else {
                                  category = "Overweight";
                                }
                              } else if (age >= 18 && age <= 65) {
                                if (selectedGender == 'MALE') {
                                  if (bmi < 18.5) {
                                    category = "Underweight";
                                  } else if (bmi >= 18.5 && bmi < 24.9) {
                                    category = "Average";
                                  } else if (bmi >= 25) {
                                    category = "Overweight";
                                  }
                                } else if (selectedGender == 'FEMALE') {
                                  if (bmi < 18.0) {
                                    category = "Underweight";
                                  } else if (bmi >= 18.0 && bmi < 24.0) {
                                    category = "Average";
                                  } else if (bmi >= 24.0) {
                                    category = "Overweight";
                                  }
                                }
                              } else {
                                if (selectedGender == 'MALE') {
                                  if (bmi < 22) {
                                    category = "Underweight";
                                  } else if (bmi >= 22 && bmi < 29) {
                                    category = "Average";
                                  } else {
                                    category = "Overweight";
                                  }
                                } else if (selectedGender == 'FEMALE') {
                                  if (bmi < 21) {
                                    category = "Underweight";
                                  } else if (bmi >= 21 && bmi < 28) {
                                    category = "Average";
                                  } else {
                                    category = "Overweight";
                                  }
                                }
                              }

                              if (category == "Unknown") {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text(
                                          "Invalid input! Please check your height, weight, age, or gender."),
                                      actions: [
                                        TextButton(
                                          child: const Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                // Navigate to CategoryScreen with the calculated category
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryScreen(category: category),
                                  ),
                                );
                              }
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Calculate',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _genderButton(String gender, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: isSelected
              ? (gender == 'MALE' ? Colors.lightBlue : Colors.pinkAccent)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 50,
              color: isSelected ? Colors.white : Colors.black54,
            ),
            Text(
              gender,
              style: TextStyle(
                fontSize: 18,
                color: isSelected ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _weightControl(String label, double value, Function(double) onChange) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 50,
          width: 100,
          child: TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            controller: _controllerWeight,
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              _updateWeight(value);
            },
            onChanged: (value) {
              _updateWeight(value);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(30.0)), // Adjust radius for rounding
                borderSide: BorderSide.none, // No visible border line
              ),
              filled: true, // Fill the background
              fillColor: Color.fromARGB(255, 231, 229, 229), // Background color
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide.none, // No border when focused
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide.none, // No border when enabled
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove_circle,
                  color: Colors.purpleAccent, size: 35),
              onPressed: () {
                if (value >= 0.1) {
                  double newWeight = value - 0.1;
                  onChange(newWeight);
                  _controllerWeight.text =
                      newWeight.toStringAsFixed(1); // Update the TextField
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_circle,
                  color: Colors.purpleAccent, size: 35),
              onPressed: () {
                if (value < 650) {
                  double newWeight = value + 0.1;
                  onChange(newWeight);
                  _controllerWeight.text =
                      newWeight.toStringAsFixed(1); // Update the TextField
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _ageControl(String label, int value, Function(int) onChange) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        // Text(
        //   value.toStringAsFixed(0),
        //   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        // ),
        SizedBox(
          height: 50,
          width: 100,
          child: TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            controller: _controllerAge,
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              _updateAge(value);
            },
            onChanged: (value) {
              _updateAge(value);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(30.0)), // Adjust radius for rounding
                borderSide: BorderSide.none, // No visible border line
              ),
              filled: true, // Fill the background
              fillColor: Color.fromARGB(255, 231, 229, 229), // Background color
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide.none, // No border when focused
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide.none, // No border when enabled
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove_circle,
                  color: Colors.purpleAccent, size: 35),
              onPressed: () {
                if (value > 1) {
                  int newAge = value - 1;
                  onChange(newAge);
                  _controllerAge.text =
                      newAge.toStringAsFixed(0); // Update the TextField
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_circle,
                  color: Colors.purpleAccent, size: 35),
              onPressed: () {
                if (value < 120) {
                  int newAge = age + 1;
                  onChange(newAge);
                  _controllerAge.text = newAge.toStringAsFixed(0);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
