import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey/models/Student.dart';
import 'package:survey/models/answer.dart';
import 'package:survey/models/forms.dart';
import 'package:survey/models/question.dart';
import 'package:survey/service/Ifirestore.dart';
import 'package:survey/service/Storage.dart';

import '../models/problem.dart';

class FirestoreRepository implements IFirestore {
  final db = FirebaseFirestore.instance;

  @override
  Future<Student> getStudentByEmail(String collection, {String? id}) async {
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
        questions.add(
            Question.fromJson(doc.id, doc.data(), doc.data()['options'] ?? []));
      }
      return questions;
    });
    return questions;
  }

  @override
  Future<String> addAnswer(Answer answer) async {
    // TODO: implement addAnswer
    String respond;
    try {
      await db
          .collection("forms")
          .doc(answer.formId)
          .collection('questions')
          .doc(answer.questionId)
          .collection('answers')
          .add({'answer': answer.answer, 'filiere': answer.filiere});
      return 'form added successfully';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future report(Problem problem) async {
    try {
      String id = await Storage().getId();
      await db.collection('students').doc(id).collection('reports').add({
        'topic': problem.topic,
        'description': problem.description,
        'date': DateTime.now()
      });
      return 'repoert added successfully';
    } catch (e) {
      return e.toString();
    }
  }
}
