import 'package:ayumi/Services/auth_service.dart';
import 'package:ayumi/entities/my_user.dart';
import 'package:ayumi/entities/task.dart';
import 'package:ayumi/pages/components/bottom_tab_navigation.dart';
import 'package:ayumi/pages/components/my_badge.dart';
import 'package:ayumi/pages/onboarding_page.dart';
import 'package:ayumi/services/database_service.dart';
import 'package:color_hash/color_hash.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeHeader(),
            Expanded(
              child: Builder(
                builder: (context) {
                  return ListView(
                    children: [
                      ...buildCurrentTask(),
                      const SizedBox(height: 30),
                      ...buildAnalysisOfTasks(),
                      const SizedBox(height: 20),
                      buildProgressCard(),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomTabNavigation(),
    );
  }

  List<Widget> buildCurrentTask() {
    Task? currentTask = DatabaseService().getCurrentTask();
    double progressPercent = 0.0;
    if (currentTask != null) {
      progressPercent = 100 *
          (DateTime.now().millisecondsSinceEpoch - currentTask.startTime.millisecondsSinceEpoch) /
          (currentTask.endTime.millisecondsSinceEpoch - currentTask.startTime.millisecondsSinceEpoch);
    }

    return [
      const Text("Current Task", style: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.bold)),
      currentTask == null
          ? const Text("No task right now.", style: TextStyle(fontFamily: 'Inter', fontSize: 14))
          : Card(
        margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 30, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyBadge(text: currentTask.category),
              const SizedBox(height: 5),
              Text(currentTask.title,
                  style: const TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" Progress", style: TextStyle(fontFamily: 'Inter', color: Colors.grey[600])),
                  Text("${progressPercent.toStringAsFixed(0)}%",
                      style: const TextStyle(fontFamily: 'Inter', color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: LinearPercentIndicator(
                    lineHeight: 15.0,
                    percent: progressPercent / 100,
                    progressColor: Colors.black,
                    backgroundColor: Colors.grey[300],
                    barRadius: const Radius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.calendar_month, color: Colors.grey),
                  Text(
                    DateFormat('E, d MMM yyyy').format(currentTask.endTime),
                    style: TextStyle(fontFamily: 'Inter', color: Colors.grey[600], fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> buildAnalysisOfTasks() {
    List<Task> tasks = DatabaseService().tasks;
    Map<String, double> dataMap = {};
    List<Color> colorList = [];

    for (var task in tasks) {
      if (dataMap.containsKey(task.category)) {
        dataMap[task.category] = dataMap[task.category]! + 1;
      } else {
        colorList.add(ColorHash(task.category).toColor());
        dataMap[task.category] = 1;
      }
    }

    return [
      const Text("Analysis of Tasks", style: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.bold)),
      tasks.length > 0
          ? Card(
        margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15, left: 12, right: 12),
          child: PieChart(
            dataMap: dataMap,
            animationDuration: const Duration(milliseconds: 800),
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.disc,
            ringStrokeWidth:32,
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Inter'),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
        ),
      )
          : const Text(
        "Analysis of tasks couldn't be performed due to no tasks being saved.",
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      ),
    ];
  }

  double calculateYearProgress() {
    DateTime now = DateTime.now();
    int dayOfYear = int.parse(DateFormat('D').format(now));
    bool isLeapYear = (now.year % 4 == 0 && now.year % 100 != 0) || now.year % 400 == 0;
    int totalDaysInYear = isLeapYear ? 366 : 365;
    return 100 * dayOfYear / totalDaysInYear;
  }

  Widget buildProgressCard() {
    double monthProgress = 100 * DateTime.now().day / DateUtils.getDaysInMonth(DateTime.now().year, DateTime.now().month);
    double yearProgress = calculateYearProgress();

    return Card(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 30, left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Text("Progress", style: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Month Progress", style: TextStyle(fontFamily: 'Inter', color: Colors.grey[600])),
                Text("${monthProgress.toStringAsFixed(0)}%",
                    style: const TextStyle(fontFamily: 'Inter', color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: LinearPercentIndicator(
                  lineHeight: 15.0,
                  percent: monthProgress / 100,
                  progressColor: Colors.red[400],
                  backgroundColor: Colors.grey[300],
                  barRadius: const Radius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Year Progress", style: TextStyle(fontFamily: 'Inter', color: Colors.grey[600])),
                Text("${yearProgress.toStringAsFixed(0)}%",
                    style: const TextStyle(fontFamily: 'Inter', color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: LinearPercentIndicator(
                  lineHeight: 15.0,
                  percent: yearProgress / 100,
                  progressColor: Colors.blue[400],
                  backgroundColor: Colors.grey[300],
                  barRadius: const Radius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class WelcomeHeader extends StatefulWidget {
  const WelcomeHeader({super.key});

  @override
  _WelcomeHeaderState createState() => _WelcomeHeaderState();
}

class _WelcomeHeaderState extends State<WelcomeHeader> {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    MyUser user = _authService.getCurrentUser();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                user.photoUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Hello,", style: TextStyle(fontFamily: 'Inter', color: Colors.black)),
                Text(user.name,
                    style: const TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () async {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Are You Sure You Want To Signout?",
                          style: TextStyle(fontSize: 20, fontFamily: 'Inter', fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: const EdgeInsets.only(top: 15, left: 40, right: 40, bottom: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            AuthService obj = AuthService();
                            await obj.signOut();
                            if (mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const OnboardingPage()),
                              );
                            }
                          },
                          child: const Text(
                            "LOGOUT",
                            style: TextStyle(color: Colors.black, fontSize: 30, fontFamily: 'Bebas Neue'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.logout, color: Colors.black),
        ),
      ],
    );
  }
}
