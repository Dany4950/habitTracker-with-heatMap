import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool boxStatus;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingButton;
  final Function(BuildContext) cancelbutton;
  const HabitTile({
    super.key,
    required this.boxStatus,
    required this.onChanged,
    required this.habitName,
    required this.settingButton,
    required this.cancelbutton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(27.0),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(12),
            onPressed: settingButton,
            icon: Icons.settings,
            backgroundColor: Colors.grey.shade500,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(12),
            onPressed: cancelbutton,
            icon: Icons.delete_forever,
            backgroundColor: Colors.red.shade400,
          ),
        ]),
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
      ),
    );
  }
}
