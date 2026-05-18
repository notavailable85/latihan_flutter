import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TugasFlutter3 extends StatelessWidget {
  const TugasFlutter3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registrasi & Katalog",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // AREA SCROLL UTAMA
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TEXTFIELD 1
            const TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.person, color: Colors.blue),

                labelText: "Nama Lengkap",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // TEXTFIELD 2
            const TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.email, color: Colors.blue),

                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // TEXTFIELD 3
            const TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.phone, color: Colors.blue),
                labelText: "No. HP",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // TEXTFIELD 4
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Deskripsi",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Galeri Produk",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // GRIDVIEW
            GridView.count(
              // WAJIB
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,

              children: [
                // ITEM 1
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage("assets/images/safety_glass.png"),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: Center(
                        child: Container(
                          height: 25,
                          width: 155,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Safety Glasses",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ITEM 2
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage("assets/images/helm_safety.png"),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: Center(
                        child: Container(
                          height: 25,
                          width: 155,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Safety Helmet",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ITEM 3
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage("assets/images/safety_shoes.png"),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: Center(
                        child: Container(
                          height: 25,
                          width: 155,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Safety Shoes",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ITEM 4
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage("assets/images/body_harness.png"),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: Center(
                        child: Container(
                          height: 25,
                          width: 155,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Body Harness",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ITEM 5
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage("assets/images/safety_gloves.png"),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: Center(
                        child: Container(
                          height: 25,
                          width: 155,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Safety Gloves",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ITEM 6
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage("assets/images/safety_vest.png"),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: Center(
                        child: Container(
                          height: 25,
                          width: 155,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Safety Vest",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
