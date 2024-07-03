import 'dart:convert';

import 'package:ayumi/entities/task.dart';
import 'package:ayumi/pages/components/Timeline.dart';
import 'package:ayumi/pages/components/bottom_tab_navigation.dart';
import 'package:ayumi/pages/components/plans_for_today.dart';
import 'package:ayumi/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

import 'components/task_card.dart';

const String promptStart =
    "Create a schedule for my day. Give output in plain JSON format as an array with title, description, startTimeISO, endTimeISO and category (eg. sports, education, work, hobby). Do not output markdown.";

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  late DateTime lastDate;
  late String formattedMonth;
  late List<dynamic> jsonData;
  final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyAzwL_9gB9jeWZEn13l88MjhySTEj4Pa8M');
  DateTime now = DateTime.now().toUtc();
  DateTime selectedDate = DateTime.now().toUtc();
  TextEditingController description = TextEditingController();
  late List<dynamic> tasksForToday = [];

  @override
  void initState() {
    super.initState();
    lastDate = DateTime(now.year, now.month + 1, now.day);
    formattedMonth = DateFormat('MMMM dd, yyyy').format(selectedDate);
    description.text = '';
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
                ElevatedButton(onPressed: (){
                  description.text = '';
                },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                  child: Text(
                  "clear",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.red
                  ),
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
                ElevatedButton(onPressed:  () async {
                  for (var task in jsonData) {
                    await DatabaseService().addTask(
                        Task(
                          title: task['title'],
                          description: task['description'],
                          startTime:
                          DateTime.parse(task['startTimeISO']),
                          endTime: DateTime.parse(task['endTimeISO']),
                          category: task['category'],
                        ));
                  }
                },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300],shadowColor: Colors.grey[300]),
                  child: Text(
                    "Done",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.blue
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                String textDescription;

                                if(description.text.isNotEmpty)
                                  {
                                    textDescription = description.text;
                                  }
                                 else{
                                   textDescription = 'I wake up at 6:30 AM, go for a jog, have breakfast at 7:30 AM, attend online classes from 8:30 AM to 12:30 PM. In the afternoon I work on my side coding projects, finally at 6PM I go to the gym.';
                                }
                                String todayDate =
                                    DateTime.now().toIso8601String();

                                final response = await model.generateContent([
                                  Content.text(
                                      '$promptStart Today\'s date is $todayDate. $textDescription')
                                ]);

                                if (response.text == null) {
                                  // TODO: show error to user
                                  print("Failed to generate response text");
                                  return;
                                }

                                String jsonResponseText = response.text!;
                                jsonResponseText = jsonResponseText.substring(
                                    jsonResponseText.indexOf('['),
                                    jsonResponseText.lastIndexOf(']') + 1);
                                jsonData = await json.decode(jsonResponseText!);
                                print(tasksForToday);
                                setState(() {
                                  tasksForToday.clear();
                                  for (var task in jsonData) {
                                    tasksForToday.add(task);
                                  }
                                });

                                print(tasksForToday);

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Timeline",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${tasksForToday.length} Tasks",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        for (var task in tasksForToday)
                          TaskCard(task: Task(
                            title: task['title'],
                            description: task['description'],
                            startTime: DateTime.parse(task['startTimeISO']),
                            endTime: DateTime.parse(task['endTimeISO']),
                            category: task['category'],
                          )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomTabNavigation(),
    );
  }
}
