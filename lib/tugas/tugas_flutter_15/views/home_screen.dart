import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/views/batches_screen.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/views/profile_screen.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/views/trainings_screen.dart';
import 'package:latihan_flutter/tugas/tugas_flutter_15/views/users_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const TrainingsScreen(),
    const UsersScreen(),
    const BatchesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white54,
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Pelatihan'),
                BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Pengguna'),
                BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Batch'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
