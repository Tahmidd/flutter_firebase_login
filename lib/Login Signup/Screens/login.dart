import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Login%20Signup/Screens/home_screen.dart';
import 'package:flutter_firebase/Login%20Signup/Screens/signup.dart';
import 'package:flutter_firebase/Widgets/button.dart';
import 'package:flutter_firebase/Widgets/text_field.dart';

import '../../Widgets/toast.dart';
import '../Services/authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: height / 2.7,
                  child: Image.asset("images/login.jpg"),
                ),
                TextFieldInputWidget(
                  hintText: "Enter your Email",
                  textEditingController: emailController,
                  icon: Icons.email,
                ),
                TextFieldInputWidget(
                  hintText: "Enter your Password",
                  textEditingController: passController,
                  icon: Icons.lock,
                  isPass: true,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue),
                    ),
                  ),
                ),
                MyButton(
                    onTap: () {
                      _signIn();
                    },
                    text: "Login"),
                SizedBox(
                  height: height / 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      isLoading = true;
    });

    String email = emailController.text;
    String password = passController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      isLoading = false;
    });
    if (user != null) {
      showToast(message: 'User is successfully created');

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      showToast(message: 'Some error happend');
    }
  }
}
