import 'package:ayumi/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/final.jpg",
              fit: BoxFit.cover,
              width: 100.w,
              height: screenHeight * 0.7, // Adjusted for better responsiveness
            ),
            SizedBox(height: 2.h), // Use percentage-based spacing
            Text(
              "Daily Task Planner",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 24.sp, // Use sp for scalable font size
                fontVariations: const [
                  FontVariation('wght', 600),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h), // Use percentage-based spacing
            Text(
              "Effortlessly Plan Your Day",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontSize: 14.sp, // Use sp for scalable font size
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h), // Use percentage-based spacing
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 2.h,
                      horizontal: 8.w)), // Adjusted for responsiveness
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateAccount()));
              },
              child: Text(
                "Get Started",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 18.sp, // Use sp for scalable font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
