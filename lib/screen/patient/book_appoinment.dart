import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:clinic_queue_management/api/api_client.dart';
import 'package:clinic_queue_management/api/consts.dart';
import 'package:clinic_queue_management/services/prefrence_service.dart';
import 'package:flutter/material.dart';

class AddAppointmentPage extends StatefulWidget {
  const AddAppointmentPage({super.key});

  @override
  State<AddAppointmentPage> createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  ApiClient api = ApiClient();

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);

      timeController.clear();
    }
  }

  Future<void> pickTime() async {
    if (dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select date first")),
      );
      return;
    }

    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {


      final selectedDate = DateTime.parse(dateController.text);

      final startDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        picked.hour,
        picked.minute,
      );

      if (startDateTime.isBefore(DateTime.now())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cannot select past time")),
        );
        return;
      }

      final endDateTime = startDateTime.add(const Duration(minutes: 15));

      String formatTime(DateTime dt) {
        return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
      }

      final slot =
          "${formatTime(startDateTime)}-${formatTime(endDateTime)}";

      timeController.text = slot;
    }
  }

  String? validateTimeSlot(String? value) {
    if (value == null || value.isEmpty) {
      return "Time is required";
    }

    if (!value.contains("-")) {
      return "Invalid format (use 10:00-10:15)";
    }

    return null;
  }

  Future<void> bookAppointment() async {
    if (!formKey.currentState!.validate()) return;

    String? token = await SharedprefrencesService().getToken();
    int? patientId = await SharedprefrencesService().getUserId();
    int? clinicId = await SharedprefrencesService().getClinicId();

    if (token == null || patientId == null || clinicId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login again")),
      );
      return;
    }

    Map<String, dynamic> body = {
      "appointmentDate": dateController.text,
      "timeSlot": timeController.text,
      "status": "scheduled",
      "patientId": patientId,
      "clinicId": clinicId,
    };

    var response = await api.post(appointmentApi, body);

    print(response.statusCode);
    print(response.body);


      Navigator.pop(context, true);

  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book Appointment")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            children: [

              TextFormField(
                controller: dateController,
                readOnly: true,
                onTap: pickDate,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Date required" : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: timeController,
                readOnly: true,
                onTap: pickTime,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time),
                ),
                validator: validateTimeSlot,
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: bookAppointment,
                  child: const Text("Book Appointment"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}