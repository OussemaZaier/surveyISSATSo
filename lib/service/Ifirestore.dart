import 'package:survey/models/answer.dart';
import 'package:survey/models/problem.dart';
import 'package:survey/models/question.dart';

import '../models/Student.dart';
import '../models/forms.dart';

abstract class IFirestore {
  Future<Student> getStudentByEmail(String collection, {String? id});
  Future<List<Form>> getCustomForms(
    String collectionName,
    String subCollections,
  );
  getQuestions(String id);
  addAnswer(Answer answer);
  report(Problem prob);
}
