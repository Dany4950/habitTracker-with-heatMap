import 'package:habit_tracker/date.time.dart';
import 'package:habit_tracker/main.dart';
import 'package:hive/hive.dart';

final _myBox = Hive.box("Habit_db");

class HabitDb {
  List habitData = [];
  void createData() {
    habitData = [
      ["Bible Study ", true],
      ["Bible Study ", true],
      ["walk ", false],
    ];
  }

  void loadData() {
    if (_myBox.get(todayDateFormatted()) == null) {
      habitData = _myBox.get("Current_habit_list");
      for (int i = 0; i < habitData.length; i++) {
        habitData[i][1] = false;
      }
    } else {
      habitData = _myBox.get(todayDateFormatted());
    }
  }

  void uploadData() {
    _myBox.put(todayDateFormatted(), habitData);
    _myBox.put("Current_habit_list", habitData);
  }
}
