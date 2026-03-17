import 'package:clinic_queue_management/screen/patient/appoinment_page.dart';
import 'package:clinic_queue_management/screen/patient/book_appoinment.dart';
import 'package:clinic_queue_management/screen/patient/prescription_page.dart';
import 'package:clinic_queue_management/screen/patient/reports_page.dart';
import 'package:flutter/material.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patient Dashboard')),
      body: Column(
        children: [
          ListTile(
            title: const Text("My Appointments"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyAppointmentsPage()),
              );
            },
          ),
          ListTile(
            title: const Text("Reports"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReportsPage()),
              );
            },
          ),
          ListTile(
            title: const Text("Prescription"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrescriptionPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}