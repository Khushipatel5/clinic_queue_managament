import 'dart:convert';
/// id : 0
/// appointmentDate : "2026-03-17"
/// timeSlot : "string"
/// status : "scheduled"
/// patientId : 0
/// clinicId : 0
/// createdAt : "2026-03-17T06:14:35.099Z"
/// queueEntry : {"id":0,"tokenNumber":0,"status":"waiting","queueDate":"2026-03-17","appointmentId":0,"appointment":{"patient":{"name":"string","phone":"string"}}}

AppoinmentModel appoinmentModelFromJson(String str) => AppoinmentModel.fromJson(json.decode(str));
String appoinmentModelToJson(AppoinmentModel data) => json.encode(data.toJson());
class AppoinmentModel {
  AppoinmentModel({
      num? id, 
      String? appointmentDate, 
      String? timeSlot, 
      String? status, 
      num? patientId, 
      num? clinicId, 
      String? createdAt, 
      QueueEntry? queueEntry,}){
    _id = id;
    _appointmentDate = appointmentDate;
    _timeSlot = timeSlot;
    _status = status;
    _patientId = patientId;
    _clinicId = clinicId;
    _createdAt = createdAt;
    _queueEntry = queueEntry;
}

  AppoinmentModel.fromJson(dynamic json) {
    _id = json['id'];
    _appointmentDate = json['appointmentDate'];
    _timeSlot = json['timeSlot'];
    _status = json['status'];
    _patientId = json['patientId'];
    _clinicId = json['clinicId'];
    _createdAt = json['createdAt'];
    _queueEntry = json['queueEntry'] != null ? QueueEntry.fromJson(json['queueEntry']) : null;
  }
  num? _id;
  String? _appointmentDate;
  String? _timeSlot;
  String? _status;
  num? _patientId;
  num? _clinicId;
  String? _createdAt;
  QueueEntry? _queueEntry;
AppoinmentModel copyWith({  num? id,
  String? appointmentDate,
  String? timeSlot,
  String? status,
  num? patientId,
  num? clinicId,
  String? createdAt,
  QueueEntry? queueEntry,
}) => AppoinmentModel(  id: id ?? _id,
  appointmentDate: appointmentDate ?? _appointmentDate,
  timeSlot: timeSlot ?? _timeSlot,
  status: status ?? _status,
  patientId: patientId ?? _patientId,
  clinicId: clinicId ?? _clinicId,
  createdAt: createdAt ?? _createdAt,
  queueEntry: queueEntry ?? _queueEntry,
);
  num? get id => _id;
  String? get appointmentDate => _appointmentDate;
  String? get timeSlot => _timeSlot;
  String? get status => _status;
  num? get patientId => _patientId;
  num? get clinicId => _clinicId;
  String? get createdAt => _createdAt;
  QueueEntry? get queueEntry => _queueEntry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['appointmentDate'] = _appointmentDate;
    map['timeSlot'] = _timeSlot;
    map['status'] = _status;
    map['patientId'] = _patientId;
    map['clinicId'] = _clinicId;
    map['createdAt'] = _createdAt;
    if (_queueEntry != null) {
      map['queueEntry'] = _queueEntry?.toJson();
    }
    return map;
  }

}

/// id : 0
/// tokenNumber : 0
/// status : "waiting"
/// queueDate : "2026-03-17"
/// appointmentId : 0
/// appointment : {"patient":{"name":"string","phone":"string"}}

QueueEntry queueEntryFromJson(String str) => QueueEntry.fromJson(json.decode(str));
String queueEntryToJson(QueueEntry data) => json.encode(data.toJson());
class QueueEntry {
  QueueEntry({
      num? id, 
      num? tokenNumber, 
      String? status, 
      String? queueDate, 
      num? appointmentId, 
      Appointment? appointment,}){
    _id = id;
    _tokenNumber = tokenNumber;
    _status = status;
    _queueDate = queueDate;
    _appointmentId = appointmentId;
    _appointment = appointment;
}

  QueueEntry.fromJson(dynamic json) {
    _id = json['id'];
    _tokenNumber = json['tokenNumber'];
    _status = json['status'];
    _queueDate = json['queueDate'];
    _appointmentId = json['appointmentId'];
    _appointment = json['appointment'] != null ? Appointment.fromJson(json['appointment']) : null;
  }
  num? _id;
  num? _tokenNumber;
  String? _status;
  String? _queueDate;
  num? _appointmentId;
  Appointment? _appointment;
QueueEntry copyWith({  num? id,
  num? tokenNumber,
  String? status,
  String? queueDate,
  num? appointmentId,
  Appointment? appointment,
}) => QueueEntry(  id: id ?? _id,
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

Appointment appointmentFromJson(String str) => Appointment.fromJson(json.decode(str));
String appointmentToJson(Appointment data) => json.encode(data.toJson());
class Appointment {
  Appointment({
      Patient? patient,}){
    _patient = patient;
}

  Appointment.fromJson(dynamic json) {
    _patient = json['patient'] != null ? Patient.fromJson(json['patient']) : null;
  }
  Patient? _patient;
Appointment copyWith({  Patient? patient,
}) => Appointment(  patient: patient ?? _patient,
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
      String? phone,}){
    _name = name;
    _phone = phone;
}

  Patient.fromJson(dynamic json) {
    _name = json['name'];
    _phone = json['phone'];
  }
  String? _name;
  String? _phone;
Patient copyWith({  String? name,
  String? phone,
}) => Patient(  name: name ?? _name,
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