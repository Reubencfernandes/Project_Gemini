import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  DateTime now = DateTime.now().toUtc();
  DateTime selectedDate = DateTime.now().toUtc();
  late DateTime lastDate = DateTime(now.year + 1, now.month, now.day);
  late String formattedMonth = DateFormat('MMMM dd').format(selectedDate);
  final TextEditingController nameController = TextEditingController();

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
              child: child!);
        });
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedMonth = DateFormat('MMMM dd, yyyy').format(selectedDate);
      });
    }
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // Add space between elements
            Text("Enter Your Name"),
            const SizedBox(height: 10), // Add space between elements
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Reuben',
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 20), // Add space between elements
            Text("Enter Your Birthday"),
            const SizedBox(height: 10), // Add space between elements
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
    );
  }
}
