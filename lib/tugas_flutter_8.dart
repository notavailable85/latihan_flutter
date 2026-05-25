// main.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation App',
      home: const MainPage(),
    );
  }
}

// =====================================
// MAIN PAGE
// =====================================
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // TRACK TAB ACTIVE
  int _currentIndex = 0;

  // LIST PAGE
  final List<Widget> _pages = [const HomePage(), const AboutPage()];

  // JUDUL APPBAR
  final List<String> _titles = ['Halaman Utama', 'Tentang Aplikasi'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =====================================
      // APPBAR
      // =====================================
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      // =====================================
      // DRAWER
      // HANYA MUNCUL DI TAB HOME
      // =====================================
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
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ],
                    ),
                  ),

                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('Tentang Aplikasi'),
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          : null,

      // =====================================
      // BODY
      // =====================================
      body: _pages[_currentIndex],

      // =====================================
      // BOTTOM NAVIGATION BAR
      // =====================================
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

// =====================================
// HOME PAGE
// =====================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // CHECKBOX
  bool isAgree = false;

  // SWITCH
  bool isDarkMode = false;

  // DROPDOWN
  String selectedCategory = 'Elektronik';

  // DATE
  DateTime? selectedDate;

  // TIME
  TimeOfDay? selectedTime;

  // =====================================
  // PICK DATE
  // =====================================
  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // =====================================
  // PICK TIME
  // =====================================
  Future<void> pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDarkMode ? Colors.black87 : Colors.grey[200],

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================
              // CHECKBOX
              // =====================================
              const Text(
                '1. Syarat & Ketentuan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              CheckboxListTile(
                value: isAgree,
                title: const Text('Saya menyetujui persyaratan'),
                onChanged: (value) {
                  setState(() {
                    isAgree = value!;
                  });
                },
              ),

              Text(
                isAgree
                    ? 'Pendaftaran diperbolehkan'
                    : 'Pendaftaran belum tersedia',
                style: TextStyle(
                  color: isAgree ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // =====================================
              // SWITCH
              // =====================================
              const Text(
                '2. Mode Tampilan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SwitchListTile(
                value: isDarkMode,
                title: const Text('Aktifkan Mode Gelap'),
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),

              const SizedBox(height: 25),

              // =====================================
              // DROPDOWN
              // =====================================
              const Text(
                '3. Kategori Produk',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),

                child: DropdownButton(
                  value: selectedCategory,
                  isExpanded: true,
                  underline: const SizedBox(),

                  items: const [
                    DropdownMenuItem(
                      value: 'Elektronik',
                      child: Text('Elektronik'),
                    ),
                    DropdownMenuItem(value: 'Pakaian', child: Text('Pakaian')),
                    DropdownMenuItem(value: 'Makanan', child: Text('Makanan')),
                    DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
                  ],

                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value.toString();
                    });
                  },
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Anda memilih kategori: $selectedCategory',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 25),

              // =====================================
              // DATE PICKER
              // =====================================
              const Text(
                '4. Pilih Tanggal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              ElevatedButton.icon(
                onPressed: pickDate,
                icon: const Icon(Icons.calendar_today),
                label: const Text('Pilih Tanggal'),
              ),

              const SizedBox(height: 10),

              Text(
                selectedDate == null
                    ? 'Tanggal belum dipilih'
                    : 'Tanggal Lahir: ${DateFormat('dd-MM-yyyy').format(selectedDate!)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 25),

              // =====================================
              // TIME PICKER
              // =====================================
              const Text(
                '5. Atur Pengingat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              ElevatedButton.icon(
                onPressed: pickTime,
                icon: const Icon(Icons.access_time),
                label: const Text('Atur Pengingat'),
              ),

              const SizedBox(height: 10),

              Text(
                selectedTime == null
                    ? 'Waktu belum dipilih'
                    : 'Pengingat diatur pukul: ${selectedTime!.format(context)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              // =====================================
              // RESULT AREA
              // =====================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[850] : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Result Area',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Divider(),

                    Text(
                      'Persetujuan: ${isAgree ? "Disetujui" : "Belum Disetujui"}',
                    ),

                    Text('Mode Gelap: ${isDarkMode ? "Aktif" : "Nonaktif"}'),

                    Text('Kategori: $selectedCategory'),

                    Text(
                      selectedDate == null
                          ? 'Tanggal: Belum dipilih'
                          : 'Tanggal: ${DateFormat('dd-MM-yyyy').format(selectedDate!)}',
                    ),

                    Text(
                      selectedTime == null
                          ? 'Pengingat: Belum diatur'
                          : 'Pengingat: ${selectedTime!.format(context)}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================
// ABOUT PAGE
// =====================================
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),

      child: Center(
        child: Card(
          elevation: 5,

          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.flutter_dash, size: 80, color: Colors.blue),

                SizedBox(height: 20),

                Text(
                  'Aplikasi Input Interaktif',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 15),

                Text(
                  'Aplikasi ini dibuat untuk mempelajari penggunaan BottomNavigationBar, Drawer, Form Input, DatePicker, dan TimePicker pada Flutter.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 20),

                Divider(),

                SizedBox(height: 10),

                Text('Pembuat: Crash', style: TextStyle(fontSize: 16)),

                SizedBox(height: 10),

                Text('Versi Aplikasi: 1.0.0', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
