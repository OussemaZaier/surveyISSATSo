class Question {
  String id;
  String question;
  String type;
  List<String> options;
  Question(
      {required this.id,
      required this.question,
      required this.type,
      required this.options});
  factory Question.fromJson(
      String id, Map<String, dynamic> parsedJson, List options) {
    return Question(
      id: id,
      options: (options).map((item) => item as String).toList(),
      type: parsedJson['type'],
      question: parsedJson['question'],
    );
  }
}
