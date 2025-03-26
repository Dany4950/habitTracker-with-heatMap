import 'package:flutter/material.dart';
import 'package:habit_tracker/habit.db.dart';
import 'package:habit_tracker/habit_tile.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox("Habit_db");
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
  HabitDb db = HabitDb();
  final _mybox = Hive.box("Habit_db");

  @override
  void initState() {
    if (_mybox.get("current_habit_list") == null) {
      db.createData();
    } else {
      db.loadData();
    }

    db.uploadData();
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController alertTextController = TextEditingController();

  void changingStatusOfBox(bool? value, index) {
    setState(() {
      // Update your state here
      db.habitData[index][1] = value;
    });
    db.uploadData();
  }

  void showDialogBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: alertTextController,
              decoration: InputDecoration(
                  hintText: "Type Your Habit Name ",
                  enabledBorder: OutlineInputBorder()),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      db.habitData.add([alertTextController.text, false]);
                    });
                    
                    alertTextController.clear();
                    
                    Navigator.of(context).pop();
                    db.uploadData();
                  },
                  child: Text("Save")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    db.uploadData();
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
                      db.habitData[index][0] = alertTextController.text;
                    });
                    alertTextController.clear();
                    Navigator.of(context).pop();
                    db.uploadData();
                  },
                  child: Text("Save")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    db.uploadData();
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }

  void deleteTile(int index) {
    setState(() {
      db.habitData.removeAt(index);
    });
    db.uploadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemCount: db.habitData.length,
        itemBuilder: (context, index) {
          return HabitTile(
              settingButton: (p0) {
                settingButtonEdit(index);
              },
              cancelbutton: (p0) => deleteTile(index),
              boxStatus: db.habitData[index][1],
              onChanged: (value) => changingStatusOfBox(value, index),
              habitName: db.habitData[index][0]);
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
