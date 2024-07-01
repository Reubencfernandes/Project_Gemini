import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flute/pages/Components/Taskcard.dart';
import 'package:flute/pages/Components/navigate.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().toLocal();
    String formattedTime = DateFormat('hh:mm a').format(now);
    String formattedMonth = DateFormat('MMMM dd, yyyy').format(now);
    List<Widget> buildCards(int count) {
      List<Widget> cards = [];
      for (int i = 0; i < count; i++) {
        cards.add(
          const TaskCard(
            title: "Rise and Shine",
            description: "Wake up, get ready, eat a healthy breakfast to fuel your brain for a day of learning!",
            time: "7:00 AM",
          ),
        );
      }
      return cards;
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(formattedTime,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 32,
                          color: Colors.indigo[900],
                          fontWeight: FontWeight.bold,
                        )),
                    Text(formattedMonth,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          color: Colors.indigo[900],
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
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
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Plans For Today",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "6 Tasks",
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ...buildCards(6),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const lastpart(),
    );
  }
}
//9