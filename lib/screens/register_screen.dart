import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String ownerName = '';
  String rcNumber = '';
  String vehicleNumber = '';
  double passwordStrengthValue = 0;

  // RC Number Validation
  bool isRCValid(String rc) {
    final pattern = RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z]{1,2}[0-9]{4}$');
    return pattern.hasMatch(rc);
  }

  // Password Strength Function (manual replacement for password_strength)
  double estimatePasswordStrength(String password) {
    int score = 0;
    if (password.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;
    return score / 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 231, 246, 1), // light purple background
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(20),
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white.withAlpha((0.95 * 255).toInt()), // semi-transparent
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Register & RC Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.deepPurple.withAlpha((0.5*255).toInt())),
                        filled: true,
                        fillColor: Colors.deepPurple.withAlpha((0.05*255).toInt()),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || !EmailValidator.validate(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      onChanged: (value) => email = value,
                    ),
                    const SizedBox(height: 15),

                    // Password
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.deepPurple.withAlpha((0.5*255).toInt())),
                        filled: true,
                        fillColor: Colors.deepPurple.withAlpha((0.05*255).toInt()),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 8) {
                          return "Min 8 characters";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        password = value;
                        setState(() {
                          passwordStrengthValue = estimatePasswordStrength(password);
                        });
                      },
                    ),
                    const SizedBox(height: 5),

                    // Password Strength Indicator
                    LinearProgressIndicator(
                      value: passwordStrengthValue,
                      backgroundColor: Colors.grey.shade300,
                      color: passwordStrengthValue < 0.3
                          ? Colors.red
                          : passwordStrengthValue < 0.7
                              ? Colors.orange
                              : Colors.green,
                    ),
                    const SizedBox(height: 15),

                    // Owner Name
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Owner Name",
                        filled: true,
                        fillColor: Colors.deepPurple.withAlpha((0.05*255).toInt()),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter owner name";
                        }
                        return null;
                      },
                      onChanged: (value) => ownerName = value,
                    ),
                    const SizedBox(height: 15),

                    // RC Number
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "RC Number",
                        filled: true,
                        fillColor: Colors.deepPurple.withAlpha((0.05*255).toInt()),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || !isRCValid(value.toUpperCase())) {
                          return "Invalid RC Number";
                        }
                        return null;
                      },
                      onChanged: (value) => rcNumber = value.toUpperCase(),
                    ),
                    const SizedBox(height: 15),

                    // Vehicle Number
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Vehicle Number",
                        filled: true,
                        fillColor: Colors.deepPurple.withAlpha((0.05*255).toInt()),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter vehicle number";
                        }
                        return null;
                      },
                      onChanged: (value) => vehicleNumber = value.toUpperCase(),
                    ),
                    const SizedBox(height: 25),

                    // Register Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Fluttertoast.showToast(
                              msg: "Registered Successfully!",
                              toastLength: Toast.LENGTH_SHORT);
                          // TODO: Save details offline (Hive/SQLite)
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
