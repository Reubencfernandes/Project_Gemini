import 'package:flute/pages/Components/navigate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().toLocal();
    String formattedTime = DateFormat('hh:mm a').format(now);
    String formattedMonth = DateFormat('MMMM dd, yyyy').format(now);
    //String formattedMonth = DateFormat('dd').format(now);

    return  Scaffold(
      body:Container(
        margin: const EdgeInsets.only(top: 50,left: 20,right: 20),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(formattedTime, style: TextStyle(fontFamily: 'Inter',
            fontSize: 32,
            color: Colors.indigo[900],
            fontWeight: FontWeight.bold)),
                Text(formattedMonth,style: TextStyle(fontFamily: 'Inter',
                    fontSize: 20,
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold)),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0), // Adjust the radius as needed
              child: SizedBox(
                width: 50.0, // Adjust the width as needed
                height: 50.0, // Adjust the height as needed
                child: Image.asset(
                  "images/final.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        )
      ),
      bottomNavigationBar: lastpart(),
    );
  }
}
