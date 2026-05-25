import 'package:flutter/material.dart';
import 'package:latihan_flutter/constant/navigator.dart';

class NavigatorPop extends StatelessWidget {
  const NavigatorPop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Navigator Pop Day 13"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => StateDay12()),
              // );
              context.pop();
            },
            child: Text("Navigator Pop"),
          ),
        ],
      ),
    );
  }
}
