import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey/models/Student.dart';
import 'package:survey/models/forms.dart';
import 'package:survey/service/Ifirestore.dart';
import 'package:survey/service/Storage.dart';

class FirestoreRepository implements IFirestore {
  final db = FirebaseFirestore.instance;

  @override
  Future<Student> getStudentByEmail(String collection) async {
    String id = await Storage().getId();
    final ref = db.collection(collection).doc(id).get();
    Student student = await ref.then((value) async {
      Student student = Student.fromJson(value.data() as Map<String, dynamic>);
      await FlutterSecureStorage()
          .write(key: 'filiere', value: student.filiere);
      return student;
    });

    return student;
  }

  @override
  Future<List<Form>> getCustomForms(
    String collectionName,
    String subCollection,
  ) async {
    List<Form> form = [];
    String fl = await Storage().getFiliere();

    form = await db
        .collection('forms')
        .where('filiere', whereIn: [fl.toLowerCase(), 'all'.toLowerCase()])
        .get()
        .then((value) async {
          for (var doc in value.docs) {
            Form forme = Form.fromJson(doc.id, doc.data());
            final len = await db
                .collection(collectionName)
                .doc(doc.id)
                .collection(subCollection)
                .get();
            forme.numQuestion = len.size;
            form.add(forme);
          }
          return form;
        });
    return form;
  }
}
