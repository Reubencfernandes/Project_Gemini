import 'package:ayumi/pages/components/bottom_tab_navigation.dart';
import 'package:ayumi/pages/create_task_page.dart';
import 'package:ayumi/pages/onboarding_page.dart';
import 'package:ayumi/pages/register.dart';
import 'package:ayumi/pages/tasks_page.dart';
import 'package:ayumi/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'pages/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService().init();
  await DatabaseService().readUsers();
  runApp(
    ChangeNotifierProvider(
      create: (context)=> DatabaseService(),
      child: const MyApp(),
    ),
  );

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
          "/navigate": (context) => const BottomTabNavigation(),
          "/home": (context) => const HomePage(),
          "/create": (context) => const CreateTaskPage(),
          "/tasks": (context) => const TasksPage(),
          "/sign":(context) => const CreateAccount(),
        },
      );
    });
  }
}
