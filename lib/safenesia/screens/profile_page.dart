import 'package:flutter/material.dart';
import 'package:latihan_flutter/safenesia/screens/setting_page.dart';

class SnProfilePage extends StatelessWidget {
  const SnProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER PROFILE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),

              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),

              child: Column(
                children: [
                  /// PHOTO PROFILE
                  Container(
                    height: 120,
                    width: 120,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/profile.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// NAME
                  const Text(
                    "Crash",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  /// EMAIL
                  const Text(
                    "crash@email.com",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  /// STATS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      profileStat("12", "Pelatihan"),
                      profileStat("8", "Sertifikat"),
                      profileStat("5", "Event"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// MENU PROFILE
            profileMenu(
              icon: Icons.person,
              title: "Edit Profile",
              onTap: () {},
            ),

            profileMenu(
              icon: Icons.school,
              title: "Pelatihan Saya",
              onTap: () {},
            ),

            profileMenu(
              icon: Icons.workspace_premium,
              title: "Sertifikat",
              onTap: () {},
            ),

            profileMenu(
              icon: Icons.settings,
              title: "Pengaturan",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SnSettingPage(),
                  ),
                );
              },
            ),

            profileMenu(icon: Icons.help, title: "Bantuan", onTap: () {}),

            profileMenu(
              icon: Icons.logout,
              title: "Logout",
              color: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Yakin ingin keluar?"),
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
            ),
          ],
        ),
      ),
    );
  }

  /// PROFILE STATS
  Widget profileStat(String value, String title) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        Text(title, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  /// PROFILE MENU
  Widget profileMenu({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

        child: ListTile(
          leading: Icon(icon, color: color),

          title: Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
          ),

          trailing: const Icon(Icons.arrow_forward_ios),

          onTap: onTap,
        ),
      ),
    );
  }
}
