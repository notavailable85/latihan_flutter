import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputInteractivePage extends StatefulWidget {
  const InputInteractivePage({super.key});

  @override
  State<InputInteractivePage> createState() => _InputInteractivePageState();
}

class _InputInteractivePageState extends State<InputInteractivePage> {
  // CHECKBOX
  bool isAgree = false;

  // SWITCH
  bool isDarkMode = false;

  // DROPDOWN
  String selectedCategory = 'Elektronik';

  // DATE PICKER
  DateTime? selectedDate;

  // TIME PICKER
  TimeOfDay? selectedTime;

  // FUNCTION DATE PICKER
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

  // FUNCTION TIME PICKER
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
    //bagian ini diganti jadi container
    return Container(
      color: isDarkMode ? Colors.grey[900] : Colors.white,

      // backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,

      // // APPBAR
      // appBar: AppBar(
      //   title: const Text(
      //     'Input Interaktif',
      //     style: TextStyle(
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.white,
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: isDarkMode ? Colors.black : Colors.blue,
      // ),

      // // DRAWER
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       DrawerHeader(
      //         decoration: const BoxDecoration(color: Colors.blue),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: const [
      //             Icon(Icons.person, color: Colors.white, size: 50),
      //             SizedBox(height: 10),
      //             Text(
      //               'Menu Input',
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 22,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),

      //       // LIST TILE
      //       ListTile(
      //         leading: const Icon(Icons.check_box),
      //         title: const Text('Syarat & Ketentuan'),
      //         onTap: () {},
      //       ),

      //       ListTile(
      //         leading: const Icon(Icons.dark_mode),
      //         title: const Text('Mode Tampilan'),
      //         onTap: () {},
      //       ),

      //       ListTile(
      //         leading: const Icon(Icons.category),
      //         title: const Text('Kategori Produk'),
      //         onTap: () {},
      //       ),

      //       ListTile(
      //         leading: const Icon(Icons.calendar_month),
      //         title: const Text('Pilih Tanggal'),
      //         onTap: () {},
      //       ),

      //       ListTile(
      //         leading: const Icon(Icons.access_time),
      //         title: const Text('Atur Pengingat'),
      //         onTap: () {},
      //       ),
      //     ],
      //   ),
      // ),

      // BODY
      // body diganti child
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================
              // 1. CHECKBOX
              // =================================
              Text(
                '1. Syarat & Ketentuan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              CheckboxListTile(
                value: isAgree,
                title: Text(
                  'Saya menyetujui persyaratan',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                activeColor: Colors.green,
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

              // =================================
              // 2. SWITCH
              // =================================
              Text(
                '2. Mode Tampilan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),

              SwitchListTile(
                value: isDarkMode,
                title: Text(
                  'Aktifkan Mode Gelap',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),

              const SizedBox(height: 25),

              // =================================
              // 3. DROPDOWN BUTTON
              // =================================
              Text(
                '3. Kategori Produk',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),

                child: DropdownButton(
                  value: selectedCategory,
                  isExpanded: true,
                  underline: const SizedBox(),

                  dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,

                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),

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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 25),

              // =================================
              // 4. DATE PICKER
              // =================================
              Text(
                '4. Pilih Tanggal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 10),

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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 25),

              // =================================
              // 5. TIME PICKER
              // =================================
              Text(
                '5. Atur Pengingat',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 10),

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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 30),

              // =================================
              // RESULT AREA
              // =================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black54 : Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Result Area',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),

                    const Divider(),

                    Text(
                      'Persetujuan: ${isAgree ? "Disetujui" : "Belum Disetujui"}',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),

                    Text(
                      'Mode Gelap: ${isDarkMode ? "Aktif" : "Nonaktif"}',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),

                    Text(
                      'Kategori: $selectedCategory',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),

                    Text(
                      selectedDate == null
                          ? 'Tanggal: Belum dipilih'
                          : 'Tanggal: ${DateFormat('dd-MM-yyyy').format(selectedDate!)}',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),

                    Text(
                      selectedTime == null
                          ? 'Pengingat: Belum diatur'
                          : 'Pengingat: ${selectedTime!.format(context)}',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
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
