import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

final class HtmlScrapper {
  Future<String?> fetchPageContent(String urlString) async {
    try {
      final response = await http.get(Uri.parse(urlString));
      if (response.statusCode == 200) {
        final document = parser.parse(response.body);
        final contentDiv = document.querySelector('div#summaryContentDiv');
        if (contentDiv != null) {
          var contentText = contentDiv.text.trim();
          const marker = "제안이유 및 주요내용";
          if (contentText.startsWith(marker)) {
            contentText = contentText.replaceFirst(marker, "").trim();
          }
          return contentText;
        } else {
          print("summaryContentDiv not found");
          return null;
        }
      } else {
        print("HTTP error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching summary content: $e");
      return null;
    }
  }
}
