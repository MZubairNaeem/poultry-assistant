import 'package:flutter/material.dart';

import 'create_schedule.dart';

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
        title: const Text(
            "Add a Schedule"
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10,
        icon: const Icon(Icons.add_box),
        label: const Text('Add Schedule'),
        //('+',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30,color: Colors.white),),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateSchedule()));
        },
      ),
    );
  }
}
