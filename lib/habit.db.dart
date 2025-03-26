import 'package:habit_tracker/date.time.dart';
import 'package:hive/hive.dart';

final _myBox = Hive.box("Habit_db");

class HabitDb {
  List habitData = [];
  Map<DateTime, int> heatMapdataset = {};
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

    calculatehabitpercentage();
  }

  void calculatehabitpercentage() {
    int completed = 0;
    for (int i = 0; i < habitData.length; i++) {
      if (habitData[i][1] == true) {
        completed++;
      }
    }
    String percent = habitData.isEmpty
        ? '0.0'
        : (completed / habitData.length).toStringAsFixed(1);
    _myBox.put("Percentage_summary${todayDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    int daysinBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysinBetween; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );
      double strength = double.parse(
        _myBox.get("Percentage_summary$yyyymmdd") ?? "0.0",
      );

      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int days = startDate.add(Duration(days: i)).day;

      final percentageforEachDay = <DateTime, int>{
        DateTime(year, month, days): (10 * strength).toInt(),
      };
      heatMapdataset.addEntries(percentageforEachDay.entries);
      print(heatMapdataset);
    }
  }
}
