import 'package:flutter/material.dart';

class SnTransactionPage extends StatefulWidget {
  const SnTransactionPage({super.key});

  @override
  State<SnTransactionPage> createState() => _SnTransactionPageState();
}

class _SnTransactionPageState extends State<SnTransactionPage> {
  List transactionList = [
    {
      "title": "Pelatihan K3 Umum",
      "date": "25 Mei 2026",
      "price": "Rp 2.500.000",
      "status": "Berhasil",
    },
    {
      "title": "Pelatihan Fire Safety",
      "date": "20 Mei 2026",
      "price": "Rp 1.500.000",
      "status": "Pending",
    },
    {
      "title": "Pelatihan First Aid",
      "date": "15 Mei 2026",
      "price": "Rp 1.200.000",
      "status": "Dibatalkan",
    },
  ];

  Color statusColor(String status) {
    switch (status) {
      case "Berhasil":
        return Colors.green;

      case "Pending":
        return Colors.orange;

      case "Dibatalkan":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Riwayat Transaksi"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: transactionList.isEmpty
          ? const Center(
              child: Text(
                "Belum ada transaksi",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),

              itemCount: transactionList.length,

              itemBuilder: (context, index) {
                final item = transactionList[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),

                  child: Container(
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(18),

                      boxShadow: [
                        BoxShadow(blurRadius: 5, color: Colors.grey.shade300),
                      ],
                    ),

                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            /// IMAGE
                            Container(
                              height: 70,
                              width: 70,

                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,

                                borderRadius: BorderRadius.circular(15),
                              ),

                              child: const Icon(
                                Icons.school,
                                color: Colors.blue,
                                size: 35,
                              ),
                            ),

                            const SizedBox(width: 15),

                            /// CONTENT
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    item["title"],

                                    style: const TextStyle(
                                      fontSize: 18,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,

                                        size: 16,

                                        color: Colors.grey,
                                      ),

                                      const SizedBox(width: 5),

                                      Text(
                                        item["date"],

                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    item["price"],

                                    style: const TextStyle(
                                      color: Colors.blue,

                                      fontWeight: FontWeight.bold,

                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Divider(color: Colors.grey.shade300),

                        const SizedBox(height: 10),

                        /// STATUS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),

                              decoration: BoxDecoration(
                                color: statusColor(
                                  item["status"],
                                ).withOpacity(0.15),

                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Text(
                                item["status"],

                                style: TextStyle(
                                  color: statusColor(item["status"]),

                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            TextButton(
                              onPressed: () {},

                              child: const Text("Detail"),
                            ),
                          ],
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
