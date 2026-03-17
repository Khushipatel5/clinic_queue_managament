import 'dart:convert';

/// id : 206
/// name : "Khushiben Patel"
/// email : "23010101202@darshan.ac.in"
/// role : "admin"
/// phone : ""
/// createdAt : "2026-03-16T13:49:16.000Z"

AdminUserViewModel adminUserViewModelFromJson(String str) =>
    AdminUserViewModel.fromJson(json.decode(str));

String adminUserViewModelToJson(AdminUserViewModel data) =>
    json.encode(data.toJson());

class AdminUserViewModel {
  AdminUserViewModel({
    num? id,
    String? name,
    String? email,
    String? role,
    String? phone,
    String? createdAt,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _role = role;
    _phone = phone;
    _createdAt = createdAt;
  }

  AdminUserViewModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _role = json['role'];
    _phone = json['phone'];
    _createdAt = json['createdAt'];
  }

  num? _id;
  String? _name;
  String? _email;
  String? _role;
  String? _phone;
  String? _createdAt;

  AdminUserViewModel copyWith({
    num? id,
    String? name,
    String? email,
    String? role,
    String? phone,
    String? createdAt,
  }) =>
      AdminUserViewModel(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        role: role ?? _role,
        phone: phone ?? _phone,
        createdAt: createdAt ?? _createdAt,
      );

  num? get id => _id;

  String? get name => _name;

  String? get email => _email;

  String? get role => _role;

  String? get phone => _phone;

  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['role'] = _role;
    map['phone'] = _phone;
    map['createdAt'] = _createdAt;
    return map;
  }
}
