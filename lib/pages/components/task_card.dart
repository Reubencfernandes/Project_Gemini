import 'package:ayumi/pages/components/my_badge.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../entities/task.dart';

class TaskCard extends StatefulWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  static final _timeFormat = DateFormat("h:mm a");

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        "${_timeFormat.format(widget.task.startTime)} - ${_timeFormat.format(widget.task.endTime)}";

    return Card(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyBadge(
              text: widget.task.category,
            ),
            const SizedBox(height: 6),
            Text(
              widget.task.title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.task.description,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Colors.black,
                fontSize: 14,
              ),
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.timer,
                  color: Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  formattedTime,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
