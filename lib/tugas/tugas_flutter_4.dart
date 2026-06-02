import 'package:flutter/material.dart';

class TugasFlutter4 extends StatelessWidget {
  const TugasFlutter4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manajemen Data Pelanggan",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // ROOT WIDGET HARUS LISTVIEW
      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          // =========================
          // BAGIAN FORM
          // =========================

          // TEXTFIELD 1
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: "Nama",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          // TEXTFIELD 2
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              labelText: "Nomor Hp",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          // TEXTFIELD 3
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          // TEXTFIELD 4
          const TextField(
            maxLines: 3,
            decoration: InputDecoration(
              // prefixIcon: Icon(Icons.home),
              labelText: "Alamat",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 24),

          // JUDUL LIST
          const Text(
            "Daftar Pelanggan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          // =========================
          // LIST TILE
          // =========================
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text("Andi Rahmat"),
            subtitle: const Text("Status: Aktif"),
            trailing: const Icon(Icons.arrow_forward_ios),
            tileColor: Colors.blue[50],
          ),

          const SizedBox(height: 10),

          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text("Budi Santoso"),
            subtitle: const Text("Status: Non-Aktif"),
            trailing: const Icon(Icons.arrow_forward_ios),
            tileColor: Colors.blue[50],
          ),

          const SizedBox(height: 10),

          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text("Citra Natalia"),
            subtitle: const Text("Status: Aktif"),
            trailing: const Icon(Icons.arrow_forward_ios),
            tileColor: Colors.blue[50],
          ),

          const SizedBox(height: 10),

          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text("Dewi Lestari"),
            subtitle: const Text("Status: Pending"),
            trailing: const Icon(Icons.arrow_forward_ios),
            tileColor: Colors.blue[50],
          ),

          const SizedBox(height: 10),

          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text("Eko Prasetyo"),
            subtitle: const Text("Status: Aktif"),
            trailing: const Icon(Icons.arrow_forward_ios),
            tileColor: Colors.blue[50],
          ),
        ],
      ),
    );
  }
}
