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
      title: 'Input Interaktif',
      home: const InputInteraktifPage(),
    );
  }
}

class InputInteraktifPage extends StatefulWidget {
  const InputInteraktifPage({super.key});

  @override
  State<InputInteraktifPage> createState() => _InputInteraktifPageState();
}

class _InputInteraktifPageState extends State<InputInteraktifPage> {
  // Checkbox
  bool isAgree = false;

  // Switch
  bool isDarkMode = false;

  // Dropdown
  String selectedCategory = 'Elektronik';

  // Date
  DateTime? selectedDate;

  // Time
  TimeOfDay? selectedTime;

  // Fungsi pilih tanggal
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

  // Fungsi pilih waktu
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
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[200],

      // APPBAR
      appBar: AppBar(
        title: const Text('Input Interaktif'),
        centerTitle: true,
        backgroundColor: isDarkMode ? Colors.black : Colors.blue,
      ),

      // DRAWER
      drawer: Drawer(
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
                    'Menu Input',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.check_box),
              title: const Text('Syarat & Ketentuan'),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Mode Tampilan'),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Kategori Produk'),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('Pilih Tanggal'),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.alarm),
              title: const Text('Atur Pengingat'),
              onTap: () {},
            ),
          ],
        ),
      ),

      // BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // 1. CHECKBOX
              // =========================
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

              // =========================
              // 2. SWITCH
              // =========================
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

              // =========================
              // 3. DROPDOWN
              // =========================
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

              // =========================
              // 4. DATE PICKER
              // =========================
              const Text(
                '4. Pilih Tanggal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              ElevatedButton.icon(
                onPressed: pickDate,
                icon: const Icon(Icons.calendar_month),
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

              // =========================
              // 5. TIME PICKER
              // =========================
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

              // =========================
              // RESULT AREA
              // =========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black54 : Colors.white,
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
