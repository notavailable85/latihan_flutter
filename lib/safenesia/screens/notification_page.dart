import 'package:flutter/material.dart';

class SnNotificationPage extends StatefulWidget {
  const SnNotificationPage({super.key});

  @override
  State<SnNotificationPage> createState() => _SnNotificationPageState();
}

class _SnNotificationPageState extends State<SnNotificationPage> {
  List notificationList = [
    {
      "title": "Pendaftaran Berhasil",
      "message": "Anda berhasil mendaftar Pelatihan K3 Umum.",
      "time": "5 menit lalu",
      "icon": Icons.check_circle,
      "color": Colors.green,
      "isRead": false,
    },
    {
      "title": "Jadwal Pelatihan",
      "message": "Pelatihan Fire Safety dimulai besok pukul 08:00.",
      "time": "1 jam lalu",
      "icon": Icons.calendar_today,
      "color": Colors.orange,
      "isRead": false,
    },
    {
      "title": "Sertifikat Tersedia",
      "message": "Sertifikat Anda sudah dapat diunduh.",
      "time": "Kemarin",
      "icon": Icons.workspace_premium,
      "color": Colors.blue,
      "isRead": true,
    },
    {
      "title": "Promo Pelatihan",
      "message": "Dapatkan diskon 20% untuk pelatihan bulan ini.",
      "time": "2 hari lalu",
      "icon": Icons.local_offer,
      "color": Colors.red,
      "isRead": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Notifikasi"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,

        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var item in notificationList) {
                  item["isRead"] = true;
                }
              });
            },

            child: const Text(
              "Baca Semua",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),

      body: notificationList.isEmpty
          ? const Center(
              child: Text(
                "Belum ada notifikasi",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: notificationList.length,

              itemBuilder: (context, index) {
                final item = notificationList[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),

                  child: Container(
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),

                      boxShadow: [
                        BoxShadow(blurRadius: 5, color: Colors.grey.shade300),
                      ],
                    ),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        /// ICON
                        Container(
                          padding: const EdgeInsets.all(12),

                          decoration: BoxDecoration(
                            color: (item["color"] as Color).withOpacity(0.15),

                            shape: BoxShape.circle,
                          ),

                          child: Icon(
                            item["icon"] as IconData,

                            color: item["color"] as Color,
                          ),
                        ),

                        const SizedBox(width: 15),

                        /// CONTENT
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              /// TITLE
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item["title"],

                                      style: TextStyle(
                                        fontSize: 16,

                                        fontWeight: item["isRead"]
                                            ? FontWeight.normal
                                            : FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  if (item["isRead"] == false)
                                    Container(
                                      height: 10,
                                      width: 10,

                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              /// MESSAGE
                              Text(
                                item["message"],

                                style: TextStyle(
                                  color: Colors.grey.shade700,

                                  height: 1.5,
                                ),
                              ),

                              const SizedBox(height: 10),

                              /// TIME
                              Text(
                                item["time"],

                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
