import 'dart:convert';

class Law {
  final String ID;
  final String title;
  final String age;

  Law({
    required this.ID,
    required this.title,
    required this.age,
  });

  String toJson() {
    return jsonEncode({
      'ID': ID,
      'title': title,
      'age': age,
    });
  }

  factory Law.fromJson(String jsonString) {
    final decoded = jsonDecode(jsonString);
    if (decoded is Map<String, dynamic>) {
      return Law(
        ID: decoded['ID'],
        title: decoded['title'],
        age: decoded['age'],
      );
    } else {
      throw Exception("Invalid JSON format for Law: $jsonString");
    }
  }
}
