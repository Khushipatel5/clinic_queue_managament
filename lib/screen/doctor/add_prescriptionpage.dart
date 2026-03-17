import 'dart:convert';
import 'package:clinic_queue_management/api/consts.dart';
import 'package:flutter/material.dart';
import 'package:clinic_queue_management/api/api_client.dart';
import 'package:clinic_queue_management/services/prefrence_service.dart';
import 'package:clinic_queue_management/model/prescription_model.dart';

class AddPrescriptionPage extends StatefulWidget {
  const AddPrescriptionPage({super.key});

  @override
  State<AddPrescriptionPage> createState() => _AddPrescriptionPageState();
}

class _AddPrescriptionPageState extends State<AddPrescriptionPage> {
  final ApiClient api = ApiClient();
  final _notesController = TextEditingController();

  List<Medicines> medicinesList = [];

  bool _isLoading = false;

  void _addMedicine() {
    setState(() {
      medicinesList.add(Medicines(name: '', dosage: '', duration: ''));
    });
  }

  void _removeMedicine(int index) {
    setState(() {
      medicinesList.removeAt(index);
    });
  }

  Future<void> _submitPrescription() async {
    if (medicinesList.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Add at least 1 medicine")));
      return;
    }

    setState(() => _isLoading = true);

    PrescriptionModel prescription = PrescriptionModel(
      notes: _notesController.text,
      medicines: medicinesList,
    );

      final token = await SharedprefrencesService().getToken();

      final response = await api.post(
        prescriptionsApi, // replace with your API endpoint
        jsonDecode(prescriptionModelToJson(prescription)),

      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Prescription sent!")));
        _notesController.clear();
        setState(() => medicinesList.clear());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.statusCode}")),
        );
        print(response.body);
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Prescription")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: medicinesList.length,
                itemBuilder: (context, index) {
                  final med = medicinesList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Medicine ${index + 1}"),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red),
                                onPressed: () => _removeMedicine(index),
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: med.name,
                            decoration:
                            const InputDecoration(labelText: "Name"),
                          ),
                          TextFormField(
                            initialValue: med.dosage,
                            decoration:
                            const InputDecoration(labelText: "Dosage"),
                          ),
                          TextFormField(
                            initialValue: med.duration,
                            decoration: const InputDecoration(
                                labelText: "Duration"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: "Notes",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _addMedicine,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Medicine"),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitPrescription,
                    child: const Text("Submit Prescription"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}