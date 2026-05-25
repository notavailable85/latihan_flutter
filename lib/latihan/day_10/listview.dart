import 'package:flutter/material.dart';
import 'package:latihan_flutter/latihan/day_10/singlechildscrollview.dart';

class Listview extends StatelessWidget {
  const Listview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView 1"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
          buildName(),
        ],
      ),
    );
  }
}
