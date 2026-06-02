import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login UI',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// IMAGE
                Center(
                  child: Image.asset(
                    'assets/images/logo_safenesia.png',
                    height: 280,
                  ),
                ),

                const SizedBox(height: 20),

                /// TITLE
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Please login to your account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                  ),
                ),

                const SizedBox(height: 40),

                /// EMAIL FIELD
                const InputField(hintText: "Email", icon: Icons.email_outlined),

                const SizedBox(height: 20),

                /// PASSWORD FIELD
                InputField(
                  hintText: "Password",
                  icon: Icons.lock_outline,
                  obscureText: isHidden,

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    icon: Icon(
                      isHidden ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// FORGOT PASSWORD
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// LOGIN BUTTON
                PrimaryButton(text: "Login", onPressed: () {}),

                const SizedBox(height: 30),

                /// SIGN UP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Color(0xFF6B7280)),
                    ),

                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xFF2563EB),
                          fontWeight: FontWeight.bold,
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
}

/// ======================================
/// REUSABLE WIDGET INPUT FIELD
/// ======================================
class InputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;

  const InputField({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,

      decoration: InputDecoration(
        hintText: hintText,

        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),

        prefixIcon: Icon(icon, color: const Color(0xFF6B7280)),

        suffixIcon: suffixIcon,

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(vertical: 18),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
        ),
      ),
    );
  }
}

/// ======================================
/// REUSABLE WIDGET BUTTON
/// ======================================
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,

      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
