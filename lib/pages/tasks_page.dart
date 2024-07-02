import 'package:ayumi/Services/auth_service.dart';
import 'package:ayumi/entities/my_user.dart';
import 'package:ayumi/pages/components/bottom_tab_navigation.dart';
import 'package:ayumi/pages/components/plans_for_today.dart';
import 'package:ayumi/pages/components/task_card.dart';
import 'package:ayumi/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().toLocal();
    String formattedTime = DateFormat('hh:mm a').format(now);
    String formattedMonth = DateFormat('MMMM dd, yyyy').format(now);

    List<Widget> buildCards() {
      return DatabaseService().tasks.map((task) {
        return TaskCard(task: task);
      }).toList();
    }

    MyUser user = AuthService().getCurrentUser();

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
                      child: Image.network(
                        user.photoUrl,
                        fit: BoxFit.cover,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  PlansForToday(),
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
//9
