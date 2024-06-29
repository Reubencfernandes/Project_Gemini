import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Components/navigate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flute/pages/Components/Taskcard.dart';

class Create extends StatelessWidget {
  const Create({super.key});

  @override
  Widget build(BuildContext context) {
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
    };
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Cancel", style: TextStyle(color: Colors.red)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shadowColor: Colors.transparent,
                  ),
                ),
                Text(
                  "New Task",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                            fontFamily: 'Inter',
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Task Description',
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                          ),
                          maxLines: 5,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Date",
                          style: TextStyle(
                            fontFamily: 'Inter',
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Date',
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {},
                              child: Text("Generate",style:
                              TextStyle(color: Colors.white,
                                fontFamily: 'Bebas Neue',
                                fontSize: 20,
                              ),),
                            ),
                          ],
                        ),
                        SizedBox(height: 40,),
                        Row(
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
          ],
        ),
      ),
      bottomNavigationBar: lastpart(),
    );
  }
}
