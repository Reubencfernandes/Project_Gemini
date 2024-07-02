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
        Navigator.pushNamed(context, '/home');
      }
    });
  }

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
                    padding: const EdgeInsets.only(
                        top: 20, left: 40, right: 40, bottom: 20)),
                onPressed: () {
                  showLoginModal(context);
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
        return SizedBox(
          height: 300,
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.all(20),
                  //       backgroundColor: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(12))),
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/home');
                  //   },
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Image.asset(
                  //         'images/google.png',
                  //         height: 50,
                  //       ),
                  //       const Text(
                  //         "Sign In with Google",
                  //         style: TextStyle(
                  //           fontFamily: 'inter',
                  //           color: Colors.black,
                  //           fontSize: 21,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SignInButton(
                    Buttons.google,
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () {
                      AuthService().signInWithGoogle();
                    },
                  )
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.all(20),
                  //       backgroundColor: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(12))),
                  //   onPressed: () {},
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Image.asset(
                  //         'images/Apple-Logo.png',
                  //         height: 40,
                  //       ),
                  //       const Text(
                  //         "Sign In with Apple",
                  //         style: TextStyle(
                  //           fontFamily: 'inter',
                  //           color: Colors.black,
                  //           fontSize: 21,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
