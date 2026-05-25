import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:latihan_flutter/constant/app_color.dart';
import 'package:latihan_flutter/constant/navigator.dart';
import 'package:latihan_flutter/tugas_flutter_1.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/images/safety_gloves.png")),
          // kIsWeb
          //     ? TextButton(
          //         onPressed: () {
          //           // context.pushNamed("/login");
          //           // context.push(TextRichDay13());
          //           // context.push(TextFormDay13());
          //           context.push(LoginScreenDay14());
          //         },
          //         child: Text(
          //           "Ke halaman login",
          //           style: TextStyle(color: Colors.black),
          //         ),
          //       )
          //     : Platform.isIOS
          //     ?
          kIsWeb
              ? SizedBox(
                  width: MediaQuery.of(context).size.width > 1000
                      ? 500
                      : double.infinity,
                  child: TextField(),
                )
              : TextField(),
          CupertinoButton(
            color: AppColor.primaryColor1,
            onPressed: () {
              // context.pushNamed("/login");
              // context.push(TextRichDay13());
              // context.push(TextFormDay13());
              context.push(TugasFlutter1());
            },
            child: Text(
              "Ke halaman login",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // : ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: AppColor.blueButton,
          //     ),
          //     onPressed: () {
          //       // context.pushNamed("/login");
          //       // context.push(TextRichDay13());
          //       // context.push(TextFormDay13());
          //       context.push(LoginScreenDay14());
          //     },
          //     child: Text(
          //       "Ke halaman login",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
