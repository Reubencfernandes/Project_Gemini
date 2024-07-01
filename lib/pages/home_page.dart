import 'package:flute/pages/Components/navigate.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';

Map<String, double> dataMap = {
  "Study": 5,
  "Work": 3,
  "Sleep": 2,
  "Hobbies": 2,
};
List<Color> colorList = [
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.red,
];

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
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  const Text("Current Task",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Card(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 30, left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {}, // Non-null callback
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink[100],
                            ),
                            child: Text(
                              "Work",
                              style: TextStyle(
                                color: Colors.red[900],
                                fontFamily: 'Inter',
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text("Design an Android App Using Flutter",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Progress",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.grey[600])),
                              const Text("35%",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: LinearPercentIndicator(
                                lineHeight: 15.0,
                                percent: 0.35,
                                progressColor: Colors.black,
                                backgroundColor: Colors.grey[300],
                                barRadius: const Radius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(Icons.calendar_month,
                                  color: Colors.grey),
                              Text(
                                "Tue, 4 May 2024",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text("Analysis of Tasks",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Card(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 30, left: 12, right: 12),
                        child: PieChart(
                          dataMap: dataMap,
                          animationDuration: const Duration(milliseconds: 800),
                          colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: ChartType.disc,
                          ringStrokeWidth: 32,
                          legendOptions: const LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,
                            legendShape: BoxShape.circle,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                            ),
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                        )),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 30, left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          const Text("Progress",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Time Left This Month",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.grey[600])),
                              const Text("35%",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: LinearPercentIndicator(
                                lineHeight: 15.0,
                                percent: 0.35,
                                progressColor: Colors.red[400],
                                backgroundColor: Colors.grey[300],
                                barRadius: const Radius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Time Left This Year",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.grey[600])),
                              const Text("35%",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: LinearPercentIndicator(
                                lineHeight: 15.0,
                                percent: 0.35,
                                progressColor: Colors.blue[400],
                                backgroundColor: Colors.grey[300],
                                barRadius: const Radius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          const lastpart(), // Ensure the navigation bar is imported and used correctly
    );
  }
}

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius:
              BorderRadius.circular(50.0), // Adjust the radius as needed
          child: SizedBox(
            width: 50.0, // Adjust the width as needed
            height: 50.0, // Adjust the height as needed
            child: Image.asset(
              "images/final.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello,",
                style: TextStyle(fontFamily: 'Inter', color: Colors.black)),
            Text("Reuben Fernandes",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
