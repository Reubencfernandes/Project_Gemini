import 'package:ayumi/Services/auth_service.dart';
import 'package:ayumi/entities/my_user.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sign_in_button/sign_in_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    super.initState();

    AuthService().authStateChanges.listen((MyUser? user) {
      if (user != null) {
        Navigator.pushNamed(context, '/navigate');
      }
    });
  }

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
              height: screenHeight * 0.5, // Adjusted for better responsiveness
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
                      vertical: 2.h, horizontal: 8.w)), // Adjusted for responsiveness
              onPressed: () {
                showLoginModal(context);
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

  void showLoginModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(// Adjusted for better responsiveness
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SignInButton(
                  Buttons.google,
                  padding: EdgeInsets.all(2.h), // Use percentage-based padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    AuthService().signInWithGoogle();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
