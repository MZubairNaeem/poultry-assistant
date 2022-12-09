import 'package:flutter/material.dart';

class ComingSchedule extends StatefulWidget {
  const ComingSchedule({Key? key}) : super(key: key);

  @override
  State<ComingSchedule> createState() => _ComingScheduleState();
}

class _ComingScheduleState extends State<ComingSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Coming Schedule',),
      ),
    );
  }
}
