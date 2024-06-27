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
        margin: const EdgeInsets.only(top: 70, left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0), // Adjust the radius as needed
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
                    Text("Hello,", style: TextStyle(fontFamily: 'inter', color: Colors.black)),
                    Text("Reuben Fernandes",
                        style: TextStyle(fontFamily: 'inter', fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Text("Current Task",
                      style: TextStyle(fontFamily: 'inter', fontSize: 20, fontWeight: FontWeight.bold)),
                  Card(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 30, left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {}, // Non-null callback
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                            ),
                            child: Text(
                              "Work",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text("Design an android App Using Flutter",
                              style: TextStyle(fontFamily: 'inter', fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Progress"),
                              Text("35%"),
                            ],
                          ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                          child: new LinearPercentIndicator(
                            lineHeight: 15.0,
                            percent: 0.8,
                            progressColor: Colors.blue,
                          ),
                      ),
                          SizedBox(height: 10,),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,

                            children: [

                              Icon(Icons.calendar_month,color: Colors.grey),
                              Text("Tue,4 May 2024")
                            ],
                          )
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
