import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Image.asset(
              "images/final.jpg",
              fit: BoxFit.cover,
              width: 100.w,
              height: 70.h,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "Daily Task Planner",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 36,
                  fontVariations: [
                    FontVariation('wght', 600),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                "Effortlessly Plan Your Day",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.only(top: 20,left: 40,right: 40,bottom: 20)
                ),
                onPressed: () {},
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontVariations: [
                      FontVariation('wght', 600),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
