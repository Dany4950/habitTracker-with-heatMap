import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool boxStatus;
  final Function(bool?)? onChanged;
  const HabitTile({
    super.key,
    required this.boxStatus,
    required this.onChanged,
    required this.habitName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        //container's css
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        height: 120,
        width: 350,

        child: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Checkbox(value: boxStatus, onChanged: onChanged),
            Expanded(
              child: Text(
                habitName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
