// main.dart
import 'package:flutter/material.dart';

// ================= LOGIN PAGE =================
class TugasFlutter6 extends StatefulWidget {
  const TugasFlutter6({super.key});

  @override
  State<TugasFlutter6> createState() => _TugasFlutter6State();
}

class _TugasFlutter6State extends State<TugasFlutter6> {
  // controller
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // state show/hide password
  bool isHiddenPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ================= LOGIN FUNCTION =================
  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email: $email\nPassword: $password')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ================= IMAGE =================
                  Image.asset("assets/images/logo_safenesia.png", height: 180),

                  const SizedBox(height: 30),

                  // ================= TITLE =================
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ================= EMAIL =================
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    suffixIcon: Icons.check_circle,
                    obscureText: false,
                    onSuffixTap: () {},
                  ),

                  const SizedBox(height: 20),

                  // ================= PASSWORD =================
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,

                    suffixIcon: isHiddenPassword
                        ? Icons.visibility_off
                        : Icons.visibility,

                    obscureText: isHiddenPassword,

                    onSuffixTap: () {
                      setState(() {
                        isHiddenPassword = !isHiddenPassword;
                      });
                    },
                  ),

                  const SizedBox(height: 35),

                  // ================= BUTTON =================
                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      onPressed: login,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),

                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= FOOTER =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: const [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),

                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= CUSTOM TEXTFIELD =================
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool obscureText;
  final VoidCallback onSuffixTap;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.obscureText,
    required this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,

      decoration: InputDecoration(
        hintText: hintText,

        prefixIcon: Icon(prefixIcon),

        suffixIcon: IconButton(onPressed: onSuffixTap, icon: Icon(suffixIcon)),

        filled: true,
        fillColor: const Color(0xFFF5F5F5),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}
