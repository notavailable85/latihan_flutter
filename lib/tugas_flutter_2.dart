import 'package:flutter/material.dart';

class TugasFlutter2 extends StatelessWidget {
  const TugasFlutter2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Safenesia App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      // body: Center(
      //   child: Container(
      //     decoration: BoxDecoration(
      //       image: DecorationImage(
      //         image: AssetImage("assets/images/logo_safenesia.png"),
      //         opacity: 0.2,
      //       ),
      //     ),
      //   ),
      // ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo_safenesia.png"),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.email, size: 25),
                  SizedBox(width: 10),
                  Text("info@safenesia.com", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                // color: Colors.grey[100],
                // borderRadius: BorderRadius.circular(20),
                // border: Border.all(),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.phone, size: 25),
                  SizedBox(width: 10),
                  Text("081377708508", style: TextStyle(fontSize: 18)),
                  Spacer(),
                  Icon(Icons.location_on, size: 25),
                  SizedBox(width: 10),
                  Text("Jakarta Barat", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                // flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    // color: Colors.red,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text(
                        //   "500",
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        Icon(Icons.book, size: 50),
                        Text("Training", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    // color: Colors.red,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text(
                        //   "500",
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        Icon(Icons.handshake, size: 50),
                        Text("Consulting", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
