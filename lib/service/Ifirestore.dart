import '../models/Student.dart';
import '../models/forms.dart';

abstract class IFirestore {
  Future<Student> getStudentByEmail(String collection);
  Future<List<Form>> getCustomForms(
    String collectionName,
    String subCollections,
  );
}
