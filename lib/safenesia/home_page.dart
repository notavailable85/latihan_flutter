import 'package:flutter/material.dart';
import 'package:latihan_flutter/safenesia/catalog_page.dart';
import 'package:latihan_flutter/safenesia/notification_page.dart';
import 'package:latihan_flutter/safenesia/profile_page.dart';
import 'package:latihan_flutter/safenesia/search_page.dart';

class SnHomePage extends StatefulWidget {
  const SnHomePage({super.key});

  @override
  State<SnHomePage> createState() => _SnHomePageState();
}

class _SnHomePageState extends State<SnHomePage> {
  final TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text("Aplikasi Pelatihan"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SnNotificationPage()),
              );
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selamat Datang 👋",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Crash",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// SEARCH
                  TextField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SnSearchPage(keyword: value),
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Cari pelatihan...",
                      prefixIcon: const Icon(Icons.search),

                      suffixIcon: IconButton(
                        onPressed: () {
                          if (searchController.text.trim().isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SnSearchPage(
                                  keyword: searchController.text,
                                ),
                              ),
                            );
                          }
                        },

                        icon: const Icon(Icons.arrow_forward),
                      ),

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// MENU
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  menuItem(Icons.school, "Pelatihan", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SnCatalogPage(),
                      ),
                    );
                    // Pindah halaman atau jalankan fungsi di sini
                  }),
                  menuItem(Icons.assignment, "Sertifikat", () {
                    print("Menu Sertifikat ditekan");
                  }),
                  menuItem(Icons.calendar_month, "Jadwal", () {
                    print("Menu Jadwal ditekan");
                  }),
                  menuItem(Icons.person, "Profile", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SnProfilePage(),
                      ),
                    );

                    // print("Menu Profile ditekan");
                  }),
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),

            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       menuItem(Icons.school, "Pelatihan"),
            //       menuItem(Icons.assignment, "Sertifikat"),
            //       menuItem(Icons.calendar_month, "Jadwal"),
            //       menuItem(Icons.person, "Profile"),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 25),

            /// TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Pelatihan Populer",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  TextButton(
                    onPressed: () {},
                    child: const Text("Lihat Semua"),
                  ),
                ],
              ),
            ),

            /// LIST PELATIHAN
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,

              itemBuilder: (context, index) {
                return trainingCard(
                  title: "Pelatihan K3 Umum",
                  subtitle: "Sertifikasi Kemnaker RI",
                  date: "25 Mei 2026",
                );
              },
            ),
          ],
        ),
      ),

      /// BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Kelas"),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  /// MENU ITEM
  Widget menuItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap, // <-- Ini yang membuat ikon bisa ditekan
      borderRadius: BorderRadius.circular(8), // Efek riak air yang rapi
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.blue,
            ), // Sesuaikan warna & ukuran
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
  // Widget menuItem(IconData icon, String title) {
  //   return Column(
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.all(18),

  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(18),
  //           boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey.shade300)],
  //         ),

  //         child: Icon(icon, size: 30, color: Colors.blue),
  //       ),

  //       const SizedBox(height: 8),

  //       Text(title),
  //     ],
  //   );
  // }

  /// TRAINING CARD
  Widget trainingCard({
    required String title,
    required String subtitle,
    required String date,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

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
              height: 70,
              width: 70,

              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(15),
              ),

              child: const Icon(Icons.school, color: Colors.blue, size: 40),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(subtitle, style: const TextStyle(color: Colors.grey)),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.blue,
                      ),

                      const SizedBox(width: 5),

                      Text(date),
                    ],
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {},

              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),

              child: const Text(
                "Daftar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
