import 'package:flutter/material.dart';

class SnCartPage extends StatefulWidget {
  const SnCartPage({super.key});

  @override
  State<SnCartPage> createState() => _SnCartPageState();
}

class _SnCartPageState extends State<SnCartPage> {
  List cartList = [
    {
      "title": "Pelatihan K3 Umum",
      "category": "K3",
      "price": 2500000,
      "qty": 1,
    },
    {
      "title": "Pelatihan Fire Safety",
      "category": "Safety",
      "price": 1500000,
      "qty": 1,
    },
  ];

  int get totalPrice {
    int total = 0;

    for (var item in cartList) {
      total += (item["price"] as int) * (item["qty"] as int);
    }

    return total;
  }

  String formatRupiah(int value) {
    return "Rp ${value.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Keranjang"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: cartList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey.shade400,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Keranjang Kosong",

                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Belum ada pelatihan dipilih",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                /// LIST CART
                Expanded(
                  child: ListView.builder(
                    itemCount: cartList.length,

                    itemBuilder: (context, index) {
                      final item = cartList[index];

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
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.grey.shade300,
                              ),
                            ],
                          ),

                          child: Row(
                            children: [
                              /// IMAGE
                              Container(
                                height: 80,
                                width: 80,

                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,

                                  borderRadius: BorderRadius.circular(15),
                                ),

                                child: const Icon(
                                  Icons.school,
                                  size: 40,
                                  color: Colors.blue,
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

                                    const SizedBox(height: 5),

                                    Text(
                                      item["category"],

                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Text(
                                      formatRupiah(item["price"]),

                                      style: const TextStyle(
                                        color: Colors.blue,

                                        fontWeight: FontWeight.bold,

                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 15),

                                    /// QTY
                                    Row(
                                      children: [
                                        qtyButton(
                                          icon: Icons.remove,

                                          onTap: () {
                                            setState(() {
                                              if (item["qty"] > 1) {
                                                item["qty"]--;
                                              }
                                            });
                                          },
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),

                                          child: Text(
                                            item["qty"].toString(),

                                            style: const TextStyle(
                                              fontSize: 18,

                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        qtyButton(
                                          icon: Icons.add,

                                          onTap: () {
                                            setState(() {
                                              item["qty"]++;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              /// DELETE
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    cartList.removeAt(index);
                                  });
                                },

                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// TOTAL
                Container(
                  padding: const EdgeInsets.all(20),

                  decoration: const BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            "Total",

                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            formatRupiah(totalPrice),

                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
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
                            "Checkout",

                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  /// QTY BUTTON
  Widget qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(8),

      child: Container(
        padding: const EdgeInsets.all(5),

        decoration: BoxDecoration(
          color: Colors.blue.shade50,

          borderRadius: BorderRadius.circular(8),
        ),

        child: Icon(icon, color: Colors.blue),
      ),
    );
  }
}
