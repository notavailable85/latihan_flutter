import 'package:flutter/material.dart';

class SnEditProfilePage extends StatefulWidget {
  const SnEditProfilePage({super.key});

  @override
  State<SnEditProfilePage> createState() => _SnEditProfilePageState();
}

class _SnEditProfilePageState extends State<SnEditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController(
    text: "Crash",
  );

  final TextEditingController emailController = TextEditingController(
    text: "crash@email.com",
  );

  final TextEditingController phoneController = TextEditingController(
    text: "08123456789",
  );

  final TextEditingController addressController = TextEditingController(
    text: "Tangerang, Indonesia",
  );

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              /// PHOTO PROFILE
              Stack(
                children: [
                  Container(
                    height: 120,
                    width: 120,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue, width: 3),

                      image: const DecorationImage(
                        image: AssetImage("assets/images/profile.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,

                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),

                      child: IconButton(
                        onPressed: () {},

                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// NAME
              TextFormField(
                controller: nameController,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama wajib diisi";
                  }

                  return null;
                },

                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  prefixIcon: const Icon(Icons.person),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 20),

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
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// PHONE
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nomor HP wajib diisi";
                  }

                  return null;
                },

                decoration: InputDecoration(
                  labelText: "Nomor HP",
                  prefixIcon: const Icon(Icons.phone),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// ADDRESS
              TextFormField(
                controller: addressController,
                maxLines: 3,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Alamat wajib diisi";
                  }

                  return null;
                },

                decoration: InputDecoration(
                  labelText: "Alamat",
                  prefixIcon: const Icon(Icons.home),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              /// SAVE BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Profile berhasil diperbarui"),
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
                    "Simpan Perubahan",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
