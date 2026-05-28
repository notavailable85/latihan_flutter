import 'package:flutter/material.dart';

class SnForgotPasswordPage extends StatefulWidget {
  const SnForgotPasswordPage({super.key});

  @override
  State<SnForgotPasswordPage> createState() => _SnForgotPasswordPageState();
}

class _SnForgotPasswordPageState extends State<SnForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                /// ICON
                Container(
                  height: 120,
                  width: 120,

                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.lock_reset,
                    size: 70,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 30),

                /// TITLE
                const Text(
                  "Lupa Password?",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                /// DESCRIPTION
                const Text(
                  "Masukkan email Anda untuk menerima link reset password.",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 40),

                /// EMAIL FIELD
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
                    hintText: "Masukkan Email",
                    prefixIcon: const Icon(Icons.email),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// BUTTON SEND
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Link reset password dikirim ke ${emailController.text}",
                            ),
                          ),
                        );
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    child: const Text(
                      "Kirim",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// BACK LOGIN
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sudah ingat password?"),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: const Text("Login"),
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
