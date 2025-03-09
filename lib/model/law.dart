import 'dart:convert';

class Law {
  final String ID;
  final String title;

  Law({
    required this.ID,
    required this.title,
  });

  String toJson() {
    return jsonEncode({
      'ID': ID,
      'title': title,
    });
  }

  factory Law.fromJson(String jsonString) {
    final decoded = jsonDecode(jsonString);
    if (decoded is Map<String, dynamic>) {
      return Law(
        ID: decoded['ID'],
        title: decoded['title'],
      );
    } else {
      throw Exception("Invalid JSON format for Law: $jsonString");
    }
  }
}
