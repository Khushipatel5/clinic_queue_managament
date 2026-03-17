import 'dart:convert';
import 'package:clinic_queue_management/screen/doctor/add_prescriptionpage.dart';
import 'package:flutter/material.dart';
import 'package:clinic_queue_management/api/api_client.dart';
import 'package:clinic_queue_management/api/consts.dart';
import 'package:clinic_queue_management/model/queue_model.dart';
import 'package:clinic_queue_management/services/prefrence_service.dart';

class ViewQueueDoctor extends StatefulWidget {
  const ViewQueueDoctor({super.key});

  @override
  State<ViewQueueDoctor> createState() => _ViewQueueDoctorState();
}

class _ViewQueueDoctorState extends State<ViewQueueDoctor> {
  List<QueueModel> queueList = [];
  ApiClient api = ApiClient();

  @override
  void initState() {
    super.initState();
    fetchQueue();
  }

  Future<void> fetchQueue() async {

      final token = await SharedprefrencesService().getToken();
      final response = await api.get(
        getQueueApi,
        headers: {"Authorization": "Bearer $token"},
      );

      print("STATUS CODE: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        List data = decoded is List ? decoded : (decoded['data'] ?? []);
        setState(() {
          queueList = data.map((e) => QueueModel.fromJson(e)).toList();
        });
      }


  }
  Future<void> updateStatus(int id) async {
    var response = await api.put(
      "$getQueueApi/$id",
      {
        "status": "done",
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      fetchQueue();
    } else {
      print("Error updating status");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Queue')),

      body: queueList.isEmpty
          ? const Center(child: Text("No Queue"))
          : ListView.builder(
        itemCount: queueList.length,
        itemBuilder: (context, index) {
          final q = queueList[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPrescriptionPage(),));
              },
              title: Text(
                q.appointment?.patient?.name ?? "No Name",
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Phone: ${q.appointment?.patient?.phone ?? ''}"),
                  Text("Token: ${q.tokenNumber}"),
                  Text("Status: ${q.status}"),
                ],
              ),

              trailing: ElevatedButton(
                onPressed: () {
                  updateStatus(q.id!.toInt());
                },
                child: const Text("Done"),
              )
            ),
          );
        },
      ),
    );
  }
}