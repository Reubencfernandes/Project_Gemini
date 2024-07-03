import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatesOfTasks extends StatefulWidget {
  const DatesOfTasks({super.key});

  @override
  State<DatesOfTasks> createState() => _DatesOfTasksState();
}

class _DatesOfTasksState extends State<DatesOfTasks> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 30),backgroundColor: Colors.black),
              child: const Column(
            children: [
              Text("Fri",style: TextStyle(fontFamily: 'Inter',fontSize: 14,color: Colors.grey)),
              SizedBox(height: 10,),
              Text("6",style: TextStyle(fontFamily: 'Inter',fontSize: 24,color: Colors.white))
            ],
          )),
          const SizedBox(width: 10,),

        ],
      ),
    );
  }
}
