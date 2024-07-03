import 'package:ayumi/pages/components/task_card.dart';
import 'package:ayumi/services/database_service.dart';
import 'package:flutter/material.dart';

class PlansForToday extends StatelessWidget {
  const PlansForToday({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: DatabaseService(),
      builder: (context, Widget? child) {
        return Column(
          children: buildPlansForToday(),
        );
      },
    );
  }

  List<Widget> buildPlansForToday() {
    var cards = DatabaseService().tasks.map((task) {
      return TaskCard(task: task);
    }).toList();

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Plans",
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${cards.length} Tasks",
            style: const TextStyle(
              color: Colors.blue,
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      ...cards,
    ];
  }
}
