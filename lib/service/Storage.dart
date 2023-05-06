import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey/models/Student.dart';

class Storage {
  final secure = FlutterSecureStorage();
  // final StreamController<String> _myStreamController =
  //     StreamController<String>();

  // Stream<String> get myStream => _myStreamController.stream;
  getId() async {
    var id = await secure.read(key: 'token').then((value) => value);
    return id;
  }

  setId(String? value) async {
    await secure.write(key: 'token', value: value!);
  }

  Future<String> getFiliere() async {
    String filiere = await secure.read(key: 'filiere').then((value) {
          return value;
        }) ??
        "";
    return filiere;
  }

  saveFiliere(String? filiere) async {
    if (filiere != null) {
      await FlutterSecureStorage().write(key: 'filiere', value: filiere);
      // _myStreamController.add(filiere);
    }
  }
}
