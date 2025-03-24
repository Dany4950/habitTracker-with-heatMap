import 'package:flutter/material.dart';
import 'package:habit_tracker/habit_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // State variables can be declared here
  bool boxStatus = true;

  void changingStatusOfBox(bool? value) {
    setState(() {
      // Update your state here
      boxStatus = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          const SizedBox(height: 30),
          HabitTile(
            boxStatus: boxStatus,
            habitName: "Read Bible",
            onChanged: changingStatusOfBox, 
          )
        ],
      ),
    );
  }
}
