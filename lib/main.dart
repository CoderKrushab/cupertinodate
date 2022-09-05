import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    home: dateandtime(),
  ));
}
class dateandtime extends StatefulWidget {
  const dateandtime({Key? key}) : super(key: key);

  @override
  State<dateandtime> createState() => _dateandtimeState();
}

class _dateandtimeState extends State<dateandtime> {
  DateTime selectdate = DateTime.now();
  final firstdate = DateTime(2000, 1);
  final lastdate = DateTime(2025, 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Date & Time"),
      ),
      body: Column(
        children: [
          Center(
              child: Text(
                "$selectdate".split(' ')[0],
                style: const TextStyle(fontSize: 24),
              )),
          const Divider(),
          ElevatedButton(
              onPressed: () => ondate(context),
              child: const Text("Select Date")),
          const Divider(),
          CalendarDatePicker(
              initialDate: selectdate,
              firstDate: firstdate,
              lastDate: lastdate,
              onDateChanged: (newDate) {
                print("New Date $newDate");
                setState(() {
                  selectdate = newDate;
                });
              }),
          const Divider(),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectdate,
              minimumDate: firstdate,
              maximumDate: lastdate,
              onDateTimeChanged: (newDate) {
                setState(() {
                  SystemSound.play(SystemSoundType.click);
                  selectdate = newDate;
                });
                print("New Date $newDate");
              },
            ),
          )
        ],
      ),
    );
  }

  ondate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectdate,
        firstDate: firstdate,
        lastDate: lastdate);
    print('Date $date');
    if (date != null) {
      setState(() {
        selectdate = date;
      });
    }
  }
}
