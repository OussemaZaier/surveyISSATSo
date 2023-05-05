import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final secure = FlutterSecureStorage();
  getId() async {
    return await secure.read(key: 'token').then((value) => value);
  }

  getFiliere() async {
    return await secure.read(key: 'filiere').then((value) => value);
  }
}
