class Question {
  String id;
  String question;
  // List<String> options;
  Question({required this.id, required this.question});
  factory Question.fromJson(String id, Map<String, dynamic> parsedJson) {
    return Question(
      id: id,
      question: parsedJson['question'],
    );
  }
}
