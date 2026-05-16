import 'package:flutter/material.dart';

class LatihanColumn extends StatelessWidget {
  const LatihanColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Column")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // spacing: 50,
        children: [
          Text("Rania"),
          Text("Selamat Ulang Tahun"),
          Text("Mana Traktirannya?"),
        ],
      ),
    );
  }
}
