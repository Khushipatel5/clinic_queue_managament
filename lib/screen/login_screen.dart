import 'dart:convert';

import 'package:clinic_queue_management/api/api_client.dart';
import 'package:clinic_queue_management/api/consts.dart';
import 'package:clinic_queue_management/screen/admin/admin_dashboard.dart';
import 'package:clinic_queue_management/screen/doctor/doctor_dashboard.dart';
import 'package:clinic_queue_management/screen/patient/patient_dashboard.dart';
import 'package:clinic_queue_management/screen/receptionist/receptionist_dashboard.dart';
import 'package:clinic_queue_management/services/jwt_service.dart';
import 'package:clinic_queue_management/services/prefrence_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  final formkey = GlobalKey<FormState>();

  ApiClient api = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(25)),
          height: 350,
          width: 400,
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text('Login',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "UserName",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null) {
                            return "it should not be null";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Password",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: password,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null) {
                            return 'it should not be null';
                          }

                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        http.Response response = await api.login(loginapi, {
                          "email": email.text.toString(),
                          "password": password.text.toString()
                        });
                        if (response.statusCode == 200) {
                          Map<String, dynamic> map = jsonDecode(response.body);
                          print(map);
                          SharedprefrencesService().saveToken(map['token']);
                          String? Role = await JWTtokenService.finduserRole();
                          print(await JWTtokenService.gettokendata());
                          await SharedprefrencesService().saveToken(map["token"]);
                          await SharedprefrencesService().setUserId(map["user"]["id"]);
                          await SharedprefrencesService().setClinicId(map["user"]["clinicId"]);

                          if (Role != null) {
                            print(Role);

                            if (Role == 'admin') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminDashboard(),
                                  ));
                            }
                            if (Role == 'doctor') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorDashboard(),
                                  ));
                            }
                            if (Role == 'patient') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PatientDashboard(),
                                  ));
                            }
                            if (Role == 'receptionist') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReceptionistDashboard(),
                                  ));
                            }
                          }
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
