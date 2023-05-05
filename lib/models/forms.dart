import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Form {
  final String id;
  final String filiere;
  final Timestamp deadline;
  final String type;
  int? numQuestion;
  Form(
      {required this.id,
      required this.filiere,
      required this.deadline,
      required this.type,
      this.numQuestion});
  factory Form.fromJson(String id, Map<String, dynamic> parsedJson) {
    return Form(
        id: id,
        type: parsedJson['type'],
        filiere: parsedJson['filiere'],
        deadline: parsedJson['deadline']);
  }
}
