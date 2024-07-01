import 'package:ayumi/firebase_options.dart';
import 'package:ayumi/pages/create_page.dart';
import 'package:ayumi/pages/onboarding_page.dart';
import 'package:ayumi/pages/task_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

  // runApp(MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(create: (context) => AuthService()),
  //   ],
  //   child: const MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screentype) {
      return MaterialApp(
        title: "Project Gemini",
        debugShowCheckedModeBanner: false,
        home: const OnboardingPage(),
        routes: {
          "/home": (context) => const HomePage(),
          "/create": (context) => const CreateTaskPage(),
          "/tasks": (context) => const TaskPage(),
        },
      );
    });
  }
}
