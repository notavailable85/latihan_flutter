import 'package:flutter/material.dart';

class SnPaymentPage extends StatefulWidget {
  final int totalPrice;

  const SnPaymentPage({super.key, required this.totalPrice});

  @override
  State<SnPaymentPage> createState() => _SnPaymentPageState();
}

class _SnPaymentPageState extends State<SnPaymentPage> {
  int selectedPayment = 0;

  List paymentMethod = [
    {
      "title": "Transfer Bank",
      "subtitle": "BCA, Mandiri, BNI",
      "icon": Icons.account_balance,
    },
    {
      "title": "E-Wallet",
      "subtitle": "OVO, DANA, GoPay",
      "icon": Icons.account_balance_wallet,
    },
    {
      "title": "Credit Card",
      "subtitle": "Visa & Mastercard",
      "icon": Icons.credit_card,
    },
  ];

  String formatRupiah(int value) {
    return "Rp ${value.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Pembayaran"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          /// LIST PAYMENT
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),

              children: [
                const Text(
                  "Pilih Metode Pembayaran",

                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                /// PAYMENT METHOD
                ListView.builder(
                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: paymentMethod.length,

                  itemBuilder: (context, index) {
                    final item = paymentMethod[index];

                    final isSelected = selectedPayment == index;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),

                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedPayment = index;
                          });
                        },

                        borderRadius: BorderRadius.circular(18),

                        child: Container(
                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(18),

                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.transparent,

                              width: 2,
                            ),

                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.grey.shade300,
                              ),
                            ],
                          ),

                          child: Row(
                            children: [
                              /// ICON
                              Container(
                                padding: const EdgeInsets.all(15),

                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,

                                  borderRadius: BorderRadius.circular(15),
                                ),

                                child: Icon(
                                  item["icon"] as IconData,

                                  color: Colors.blue,

                                  size: 30,
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
                                      item["subtitle"],

                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// CHECK
                              Icon(
                                isSelected
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off,

                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          /// BOTTOM
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
                /// TOTAL
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      "Total Pembayaran",

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      formatRupiah(widget.totalPrice),

                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,

                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Pembayaran Berhasil"),

                            content: const Text(
                              "Terima kasih, pembayaran Anda berhasil diproses.",
                            ),

                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  Navigator.pop(context);
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),

                                child: const Text(
                                  "OK",

                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    child: const Text(
                      "Bayar Sekarang",

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
}
