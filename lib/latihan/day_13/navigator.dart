import 'package:flutter/material.dart';
import 'package:latihan_flutter/constant/navigator.dart';

class Navigator extends StatelessWidget {
  const Navigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Navigator Day 13"),
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
              context.push(Navigator());
            },
            child: Text("Navigator Push"),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => StateDay12()),
              // );
              context.pushReplacement(Navigator());
            },
            child: Text("Navigator PushReplacement"),
          ),

          ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => StateDay12()),
              // );
              context.pushAndRemoveAll(Navigator());
            },
            child: Text("Navigator PushRemoveAll"),
          ),
        ],
      ),
    );
  }
}
