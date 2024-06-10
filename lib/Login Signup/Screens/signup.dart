import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Login%20Signup/Screens/home_screen.dart';
import 'package:flutter_firebase/Login%20Signup/Screens/login.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';
import '../../Widgets/toast.dart';
import '../Services/authentication.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    super.dispose();
  }

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
                  height: height / 2.8,
                  child: Image.asset("images/signup.jpg"),
                ),
                TextFieldInputWidget(
                  hintText: "Enter your Name",
                  textEditingController: nameController,
                  icon: Icons.person,
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
                MyButton(
                    onTap: () {
                      _signUp();
                    },
                    text: "Sign Up"),
                SizedBox(
                  height: height / 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
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

  void _signUp() async {
    setState(() {
      isLoading = true;
    });

    String username = nameController.text;
    String email = emailController.text;
    String password = passController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

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
