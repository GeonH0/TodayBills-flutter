import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:todaybills/model/data/bill.dart';

final class BillService {
  final String baseUrl =
      "https://open.assembly.go.kr/portal/openapi/nzmimeepazxkubdpn";

  final apiKey = dotenv.env['API_KEY'];

  Future<List<Bill>> fetchBills({
    required int pIndex,
    required int age,
  }) async {
    final url = Uri.parse(baseUrl).replace(queryParameters: {
      'key': apiKey,
      'type': 'json',
      'pIndex': pIndex.toString(),
      'pSize': "1000",
      'AGE': age.toString(),
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final dynamic rootKey = data.keys.first;

      final List<dynamic> mainList = data[rootKey];
      final rowPart = mainList[1] as Map<String, dynamic>;
      final List<dynamic> rowData = rowPart['row'] as List<dynamic>;
      final bills = rowData.map((item) {
        final map = item as Map<String, dynamic>;
        return Bill.fromJson(map);
      }).toList();

      return bills;
    } else {
      throw Exception(
          'Failed to load bills. Status code: ${response.statusCode}');
    }
  }
}
