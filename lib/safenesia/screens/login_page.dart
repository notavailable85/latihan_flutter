import 'package:flutter/material.dart';
import 'package:latihan_flutter/safenesia/screens/forgotpassword_page.dart';
import 'package:latihan_flutter/safenesia/screens/home_page.dart';
import 'package:latihan_flutter/safenesia/screens/register_page.dart';

class SnLoginPage extends StatefulWidget {
  const SnLoginPage({super.key});

  @override
  State<SnLoginPage> createState() => _SnLoginPageState();
}

class _SnLoginPageState extends State<SnLoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),

                /// LOGO
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 70, color: Colors.blue),
                ),

                const SizedBox(height: 30),

                /// TITLE
                const Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Login to your account",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 40),

                /// EMAIL
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email wajib diisi";
                    }
                    if (!value.contains("@")) {
                      return "Format email tidak valid";
                    }
                    return null;
                  },

                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// PASSWORD
                TextFormField(
                  controller: passwordController,
                  obscureText: isHidden,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password wajib diisi";
                    }
                    if (value.length < 6) {
                      return "Password minimal 6 karakter";
                    }
                    return null;
                  },

                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),

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

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                /// FORGOT PASSWORD
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SnForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text("Forgot Password?"),
                  ),
                ),

                const SizedBox(height: 10),

                /// LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SnHomePage(),
                          ),
                        );
                      }
                      String email = emailController.text;
                      String password = passwordController.text;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Email: $email\nPassword: $password"),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// REGISTER
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SnRegisterPage(),
                          ),
                        );
                      },
                      child: const Text("Register"),
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
