import 'dart:convert';
import 'package:clinic_queue_management/api/api_client.dart';
import 'package:clinic_queue_management/api/consts.dart';
import 'package:clinic_queue_management/services/prefrence_service.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  final formkey = GlobalKey<FormState>();
  ApiClient api = ApiClient();

  String selectedRole = "doctor";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add User')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// NAME
                Text("Name", style: TextStyle(fontSize: 18)),
                TextFormField(
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  decoration: _inputDecoration(),
                ),
                const SizedBox(height: 10),

                Text("Email", style: TextStyle(fontSize: 18)),
                TextFormField(
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  decoration: _inputDecoration(),
                ),
                const SizedBox(height: 10),

                Text("Password", style: TextStyle(fontSize: 18)),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    if (value.length < 6) {
                      return "Min 6 characters";
                    }
                    return null;
                  },
                  decoration: _inputDecoration(),
                ),
                const SizedBox(height: 10),

                Text("Role", style: TextStyle(fontSize: 18)),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  items: ["doctor", "patient", "receptionist"]
                      .map((role) => DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                  decoration: _inputDecoration(),
                ),
                const SizedBox(height: 10),

                Text("Phone (Optional)",
                    style: TextStyle(fontSize: 18)),
                TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;
                    if (value.length != 10) return "Enter valid phone";
                    return null;
                  },
                  decoration: _inputDecoration(),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      String? token =
                      await SharedprefrencesService().getToken();

                      if (token == null || token.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please login again")),
                        );
                        return;
                      }

                      Map<String, dynamic> body = {
                        "name": name.text.trim(),
                        "email": email.text.trim(),
                        "password": password.text.trim(),
                        "role": selectedRole,
                      };

                      if (phone.text.isNotEmpty) {
                        body["phone"] = phone.text.trim();
                      }

                      var response =
                      await api.post(adminusercapi, body);

                      print(response.statusCode);
                      print(response.body);


                        Navigator.pop(context, true);


                    }
                  },
                  child: const Text("Add"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// COMMON INPUT DECORATION
  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}