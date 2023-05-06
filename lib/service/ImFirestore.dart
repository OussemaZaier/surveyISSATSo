import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey/models/Student.dart';
import 'package:survey/models/forms.dart';
import 'package:survey/models/question.dart';
import 'package:survey/service/Ifirestore.dart';
import 'package:survey/service/Storage.dart';

class FirestoreRepository implements IFirestore {
  final db = FirebaseFirestore.instance;

  @override
  Future<Student> getStudentByEmail(String collection, {String? id}) async {
    print("1");

    id = await Storage().getId();
    final ref = db.collection(collection).doc(id).get();
    Student student = await ref.then((value) {
      Student student = Student.fromJson(value.data() as Map<String, dynamic>);

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
    print("2");
    String fl = await Storage().getFiliere();
    form = await db
        .collection('forms')
        .where('filiere', whereIn: [fl.toLowerCase(), 'all'])
        .where("deadline", isGreaterThan: Timestamp.now().toDate())
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

            // print(forme);
          }
          return form;
        });
    return form;
  }

  @override
  Future<List<Question>> getQuestions(String id) async {
    var doc;
    List<Question> questions = [];
    questions = await db
        .collection('forms')
        .doc(id)
        .collection('questions')
        .get()
        .then((value) {
      for (doc in value.docs) {
        questions.add(doc);
      }
      return questions;
    });
    return questions;
  }
}
