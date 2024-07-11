import 'dart:convert';

import 'package:ayumi/entities/task.dart';
import 'package:ayumi/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
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
  bool isGenerate = true;
  late DateTime lastDate;
  late String formattedMonth;
  Color buttonColor = Colors.red;
  List<dynamic> jsonData = [];
  final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey:
          'AIzaSyAzwL_9gB9jeWZEn13l88MjhySTEj4Pa8M'); // Replace with your actual API key
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

  void alwayschange() {
    setState(() {
      isGenerate = !isGenerate;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: now,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedMonth = DateFormat('MMMM dd, yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _generateTasks() async {
    alwayschange();
    String textDescription = description.text.isNotEmpty
        ? description.text
        : 'I wake up at 6:30 AM, go for a jog, have breakfast at 7:30 AM, attend online classes from 8:30 AM to 12:30 PM. In the afternoon I work on my side coding projects, finally at 6PM I go to the gym.';

    String todayDate = DateTime.now().toIso8601String();

    try {
      final response = await model.generateContent([
        Content.text(
            '$promptStart Today\'s date is $todayDate. $textDescription')
      ]);

      if (response.text == null) {
        _showError('Failed to generate response text');
        return;
      }

      String jsonResponseText = response.text!;
      jsonResponseText = jsonResponseText.substring(
          jsonResponseText.indexOf('['), jsonResponseText.lastIndexOf(']') + 1);
      print("Json Response Text: $jsonResponseText");

      jsonData = json.decode(jsonResponseText);

      setState(() {
        alwayschange();
        buttonColor = Colors.red;
        tasksForToday.clear();
        tasksForToday.addAll(jsonData);
      });
    } catch (e) {
      _showError('Error generating tasks: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text(message, style: TextStyle(fontFamily: 'Inter', fontSize: 15)),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  description.text = '';
                  setState(() {
                    tasksForToday.clear();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  elevation: 0,
                ),
                child: const Text(
                  "Clear All",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.red,
                  ),
                ),
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
                onPressed: () async {
                  if (jsonData.isEmpty) {
                    _showError('Failed to generate response text');
                    return;
                  }
                  for (var task in jsonData) {
                    await DatabaseService().addTask(
                      Task(
                        title: task['title'],
                        description: task['description'],
                        day: DateFormat('dd MMMM yyyy')
                            .format(DateTime.parse(task['startTimeISO'])),
                        startTime: DateTime.parse(task['startTimeISO']),
                        endTime: DateTime.parse(task['endTimeISO']),
                        category: task['category'],
                      ),
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      "Task Added to the Database",
                      style: TextStyle(fontFamily: 'Inter', fontSize: 15),
                    ),
                    backgroundColor: Colors.green,
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  shadowColor: Colors.grey[300],
                  elevation: 0,
                  overlayColor: Colors.grey[300],
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.blue,
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
                          AnimatedButton(
                            animatedOn: AnimatedOn.onTap,
                            height: 50,
                            width: 100,
                            isReverse: true,
                            text: 'Generate',
                            borderRadius: 5,
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Bebas Neue',
                              fontSize: 20,
                            ),
                            backgroundColor: buttonColor,
                            selectedTextColor: Colors.black,
                            transitionType: TransitionType.CENTER_ROUNDER,
                            onPress: _generateTasks,
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
                      isGenerate
                          ? Column(
                              children: tasksForToday.map((task) {
                                return TaskCard(
                                  task: Task(
                                    title: task['title'],
                                    day: DateFormat("dd-MM-YYYY").format(
                                        DateTime.parse(task['startTimeISO'])),
                                    description: task['description'],
                                    startTime:
                                        DateTime.parse(task['startTimeISO']),
                                    endTime: DateTime.parse(task['endTimeISO']),
                                    category: task['category'],
                                  ),
                                );
                              }).toList(),
                            )
                          : const Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.black26),
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
