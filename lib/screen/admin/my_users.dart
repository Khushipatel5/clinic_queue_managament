// import 'dart:convert';
//
// import 'package:clinic_queue_management/api/consts.dart';
// import 'package:clinic_queue_management/model/admin_user_view_model.dart';
// import 'package:clinic_queue_management/screen/admin/admin_dashboard.dart';
// import 'package:clinic_queue_management/services/prefrence_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class MyUsersPage extends StatefulWidget {
//    MyUsersPage({super.key});
//
//   @override
//   State<MyUsersPage> createState() => _MyUsersPageState();
// }
//
// class _MyUsersPageState extends State<MyUsersPage> {
//   @override
//   Widget build(BuildContext context) {
//     List<AdminUserViewModel> userlist = [];
//     Future<void> getUser() async {
//       final response = await api.get(
//         adminusercapi,
//         headers: {
//           "Authorization": "Bearer ${await SharedprefrencesService().getToken()}"
//         },
//       );
//
//       print("userlist: ${response.body}");
//
//       final decoded = jsonDecode(response.body);
//
//       List data = [];
//
//       if (decoded is Map) {
//         data = [decoded];
//       }
//
//       setState(() {
//         userlist= data.map((e) => AdminUserViewModel.fromJson(e)).toList();
//       });
//     }
//
//     @override
//     void initState() {
//       super.initState();
//       getUser();
//     }
//
//
//     return Scaffold(
//       appBar: AppBar(actions: [TextButton(onPressed: () => {
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminDashboard(),))
//       }, child: Text('myclinic'))],),
//         body:userlist.isEmpty
//             ? const Center(child: Text("No User Found"))
//             : ListView.builder(
//           itemCount: userlist.length,
//           itemBuilder: (context, index) {
//             final user = userlist[index];
//
//             return ListTile(
//               title: Text(user.name ?? ''),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("email: ${user.email ?? ''}"),
//                   Text("phone: ${user.phone ?? 'not given'}"),
//                   Text("role: ${user.role ?? 0}"),
//                 ],
//               ),
//             );
//           },
//         ),
//     );
//   }
// }
import 'dart:convert';

import 'package:clinic_queue_management/api/consts.dart';
import 'package:clinic_queue_management/model/admin_user_view_model.dart';
import 'package:clinic_queue_management/screen/admin/add_user.dart';
import 'package:clinic_queue_management/screen/admin/admin_dashboard.dart';
import 'package:clinic_queue_management/services/prefrence_service.dart';
import 'package:flutter/material.dart';

class MyUsersPage extends StatefulWidget {
  const MyUsersPage({super.key});

  @override
  State<MyUsersPage> createState() => _MyUsersPageState();
}

class _MyUsersPageState extends State<MyUsersPage> {
  List<AdminUserViewModel> userlist = [];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
      final response = await api.get(
        adminusercapi,
        headers: {
          "Authorization":
          "Bearer ${await SharedprefrencesService().getToken()}",
        },
      );

      print("userlist: ${response.body}");

      final decoded = jsonDecode(response.body);

      List data = [];

      if (decoded is List) {
        data = decoded;
      } else if (decoded is Map) {
        data = [decoded];
      }

      setState(() {
        userlist =
            data.map((e) => AdminUserViewModel.fromJson(e)).toList();
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminDashboard(),
                ),
              );
            },
            child: const Text("My Clinic"),
          ),
        ],
      ),
      floatingActionButton: IconButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddUser(),));
      }, icon: Icon(Icons.add)),
      body:  userlist.isEmpty
          ? const Center(child: Text("No User Found"))
          : ListView.builder(
        itemCount: userlist.length,
        itemBuilder: (context, index) {
          final user = userlist[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(user.name ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: ${user.email ?? ''}"),
                  Text(
                      "Phone: ${user.phone?.isEmpty ?? true ? 'Not given' : user.phone}"),
                  Text("Role: ${user.role ?? ''}"),
                ],
              ),
            ),
          );
        },
      ),

    );
  }
}