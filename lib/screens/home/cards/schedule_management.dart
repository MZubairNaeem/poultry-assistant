import 'package:flutter/material.dart';

class ScheduleManagement extends StatefulWidget {
  const ScheduleManagement({Key? key}) : super(key: key);

  @override
  State<ScheduleManagement> createState() => _ScheduleManagementState();
}

class _ScheduleManagementState extends State<ScheduleManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "Add a Schedule"
        ),
      ),
    );
  }
}
