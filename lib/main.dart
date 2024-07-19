import 'package:ayumi/pages/components/bottom_tab_navigation.dart';
import 'package:ayumi/pages/create_task_page.dart';
import 'package:ayumi/pages/onboarding_page.dart';
import 'package:ayumi/pages/register.dart';
import 'package:ayumi/pages/tasks_page.dart';
import 'package:ayumi/services/database_service.dart';
import 'package:ayumi/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService().init();
  await DatabaseService().readUsers();
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(channelKey: "Task", channelName: "task_planner", channelDescription: "Notification of Tasks", ledColor: Colors.redAccent)
  ],debug: true);
  runApp(
    ChangeNotifierProvider(
      create: (context) => DatabaseService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );
  }

  @override
  Widget build(BuildContext context) {
    List user = DatabaseService().users;
    AwesomeNotifications().isNotificationAllowed().then((perms){
      if(!perms) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: "Project Gemini",
        debugShowCheckedModeBanner: false,
        home: user.isEmpty ? const OnboardingPage() : const BottomTabNavigation(),
        routes: {
          "/navigate": (context) => const BottomTabNavigation(),
          "/home": (context) => const HomePage(),
          "/create": (context) => const CreateTaskPage(),
          "/tasks": (context) => const TasksPage(),
          "/sign": (context) => const CreateAccount(),
        },
      );
    });
  }
}
