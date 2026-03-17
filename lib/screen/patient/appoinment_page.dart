import 'dart:convert';
import 'package:clinic_queue_management/api/api_client.dart';
import 'package:clinic_queue_management/api/consts.dart';
import 'package:clinic_queue_management/model/appoinment_model.dart';
import 'package:clinic_queue_management/screen/patient/book_appoinment.dart';
import 'package:clinic_queue_management/services/prefrence_service.dart';
import 'package:flutter/material.dart';

class MyAppointmentsPage extends StatefulWidget {
  const MyAppointmentsPage({super.key});

  @override
  State<MyAppointmentsPage> createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends State<MyAppointmentsPage> {
  List<AppoinmentModel> appointmentList = [];

  ApiClient api = ApiClient();

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {


    final response = await api.get(
      getappointmentApi,
      headers: {
        "Authorization":
        "Bearer ${await SharedprefrencesService().getToken()}",
      },
    );

    print("appointments: ${response.body}");

    final decoded = jsonDecode(response.body);

    List data = [];

    if (decoded is List) {
      data = decoded;
    } else if (decoded is Map) {
      data = [decoded];
    }

    setState(() {
      appointmentList =
          data.map((e) => AppoinmentModel.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddAppointmentPage()),
          );

          if (result == true) {
            fetchAppointments();
          }
        },
        child: const Icon(Icons.add),
      ),

      body: appointmentList.isEmpty
          ? const Center(child: Text("No Appointments Found"))
          : ListView.builder(
        itemCount: appointmentList.length,
        itemBuilder: (context, index) {
          final appt = appointmentList[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                appt.id.toString()??''
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Phone: ${appt.queueEntry?.appointment?.patient?.phone ?? 'N/A'}"),
                  Text(
                      "Date: ${appt.appointmentDate ?? ''}"),
                  Text(
                      "Time: ${appt.timeSlot ?? ''}"),
                  Text(
                      "Token: ${appt.queueEntry?.tokenNumber ?? ''}"),
                  Text(
                      "Status: ${appt.status ?? ''}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}