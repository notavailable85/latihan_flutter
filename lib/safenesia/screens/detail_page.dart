import 'package:flutter/material.dart';

class SnDetailPage extends StatelessWidget {
  final String title;
  final String category;
  final String price;
  final String date;

  const SnDetailPage({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: CustomScrollView(
        slivers: [
          /// APP BAR
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,

            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,

            flexibleSpace: FlexibleSpaceBar(
              title: Text(title, style: const TextStyle(fontSize: 16)),

              background: Container(
                color: Colors.blue,

                child: const Center(
                  child: Icon(Icons.school, size: 100, color: Colors.white),
                ),
              ),
            ),
          ),

          /// CONTENT
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  /// CATEGORY
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      category,

                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// TITLE
                  Text(
                    title,

                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// PRICE
                  Row(
                    children: [
                      const Icon(Icons.payments, color: Colors.green),

                      const SizedBox(width: 10),

                      Text(
                        price,

                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// DATE
                  detailItem(
                    icon: Icons.calendar_today,
                    title: "Tanggal Pelatihan",
                    value: date,
                  ),

                  const SizedBox(height: 15),

                  detailItem(
                    icon: Icons.location_on,
                    title: "Lokasi",
                    value: "Jakarta, Indonesia",
                  ),

                  const SizedBox(height: 15),

                  detailItem(
                    icon: Icons.access_time,
                    title: "Durasi",
                    value: "3 Hari",
                  ),

                  const SizedBox(height: 15),

                  detailItem(
                    icon: Icons.workspace_premium,
                    title: "Sertifikat",
                    value: "Sertifikat Resmi",
                  ),

                  const SizedBox(height: 30),

                  /// DESCRIPTION
                  const Text(
                    "Deskripsi Pelatihan",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Pelatihan ini dirancang untuk meningkatkan kompetensi peserta dalam bidang keselamatan dan kesehatan kerja (K3). Peserta akan mempelajari teori, praktik, dan implementasi standar keselamatan kerja sesuai regulasi yang berlaku.",

                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// BENEFIT
                  const Text(
                    "Benefit",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  benefitItem("Materi lengkap dan up-to-date"),

                  benefitItem("Instruktur profesional"),

                  benefitItem("Sertifikat resmi"),

                  benefitItem("Coffee break & makan siang"),

                  benefitItem("Networking profesional"),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      /// BUTTON
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),

        decoration: const BoxDecoration(color: Colors.white),

        child: SizedBox(
          height: 55,

          child: ElevatedButton(
            onPressed: () {},

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),

            child: const Text(
              "Daftar Sekarang",

              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  /// DETAIL ITEM
  Widget detailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),

        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey.shade300)],
      ),

      child: Row(
        children: [
          Icon(icon, color: Colors.blue),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 5),

                Text(
                  value,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// BENEFIT ITEM
  Widget benefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),

          const SizedBox(width: 10),

          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
