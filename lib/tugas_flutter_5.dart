import 'package:flutter/material.dart';

class TugasFlutter5 extends StatefulWidget {
  const TugasFlutter5({super.key});

  @override
  State<TugasFlutter5> createState() => _TugasFlutter5State();
}

class _TugasFlutter5State extends State<TugasFlutter5> {
  // ElevatedButton
  bool showSecretText = false;

  // IconButton
  bool isFavorite = false;

  // TextButton
  bool showDescription = false;

  // GestureDetector Counter
  int counter = 10;

  // Pesan InkWell
  String inkwellMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab Interaksi Flutter"),
        centerTitle: true,
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter--;
          });
        },
        child: const Icon(Icons.remove),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =======================
            // ElevatedButton
            // =======================
            const Text(
              "1. ElevatedButton",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  showSecretText = !showSecretText;
                });
              },
              child: const Text("Klik Saya!"),
            ),

            const SizedBox(height: 10),

            if (showSecretText)
              const Text(
                "Halo, saya Developer!",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),

            const SizedBox(height: 30),

            // =======================
            // IconButton
            // =======================
            const Text(
              "2. IconButton",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 35,
                  ),
                ),

                const SizedBox(width: 10),

                Text(
                  isFavorite ? "Tersimpan di Favorit" : "Belum Disukai",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // =======================
            // TextButton
            // =======================
            const Text(
              "3. TextButton",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () {
                setState(() {
                  showDescription = !showDescription;
                });
              },
              child: const Text("Lihat Deskripsi"),
            ),

            if (showDescription)
              const Text(
                "Flutter adalah framework dari Google untuk membuat aplikasi mobile, web, dan desktop dengan tampilan menarik dan performa tinggi.",
                style: TextStyle(fontSize: 16),
              ),

            const SizedBox(height: 30),

            // =======================
            // InkWell
            // =======================
            const Text(
              "4. InkWell",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    inkwellMessage = "Sentuhan terdeteksi!";
                  });

                  print("Pesan rahasia dari InkWell");
                },
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Sentuh Kotak Ini",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(inkwellMessage, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 30),

            // =======================
            // GestureDetector
            // =======================
            const Text(
              "5. GestureDetector",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                setState(() {
                  counter += 1;
                });

                print("Ditekan sekali");
              },

              onDoubleTap: () {
                setState(() {
                  counter += 2;
                });

                print("Ditekan dua kali");
              },

              onLongPress: () {
                setState(() {
                  counter += 3;
                });

                print("Tahan lama");
              },

              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Angka: $counter",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "• Tap = +1\n"
              "• Double Tap = +2\n"
              "• Long Press = +3",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
