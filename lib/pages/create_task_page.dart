import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ayumi/entities/task.dart';
import 'package:ayumi/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

import 'components/create_task_card.dart';

const String promptStart =
    "Create a schedule for my day. Give output in plain JSON format as an array with title, description, startTimeISO, endTimeISO and category (eg. sports, education, work, studies, hobby).Do not output markdown.";

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
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  List<dynamic> jsonData = [];
  final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey:
          'AIzaSyAzwL_9gB9jeWZEn13l88MjhySTEj4Pa8M'); // Replace with your actual API key
  DateTime now = DateTime.now().toUtc();
  DateTime selectedDate = DateTime.now().toUtc();
  TextEditingController description = TextEditingController();
  List<dynamic> tasksForToday = [];
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    lastDate = DateTime(now.year, now.month + 1, now.day);
    formattedMonth = DateFormat('MMMM dd, yyyy').format(selectedDate);
    description.text = '';
    startTime = const TimeOfDay(hour: 9, minute: 0); // Initial start time
    endTime = const TimeOfDay(hour: 17, minute: 0); // Initial end time
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startTimeController.text = startTime.format(context);
    endTimeController.text = endTime.format(context);
  }

  void alwayschange() {
    setState(() {
      isGenerate = !isGenerate;
    });
  }

  Future<void> changeStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.redAccent,
              secondary: Colors.redAccent,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != startTime) {
      setState(() {
        startTime = picked;
        startTimeController.text = startTime.format(context);
      });
    }
  }

  Future<void> changeEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.redAccent,
              secondary: Colors.redAccent,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != endTime) {
      setState(() {
        endTime = picked;
        endTimeController.text = endTime.format(context);
      });
    }
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
        : 'I wake up at 6:00 AM, attend church from 6:30 to 7:00 AM, and then eat breakfast at home. After that, I prepare for college and arrive at 9:00 AM. I return home at 5:30 PM, watch "My Hero Academia" on TV, study afterward, and go to sleep at 11:00 PM.';

    try {
      print("Today's date is $formattedMonth");
      final response = await model.generateContent([
        Content.text(
            '$promptStart Today\'s date is $formattedMonth. $textDescription')
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
      setState(() {
        alwayschange();
        buttonColor = Colors.red;
      });
    }
  }

  void deleteTask(int index) {
    setState(() {
      tasksForToday.removeAt(index);
    });
  }


  Future editTask(Task task, int index) {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController categroy = TextEditingController();
    categroy.text = task.category;
    title.text = task.title;
    description.text = task.description;

    startTime = TimeOfDay.fromDateTime(task.startTime);
    endTime = TimeOfDay.fromDateTime(task.endTime);
    startTimeController.text = startTime.format(context);
    endTimeController.text = endTime.format(context);

    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            margin:
                const EdgeInsets.only(top: 50, bottom: 50, left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: categroy,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: "Enter Category",
                  ),
                ),
                TextField(
                  controller: title,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: "Enter Title",
                  ),
                ),
                TextField(
                  controller: description,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: "Enter Description",
                  ),
                ),
                TextField(
                  controller: startTimeController,
                  onTap: () => changeStartTime(context),
                  readOnly: true,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: "Enter Start Time",
                  ),
                ),
                TextField(
                  controller: endTimeController,
                  onTap: () => changeEndTime(context),
                  readOnly: true,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: "Enter End Time",
                    filled: true,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        tasksForToday[index]['category'] = categroy.text;
                        tasksForToday[index]['title'] = title.text;
                        tasksForToday[index]['description'] = description.text;
                        tasksForToday[index]['startTimeISO'] =
                            convertTimeOfDayToDateTime(selectedDate, startTime)
                                .toIso8601String();
                        tasksForToday[index]['endTimeISO'] =
                            convertTimeOfDayToDateTime(selectedDate, endTime)
                                .toIso8601String();
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7))),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Bebas Neue',
                        fontSize: 23,
                      ),
                    )),
              ],
            ),
          );
        });
  }

  DateTime convertTimeOfDayToDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
          style: const TextStyle(fontFamily: 'Inter', fontSize: 15)),
      backgroundColor: Colors.red,
    ));
  }
  void scheduleNotifications(List<dynamic> tasksForToday) async {
    String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    for (var task in tasksForToday) {
      DateTime startDateTime = DateTime.parse(task['startTimeISO']).toLocal();
      DateTime endDateTime = DateTime.parse(task['endTimeISO']).toLocal();

      // Check if the start time is in the future
      if (startDateTime.isBefore(DateTime.now())) {
        print("The start time ${startDateTime.toString()} is in the past. Skipping notification.");
        continue;
      }

      // Generate a unique ID based on the date and hour
      String formattedDateHour = DateFormat('yyyyMMddHH').format(startDateTime);
      int uniqueId;
      try {
        uniqueId = int.parse(formattedDateHour);
        print(uniqueId);
      } catch (e) {
        // Handle the error if the string is not a valid integer
        print("Error parsing unique ID: ${e.toString()}");
        continue; // Skip this notification
      }
      AwesomeNotifications().isNotificationAllowed().then((perms) async {
        if(perms)
          {
            await AwesomeNotifications().createNotification(
              content: NotificationContent(
                  id: uniqueId,
                  // Use the generated unique id
                  channelKey: 'Task',
                  title: "Task For Now ${task['title']}",
                  body: "${task['description']} from ${DateFormat('hh:mm aa')
                      .format(startDateTime)} to ${DateFormat('hh:mm aa').format(
                      endDateTime)}",
                  wakeUpScreen: true,
                  category: NotificationCategory.Email
              ),
              schedule: NotificationCalendar(
                year: startDateTime.year,
                month: startDateTime.month,
                day: startDateTime.day,
                hour: startDateTime.hour,
                minute: startDateTime.minute,
                second: startDateTime.second,
                timeZone: localTimeZone,
                preciseAlarm: true,
              ),
            );
          }
      });
    }
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
                  if (tasksForToday.isEmpty) {
                    _showError('Failed to generate response text');
                    return;
                  }
                  await DatabaseService().deleteAllTasksForDate(
                      DateFormat("dd MMMM yyyy").format(selectedDate));
                  for (var task in tasksForToday) {
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
                  scheduleNotifications(tasksForToday);
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
                        cursorColor: Colors.black87,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          filled: true,
                          hintText:
                              'I wake up at 6:00 AM, attend church from 6:30 to 7:00 AM, and then eat breakfast at home. After that, I prepare for college and arrive at 9:00 AM. I return home at 5:30 PM, watch "My Hero Academia" on TV, study afterward, and go to sleep at 11:00 PM.',
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
                              children:
                                  tasksForToday.asMap().entries.map((entry) {
                                int index = entry.key;
                                var task = entry.value;
                                return CreateTaskCard(
                                  task: Task(
                                    title: task['title'],
                                    day: DateFormat("dd MMMM yyyy").format(
                                        DateTime.parse(task['startTimeISO'])),
                                    description: task['description'],
                                    startTime:
                                        DateTime.parse(task['startTimeISO']),
                                    endTime: DateTime.parse(task['endTimeISO']),
                                    category: task['category'],
                                  ),
                                  onDelete: () => deleteTask(index),
                                  onEdit: () => editTask(
                                    Task(
                                      title: task['title'],
                                      day: DateFormat("dd MMMM yyyy").format(
                                          DateTime.parse(task['startTimeISO'])),
                                      description: task['description'],
                                      startTime:
                                          DateTime.parse(task['startTimeISO']),
                                      endTime:
                                          DateTime.parse(task['endTimeISO']),
                                      category: task['category'],
                                    ),
                                    index,
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
