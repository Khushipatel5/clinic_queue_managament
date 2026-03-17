import 'dart:convert';

import 'package:clinic_queue_management/api/api_client.dart';
import 'package:clinic_queue_management/api/consts.dart';
import 'package:clinic_queue_management/model/admin_clinic_view_model.dart';
import 'package:clinic_queue_management/screen/admin/my_users.dart';
import 'package:clinic_queue_management/services/prefrence_service.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

ApiClient api = ApiClient();

class _AdminDashboardState extends State<AdminDashboard> {
  List<AdminClinicViewModel> clinicList = [];

  @override
  void initState() {
    super.initState();
    getClinic();
  }

  Future<void> getClinic() async {
    final response = await api.get(
      adminclinicapi,
      headers: {
        "Authorization": "Bearer ${await SharedprefrencesService().getToken()}"
      },
    );

    print("cliniclist: ${response.body}");

    final decoded = jsonDecode(response.body);

    List data = [];

    if (decoded is Map) {
      data = [decoded];
    }

    setState(() {
      clinicList = data.map((e) => AdminClinicViewModel.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY CLINIC'),
        actions: [TextButton(onPressed: () => {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyUsersPage(),))
        }, child: Text('My User'))],
      ),
      body: clinicList.isEmpty
          ? const Center(child: Text("No Clinics Found"))
          : ListView.builder(
              itemCount: clinicList.length,
              itemBuilder: (context, index) {
                final clinic = clinicList[index];

                return ListTile(
                  title: Text(clinic.name ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Code: ${clinic.code ?? ''}"),
                      Text("Users: ${clinic.userCount ?? 0}"),
                      Text("Appointments: ${clinic.appointmentCount ?? 0}"),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
