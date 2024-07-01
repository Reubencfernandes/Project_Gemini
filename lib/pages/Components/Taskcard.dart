import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 15, bottom: 30, left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {}, // Non-null callback
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[100],
              ),
              child: Text(
                "Work",
                style: TextStyle(
                  color: Colors.red[900],
                  fontFamily: 'Inter',
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Colors.black,
                fontSize: 14,
              ),
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(
                  Icons.timer,
                  color: Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  time,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
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
