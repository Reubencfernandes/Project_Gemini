import 'dart:async';

import 'package:ayumi/pages/components/tasks_for_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  Timer? timer;
  late DateTime now = DateTime.now().toLocal();
  late String formattedTime = DateFormat('hh:mm a').format(now);
  late String formattedMonth = DateFormat('MMMM dd, yyyy').format(now);
  late DateTime selectedDate = DateTime.now();
  late DateTime lastDate = DateTime(now.year, now.month + 1, now.day);
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(minutes: 1), (t)
    {
     setState(() {
       formattedTime = DateFormat('hh:mm a').format(DateTime.now().toLocal());
     });
    });
  }


  @override
  void dispose()
  {
    super.dispose();
    timer?.cancel();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedTime,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 32,
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formattedMonth,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: Image.asset('images/user.jpg')
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Select Date",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.black,
                              fontSize: 15)),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onTap: () => _selectDate(context),
                        readOnly: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                          hintText: formattedMonth,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                TasksForDate(
                    day: DateFormat("dd MMMM yyyy").format(selectedDate)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
