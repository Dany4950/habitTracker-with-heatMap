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
  final TextEditingController alertTextController = TextEditingController();
  List habitData = [
    ["Bible Study ", true],
    ["Bible Study ", true],
    ["walk ", false],
  ];
  void changingStatusOfBox(bool? value, index) {
    setState(() {
      // Update your state here
      habitData[index][1] = value;
    });
  }

  void showDialogBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: alertTextController,
              decoration: InputDecoration(enabledBorder: OutlineInputBorder()),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      habitData.add([alertTextController.text, false]);
                    });
                    alertTextController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text("Save")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }

  void settingButtonEdit(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: alertTextController,
              decoration: InputDecoration(enabledBorder: OutlineInputBorder()),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      habitData[index][0] = alertTextController.text;
                    });
                    alertTextController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text("Save")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }

  void deleteTile(int index) {
    setState(() {
      habitData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemCount: habitData.length,
        itemBuilder: (context, index) {
          return HabitTile(
              settingButton: (p0) {
                settingButtonEdit(index);
              },
              cancelbutton: (p0) => deleteTile(index),
              boxStatus: habitData[index][1],
              onChanged: (value) => changingStatusOfBox(value, index),
              habitName: habitData[index][0]);
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[400],
          child: Text(
            "+",
            style: TextStyle(fontSize: 25),
          ),
          onPressed: () {
            showDialogBox();
          }),
    );
  }
}
