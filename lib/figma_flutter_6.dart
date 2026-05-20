import 'package:flutter/material.dart';

class FigmaFlutter6 extends StatefulWidget {
  const FigmaFlutter6({super.key});

  @override
  State<FigmaFlutter6> createState() => _FigmaFlutter6State();
}

class _FigmaFlutter6State extends State<FigmaFlutter6> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Safenesia"),
      //   centerTitle: true,
      //   backgroundColor: Colors.blue,
      //   foregroundColor: Colors.white,
      // ),
      body: Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 20),
          child: Padding(
            padding: EdgeInsets.only(top: 116),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    fontFamily: 'Poppins',
                  ),
                ),

                Text(
                  "Login to access your account",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
