import 'dart:collection';

import 'package:clinic_queue_management/screen/doctor/view_queue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
              Text('DOCTOR DASHBOARD'),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text('View Queue'),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewQueueDoctor(),
                ));
          },
        ),
      )
    ])));
  }
}
