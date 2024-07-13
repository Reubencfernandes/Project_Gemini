
import 'package:ayumi/entities/user.dart';
import 'package:ayumi/pages/components/bottom_tab_navigation.dart';
import 'package:ayumi/pages/components/plans_for_today.dart';
import 'package:ayumi/pages/components/task_card.dart';
import 'package:ayumi/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:intl/intl.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late DateTime now = DateTime.now().toLocal();
  late String formattedTime = DateFormat('hh:mm a').format(now);
  late String formattedMonth = DateFormat('MMMM dd, yyyy').format(now);
  late DateTime selectedDate = DateTime.now();
  late DateTime lastDate = DateTime(now.year, now.month + 1, now.day);
  @override
  void initState() {
    super.initState();
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

  List<Widget> buildCards() {
    return DatabaseService().tasks.map((task) {
      return TaskCard(task: task);
    }).toList();
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
                    child: Image.network(
                      "https://yt3.ggpht.com/ytc/AIdro_lG10P4m8LYfMtwEO1KRLthQrqWR2aDuGEAi4TVCVbJsJc=s48-c-k-c0x00ffffff-no-rj",
                      fit: BoxFit.cover,
                    ),
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
                        SizedBox(height: 10,),
                        const Text("Select Date",style: TextStyle(fontFamily: 'Inter',color: Colors.black,fontSize: 15)),
                        SizedBox(height: 10,),
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
                  const PlansForToday(),
                  ...buildCards(),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
