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
                    padding: const EdgeInsets.only(
                        top: 20, left: 40, right: 40, bottom: 20)),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        child: Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding:  EdgeInsets.all(20),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12))),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/home');
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'images/google.png',
                                        height: 50,
                                      ),
                                      const Text(
                                        "Sign In with Google",
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          color: Colors.black,
                                          fontSize: 21,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                     padding:  EdgeInsets.all(20),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12))),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'images/Apple-Logo.png',
                                        height: 40,
                                      ),
                                      const Text(
                                        "Sign In with Apple",
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          color: Colors.black,
                                          fontSize: 21,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );

                  //Navigator.pushNamed(context, '/home');
                },
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
