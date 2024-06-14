import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Image.asset("images/final.jpg"),
          const Text("Daily Task Planner", style: TextStyle(color: Colors.white),),
          const Text("Effortlessly Plan Your Day",style: TextStyle(color: Colors.white),),
          ElevatedButton(onPressed: (){
          }, child: const Text("Get Started")
          )
        ],
      ),
    );
  }
}
