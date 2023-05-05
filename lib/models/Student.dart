class Student {
  String name;
  String lastName;
  String? filiere;
  Student(this.name, this.lastName, {this.filiere});
  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(parsedJson['prenom'], parsedJson['nom'],
        filiere: parsedJson['filiere']);
  }
}
