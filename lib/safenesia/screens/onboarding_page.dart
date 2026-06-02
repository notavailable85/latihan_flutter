import 'package:flutter/material.dart';

import 'login_page.dart';

class SnOnboardingPage extends StatefulWidget {
  const SnOnboardingPage({super.key});

  @override
  State<SnOnboardingPage> createState() => _SnOnboardingPageState();
}

class _SnOnboardingPageState extends State<SnOnboardingPage> {
  final PageController pageController = PageController();

  int currentIndex = 0;

  List walkthroughData = [
    {
      "image": Icons.school,
      "title": "Pelatihan Profesional",
      "description":
          "Temukan berbagai pelatihan dan sertifikasi profesional dengan mudah.",
    },
    {
      "image": Icons.workspace_premium,
      "title": "Sertifikat Resmi",
      "description":
          "Dapatkan sertifikat resmi setelah menyelesaikan pelatihan.",
    },
    {
      "image": Icons.mobile_friendly,
      "title": "Belajar Dimana Saja",
      "description": "Akses materi pelatihan kapan saja dan dimana saja.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            /// SKIP BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

              child: Align(
                alignment: Alignment.centerRight,

                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SnLoginPage(),
                      ),
                    );
                  },

                  child: const Text("Skip", style: TextStyle(fontSize: 16)),
                ),
              ),
            ),

            /// PAGE VIEW
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: walkthroughData.length,

                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },

                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(30),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        /// ICON
                        Container(
                          height: 220,
                          width: 220,

                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            shape: BoxShape.circle,
                          ),

                          child: Icon(
                            walkthroughData[index]["image"],
                            size: 120,
                            color: Colors.blue,
                          ),
                        ),

                        const SizedBox(height: 50),

                        /// TITLE
                        Text(
                          walkthroughData[index]["title"],

                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// DESCRIPTION
                        Text(
                          walkthroughData[index]["description"],

                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            /// INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(walkthroughData.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),

                  margin: const EdgeInsets.symmetric(horizontal: 4),

                  height: 10,

                  width: currentIndex == index ? 30 : 10,

                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.blue
                        : Colors.grey.shade300,

                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),

            /// BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),

              child: SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    if (currentIndex == walkthroughData.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SnLoginPage(),
                        ),
                      );
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  child: Text(
                    currentIndex == walkthroughData.length - 1
                        ? "Mulai"
                        : "Next",

                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
