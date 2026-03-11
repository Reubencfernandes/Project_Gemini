import 'package:ayumi/entities/task.dart';
import 'package:ayumi/pages/components/task_card.dart';
import 'package:ayumi/services/database_service.dart';
import 'package:flutter/material.dart';

class TasksForDate extends StatefulWidget {
  final String day;

  const TasksForDate({super.key, required this.day});

  @override
  State<TasksForDate> createState() => _TasksForDateState();
}

class _TasksForDateState extends State<TasksForDate> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    DatabaseService().addListener(_onDatabaseChanged);
    _loadTasks();
  }

  @override
  void dispose() {
    DatabaseService().removeListener(_onDatabaseChanged);
    super.dispose();
  }

  void _onDatabaseChanged() => _loadTasks();

  Future<void> _loadTasks() async {
    final tasks = await DatabaseService().getTasksForDate(widget.day);
    if (mounted) setState(() => _tasks = tasks);
  }

  @override
  Widget build(BuildContext context) {
    final cards = _tasks.map((task) => TaskCard(task: task)).toList();
    return Column(
      children: [
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
      ],
    );
  }
}
