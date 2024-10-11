import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/screens/login_screen.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(''),
          centerTitle: true,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: FormExample(),
        ),
      ),
    );
  }
}

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _loginWithGoogle() {
    // Add logic for Google login
  }

  void _loginWithFacebook() {
    // Add logic for Facebook login
  }

  void _loginWithApple() {
    // Add logic for Apple login
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Sign up',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ///user name
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'User name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
                    },
                  ),

                  // Mobile number input field
                  const SizedBox(height: 16.00),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      hintText: 'Enter your mobile number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      final RegExp mobileRegExp = RegExp(r'^\+?\d{10,15}$');
                      if (!mobileRegExp.hasMatch(value)) {
                        return 'Please enter a valid mobile number';
                      }
                      return null;
                    },
                  ),

                  // Email input field
                  const SizedBox(height: 16.00),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // Password input field
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  // Login button with custom styling
                  SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process login
                        }
                      },
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Line below the login link
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: Divider(
                            color: Colors.grey[300],
                            thickness: 2,
                          ),
                        ),
                      ),
                      const Text(
                        'or',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10.0),
                          child: Divider(
                            color: Colors.grey[300],
                            thickness: 2,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  // Social media login buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.facebook, color: Colors.blue),
                        onPressed: _loginWithFacebook,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.g_mobiledata,
                            color: Colors.red), // Using Google icon
                        onPressed: _loginWithGoogle,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.apple, color: Colors.black),
                        onPressed: _loginWithApple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            text: 'Have an account? ',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Sign in',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FormExampleApp(
                          title: '',
                        ),
                      ),
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
