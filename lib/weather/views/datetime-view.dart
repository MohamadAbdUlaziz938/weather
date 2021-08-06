import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/media/date.dart';

class DateView extends StatelessWidget {
  DateTime  Time;
  DateView({Key key, @required this.Time})
      : assert(Time != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        Time.isToday()
            ? "Today ${DateFormat('MMMd').format(Time).toString()}" : Time.isTomorrow()?"Tomorrow,${DateFormat('MMMd').format(Time).toString()}":"${DateFormat('MMMEd').format(Time).toString()}",
        style: TextStyle(color: Colors.white,fontSize: 16),
      ),
    );
  }
}
