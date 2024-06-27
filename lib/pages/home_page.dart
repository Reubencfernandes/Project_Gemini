import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
class Homestuff extends StatelessWidget {
  const Homestuff({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 70, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      50.0), // Adjust the radius as needed
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
                        style: TextStyle(
                            fontFamily: 'inter', color: Colors.black)),
                    Text("Reuben Fernandes",
                        style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Text("Current Task",
                      style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Card(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 50, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              child: Text(
                                "Work",
                                style: TextStyle(color: Colors.redAccent),
                              )),
                          SizedBox(height: 5),
                          Text("Design an android App Using Flutter",
                              style: TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Progress"),
                              Text("35%"),
                            ],
                          ),
                          new LinearPercentIndicator(
                            width: 100.0,
                            lineHeight: 8.0,
                            percent: 0.9,
                            progressColor: Colors.blue,
                          ),
                          Text("Text 4"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
