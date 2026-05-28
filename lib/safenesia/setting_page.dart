import 'package:flutter/material.dart';
import 'package:latihan_flutter/safenesia/editprofile_page.dart';

class SnSettingPage extends StatefulWidget {
  const SnSettingPage({super.key});

  @override
  State<SnSettingPage> createState() => _SnSettingPageState();
}

class _SnSettingPageState extends State<SnSettingPage> {
  bool isNotification = true;
  bool isDarkMode = false;
  bool isBiometric = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Pengaturan"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// ACCOUNT
            settingSectionTitle("Akun"),

            settingTile(
              icon: Icons.person,
              title: "Edit Profile",
              subtitle: "Ubah informasi akun",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SnEditProfilePage(),
                  ),
                );
              },
            ),

            settingTile(
              icon: Icons.lock,
              title: "Ubah Password",
              subtitle: "Ganti password akun",
              onTap: () {},
            ),

            const SizedBox(height: 10),

            /// NOTIFICATION
            settingSectionTitle("Notifikasi"),

            switchTile(
              icon: Icons.notifications,
              title: "Notifikasi",
              subtitle: "Aktifkan notifikasi aplikasi",
              value: isNotification,

              onChanged: (value) {
                setState(() {
                  isNotification = value;
                });
              },
            ),

            const SizedBox(height: 10),

            /// SECURITY
            settingSectionTitle("Keamanan"),

            switchTile(
              icon: Icons.fingerprint,
              title: "Fingerprint",
              subtitle: "Login menggunakan fingerprint",
              value: isBiometric,

              onChanged: (value) {
                setState(() {
                  isBiometric = value;
                });
              },
            ),

            const SizedBox(height: 10),

            /// APPEARANCE
            settingSectionTitle("Tampilan"),

            switchTile(
              icon: Icons.dark_mode,
              title: "Dark Mode",
              subtitle: "Aktifkan mode gelap",
              value: isDarkMode,

              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),

            const SizedBox(height: 10),

            /// OTHER
            settingSectionTitle("Lainnya"),

            settingTile(
              icon: Icons.help,
              title: "Bantuan",
              subtitle: "Pusat bantuan aplikasi",
              onTap: () {},
            ),

            settingTile(
              icon: Icons.info,
              title: "Tentang Aplikasi",
              subtitle: "Versi aplikasi 1.0.0",
              onTap: () {},
            ),

            settingTile(
              icon: Icons.privacy_tip,
              title: "Kebijakan Privasi",
              subtitle: "Informasi privasi pengguna",
              onTap: () {},
            ),

            const SizedBox(height: 20),

            /// LOGOUT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,

                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Logout"),

                          content: const Text(
                            "Yakin ingin keluar dari aplikasi?",
                          ),

                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },

                              child: const Text("Batal"),
                            ),

                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),

                              child: const Text(
                                "Logout",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  icon: const Icon(Icons.logout, color: Colors.white),

                  label: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// SECTION TITLE
  Widget settingSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Align(
        alignment: Alignment.centerLeft,

        child: Text(
          title,

          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// NORMAL TILE
  Widget settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),

      child: Card(
        elevation: 2,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

        child: ListTile(
          leading: Icon(icon, color: Colors.blue),

          title: Text(title),

          subtitle: Text(subtitle),

          trailing: const Icon(Icons.arrow_forward_ios),

          onTap: onTap,
        ),
      ),
    );
  }

  /// SWITCH TILE
  Widget switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),

      child: Card(
        elevation: 2,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

        child: SwitchListTile(
          secondary: Icon(icon, color: Colors.blue),

          title: Text(title),

          subtitle: Text(subtitle),

          value: value,

          onChanged: onChanged,
        ),
      ),
    );
  }
}
