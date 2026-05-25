import 'package:flutter/material.dart';
import 'package:latihan_flutter/constant/app_drawer.dart';
import 'package:latihan_flutter/latihan/day_15/input_widget.dart';
import 'package:latihan_flutter/latihan/day_16/list_data.dart';
import 'package:latihan_flutter/latihan/day_16/map_data.dart';
import 'package:latihan_flutter/latihan/list_with_model_data.dart';

class ScreenDrawer extends StatefulWidget {
  const ScreenDrawer({super.key});

  @override
  State<ScreenDrawer> createState() => _ScreenDrawerState();
}

class _ScreenDrawerState extends State<ScreenDrawer> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    InputWidget(),
    ListData(),
    MapData(),
    ListWithModelData(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      drawer: AppDrawer(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
      endDrawer: const Drawer(),
      appBar: AppBar(title: const Text('Drawer')),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Business',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
