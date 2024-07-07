import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController nameController = TextEditingController();

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
        margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Column(
          children: [
            const Text("Create An Account "),
            Expanded(
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Reuben',
                ),
                maxLines: 1,
              ),
            ),
            Expanded(
              child: TextField(
                controller: nameController,

                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Reuben',
                ),
                maxLines: 1,
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Bebas Neue',
                      color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}
