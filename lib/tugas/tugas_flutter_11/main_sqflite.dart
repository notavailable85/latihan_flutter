import 'package:flutter/material.dart';
import '../tugas_flutter_11/database_helper.dart';
import '../tugas_flutter_11/peserta_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safenesia',
      debugShowCheckedModeBanner: false,
      home: const PendaftaranPage(),
    );
  }
}

class PendaftaranPage extends StatefulWidget {
  const PendaftaranPage({super.key});

  @override
  State<PendaftaranPage> createState() => _PendaftaranPageState();
}

class _PendaftaranPageState extends State<PendaftaranPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final hpController = TextEditingController();
  final kotaController = TextEditingController();
  final pelatihanController = TextEditingController();

  List<Peserta> daftarPeserta = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    hpController.dispose();
    kotaController.dispose();
    pelatihanController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    final data = await DatabaseHelper.instance.getPeserta();

    setState(() {
      daftarPeserta = data;
    });
  }

  Future<void> simpanData() async {
    if (_formKey.currentState!.validate()) {
      final peserta = Peserta(
        nama: namaController.text.trim(),
        email: emailController.text.trim(),
        noHp: hpController.text.trim(),
        kota: kotaController.text.trim(),
        pelatihan: pelatihanController.text.trim(),
      );

      await DatabaseHelper.instance.insertPeserta(peserta);

      namaController.clear();
      emailController.clear();
      hpController.clear();
      kotaController.clear();
      pelatihanController.clear();

      await loadData();

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Pendaftaran Berhasil"),
            content: const Text(
              "Peserta berhasil didaftarkan ke pelatihan Safenesia.",
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> hapusPeserta(int id) async {
    await DatabaseHelper.instance.deletePeserta(id);

    await loadData();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data peserta berhasil dihapus")),
    );
  }

  Future<void> konfirmasiHapus(Peserta peserta) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Peserta"),
          content: Text("Yakin ingin menghapus ${peserta.nama}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                hapusPeserta(peserta.id!);
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$label wajib diisi";
        }

        if (label == "Email") {
          if (!value.contains('@')) {
            return "Format email tidak valid";
          }
        }

        if (label == "Nomor HP") {
          if (value.length < 10) {
            return "Nomor HP tidak valid";
          }
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Safenesia - Pendaftaran Pelatihan")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  buildTextField(
                    controller: namaController,
                    label: "Nama Peserta",
                  ),

                  const SizedBox(height: 10),

                  buildTextField(
                    controller: emailController,
                    label: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 10),

                  buildTextField(
                    controller: hpController,
                    label: "Nomor HP",
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 10),

                  buildTextField(
                    controller: kotaController,
                    label: "Asal Kota",
                  ),

                  const SizedBox(height: 10),

                  buildTextField(
                    controller: pelatihanController,
                    label: "Nama Pelatihan",
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: simpanData,
                      child: const Text("Daftar Pelatihan"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Daftar Peserta",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Chip(label: Text("${daftarPeserta.length} Peserta")),
              ],
            ),

            const SizedBox(height: 10),

            Expanded(
              child: daftarPeserta.isEmpty
                  ? const Center(child: Text("Belum ada peserta terdaftar"))
                  : ListView.builder(
                      itemCount: daftarPeserta.length,
                      itemBuilder: (context, index) {
                        final peserta = daftarPeserta[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(peserta.nama[0].toUpperCase()),
                            ),
                            title: Text(peserta.nama),
                            subtitle: Text(
                              "${peserta.pelatihan}\n"
                              "${peserta.kota}\n"
                              "${peserta.email}",
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                konfirmasiHapus(peserta);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
