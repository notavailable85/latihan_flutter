import 'package:flutter/material.dart';

class SnSupportPage extends StatefulWidget {
  const SnSupportPage({super.key});

  @override
  State<SnSupportPage> createState() => _SnSupportPageState();
}

class _SnSupportPageState extends State<SnSupportPage> {
  final TextEditingController subjectController = TextEditingController();

  final TextEditingController messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Customer Support"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// HEADER
              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.support_agent,
                        color: Colors.blue,
                        size: 35,
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Butuh Bantuan?",

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            "Tim support kami siap membantu Anda.",

                            style: TextStyle(
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// CONTACT INFO
              const Text(
                "Kontak Support",

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              supportCard(
                icon: Icons.phone,
                title: "Telepon",
                subtitle: "+62 812 3456 7890",
              ),

              supportCard(
                icon: Icons.email,
                title: "Email",
                subtitle: "support@safenesia.com",
              ),

              supportCard(
                icon: Icons.location_on,
                title: "Alamat",
                subtitle: "Tangerang, Indonesia",
              ),

              const SizedBox(height: 30),

              /// FORM
              const Text(
                "Kirim Pesan",

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              /// SUBJECT
              TextFormField(
                controller: subjectController,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Subjek wajib diisi";
                  }

                  return null;
                },

                decoration: InputDecoration(
                  labelText: "Subjek",

                  prefixIcon: const Icon(Icons.title),

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// MESSAGE
              TextFormField(
                controller: messageController,

                maxLines: 6,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Pesan wajib diisi";
                  }

                  return null;
                },

                decoration: InputDecoration(
                  labelText: "Pesan",

                  alignLabelWithHint: true,

                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 80),

                    child: Icon(Icons.message),
                  ),

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Pesan berhasil dikirim")),
                      );

                      subjectController.clear();
                      messageController.clear();
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  icon: const Icon(Icons.send, color: Colors.white),

                  label: const Text(
                    "Kirim Pesan",

                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// SUPPORT CARD
  Widget supportCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(18),

          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey.shade300)],
        ),

        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: Colors.blue.shade50,

                borderRadius: BorderRadius.circular(15),
              ),

              child: Icon(icon, color: Colors.blue),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,

                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
