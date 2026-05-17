import 'package:flutter/material.dart';

class LatihanImages extends StatelessWidget {
  const LatihanImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Images", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 150,

          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
              filterQuality: FilterQuality.medium,
              opacity: 0.5,
              scale: 5,
              repeat: ImageRepeat.noRepeat,
              image: AssetImage("assets/images/minion.png"),
            ),
          ),
        ),
      ),
    );
  }
}
