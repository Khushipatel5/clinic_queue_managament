import 'dart:convert';

/// id : 0
/// tokenNumber : 0
/// status : "waiting"
/// queueDate : "2026-03-17"
/// appointmentId : 0
/// appointment : {"patient":{"name":"string","phone":"string"}}

QueueModel queueModelFromJson(String str) =>
    QueueModel.fromJson(json.decode(str));

String queueModelToJson(QueueModel data) => json.encode(data.toJson());

class QueueModel {
  QueueModel({
    num? id,
    num? tokenNumber,
    String? status,
    String? queueDate,
    num? appointmentId,
    Appointment? appointment,
  }) {
    _id = id;
    _tokenNumber = tokenNumber;
    _status = status;
    _queueDate = queueDate;
    _appointmentId = appointmentId;
    _appointment = appointment;
  }

  QueueModel.fromJson(dynamic json) {
    _id = json['id'];
    _tokenNumber = json['tokenNumber'];
    _status = json['status'];
    _queueDate = json['queueDate'];
    _appointmentId = json['appointmentId'];
    _appointment = json['appointment'] != null
        ? Appointment.fromJson(json['appointment'])
        : null;
  }

  num? _id;
  num? _tokenNumber;
  String? _status;
  String? _queueDate;
  num? _appointmentId;
  Appointment? _appointment;

  QueueModel copyWith({
    num? id,
    num? tokenNumber,
    String? status,
    String? queueDate,
    num? appointmentId,
    Appointment? appointment,
  }) =>
      QueueModel(
        id: id ?? _id,
        tokenNumber: tokenNumber ?? _tokenNumber,
        status: status ?? _status,
        queueDate: queueDate ?? _queueDate,
        appointmentId: appointmentId ?? _appointmentId,
        appointment: appointment ?? _appointment,
      );

  num? get id => _id;

  num? get tokenNumber => _tokenNumber;

  String? get status => _status;

  String? get queueDate => _queueDate;

  num? get appointmentId => _appointmentId;

  Appointment? get appointment => _appointment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['tokenNumber'] = _tokenNumber;
    map['status'] = _status;
    map['queueDate'] = _queueDate;
    map['appointmentId'] = _appointmentId;
    if (_appointment != null) {
      map['appointment'] = _appointment?.toJson();
    }
    return map;
  }
}

/// patient : {"name":"string","phone":"string"}

Appointment appointmentFromJson(String str) =>
    Appointment.fromJson(json.decode(str));

String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
  Appointment({
    Patient? patient,
  }) {
    _patient = patient;
  }

  Appointment.fromJson(dynamic json) {
    _patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
  }

  Patient? _patient;

  Appointment copyWith({
    Patient? patient,
  }) =>
      Appointment(
        patient: patient ?? _patient,
      );

  Patient? get patient => _patient;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_patient != null) {
      map['patient'] = _patient?.toJson();
    }
    return map;
  }
}

/// name : "string"
/// phone : "string"

Patient patientFromJson(String str) => Patient.fromJson(json.decode(str));

String patientToJson(Patient data) => json.encode(data.toJson());

class Patient {
  Patient({
    String? name,
    String? phone,
  }) {
    _name = name;
    _phone = phone;
  }

  Patient.fromJson(dynamic json) {
    _name = json['name'];
    _phone = json['phone'];
  }

  String? _name;
  String? _phone;

  Patient copyWith({
    String? name,
    String? phone,
  }) =>
      Patient(
        name: name ?? _name,
        phone: phone ?? _phone,
      );

  String? get name => _name;

  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['phone'] = _phone;
    return map;
  }
}
