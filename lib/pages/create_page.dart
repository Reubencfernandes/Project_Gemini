import 'dart:convert';

import 'package:flute/pages/Components/Taskcard.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

import 'Components/navigate.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  late DateTime lastDate;
  late String formattedMonth;
  final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyAzwL_9gB9jeWZEn13l88MjhySTEj4Pa8M');
  DateTime now = DateTime.now().toUtc();
  DateTime selectedDate = DateTime.now().toUtc();
  TextEditingController description = TextEditingController();
  List<dynamic> tasksForToday = [];

  @override
  void initState() {
    super.initState();
    lastDate = DateTime(now.year, now.month + 1, now.day);
    formattedMonth = DateFormat('MMMM dd, yyyy').format(selectedDate);
    description.text = '';
  }

  List<Widget> buildCards(int count) {
    List<Widget> cards = [];
    for (int i = 0; i < count; i++) {
      cards.add(
        const TaskCard(
          title: "Rise and Shine",
          description:
              "Wake up, get ready, eat a healthy breakfast to fuel your brain for a day of learning!",
          time: "7:00 AM",
        ),
      );
    }
    return cards;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: now,
      lastDate: lastDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedMonth = DateFormat('MMMM dd, yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shadowColor: Colors.transparent,
                  ),
                  child:
                      const Text("Cancel", style: TextStyle(color: Colors.red)),
                ),
                const Text(
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
                  child: const Text(
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter Description Of Your Day",
                          style: TextStyle(
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: description,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            filled: true,
                            hintText:
                                'I wake up at 6:30 AM, go for a jog, have breakfast at 7:30 AM, attend online classes from 8:30 AM to 12:30 PM, and spend the afternoon working on projects.',
                          ),
                          maxLines: 8,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Date",
                          style: TextStyle(
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onTap: () => _selectDate(context),
                                readOnly: true,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: InputBorder.none,
                                  hintText: formattedMonth,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 10),
                                backgroundColor: Colors.red,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              onPressed: () async {
                                String textDescription =
                                    'I wake up at 6:30 AM, go for a jog, have breakfast at 7:30 AM, attend online classes from 8:30 AM to 12:30 PM, and spend the afternoon working on projects.';
                                final content = [
                                  Content.text(
                                      'create schedule for me for my day give output in plain JSON format as an array with title,description,startTimeISO,endTimeISO and category (sports,education,work,hobbies). Do not output markdown. $textDescription')
                                ];
                                final response =
                                    await model.generateContent(content);
                                String? jsonResponseText = response.text;
                                print(jsonResponseText);

                                jsonResponseText = jsonResponseText?.substring(
                                    7, jsonResponseText.length - 4);

                                List<dynamic> jsonData =
                                    await json.decode(jsonResponseText!);
                                print(jsonData);
                              },
                              child: const Text(
                                "Generate",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Bebas Neue',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
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
                              "0 Tasks",
                              style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ...buildCards(0),
                      ],
                    ),
                  ),
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
