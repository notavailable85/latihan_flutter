import 'package:flutter/material.dart';

// IMPORT FILE TUGAS 7
import 'tugas_flutter_7.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Tugas Flutter 8',
//       home: const MainPage(),
//     );
//   }
// }

// ==========================================
// MAIN PAGE
// ==========================================
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // VARIABLE TRACKING TAB
  int _currentIndex = 0;

  // LIST OF PAGE
  final List<Widget> _pages = [
    // MEMANGGIL TUGAS 7
    const InputInteractivePage(),

    // HALAMAN TENTANG
    const TentangPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ====================================
      // APPBAR
      // ====================================
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Halaman Utama' : 'Tentang Aplikasi'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      // ====================================
      // DRAWER
      // HANYA MUNCUL DI TAB HOME
      // ====================================
      drawer: _currentIndex == 0
          ? Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.blue),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: const [
                        Icon(Icons.person, color: Colors.white, size: 50),

                        SizedBox(height: 10),

                        Text(
                          'Menu Navigasi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // MENU HOME
                  ListTile(
                    leading: const Icon(Icons.home),

                    title: const Text('Home'),

                    onTap: () {
                      Navigator.pop(context);

                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                  ),

                  // MENU TENTANG
                  ListTile(
                    leading: const Icon(Icons.info),

                    title: const Text('Tentang'),

                    onTap: () {
                      Navigator.pop(context);

                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            )
          : null,

      // ====================================
      // BODY SWITCHING
      // ====================================
      body: _pages[_currentIndex],

      // ====================================
      // BOTTOM NAVIGATION BAR
      // ====================================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Tentang'),
        ],
      ),
    );
  }
}

// ==========================================
// HALAMAN TENTANG
// ==========================================
class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: const [
          SizedBox(height: 20),

          Center(
            child: Icon(Icons.mobile_friendly, size: 100, color: Colors.blue),
          ),

          SizedBox(height: 20),

          Text(
            'Tentang Aplikasi',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 15),

          Text(
            'Aplikasi ini dibuat untuk mempelajari penggunaan BottomNavigationBar, Drawer, dan navigasi halaman pada Flutter.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),

          SizedBox(height: 20),

          Text('Nama Pembuat: Crash', style: TextStyle(fontSize: 16)),

          SizedBox(height: 10),

          Text('Versi Aplikasi: 1.0.0', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
