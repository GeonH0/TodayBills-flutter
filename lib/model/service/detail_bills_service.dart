import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todaybills/model/data/bill_row.dart';
import 'package:http/http.dart' as http;

final class DetailBillsService {
  final String baseurl =
      "https://open.assembly.go.kr/portal/openapi/nzmimeepazxkubdpn";
  final apiKey = dotenv.env['API_KEY'];

  Future<BillRow> fetchdetailBill(
      {required String id, required String age}) async {
    final url = Uri.parse(baseurl).replace(queryParameters: {
      'key': apiKey,
      'type': 'json',
      'pIndex': "1",
      'pSize': "1",
      'AGE': age.toString(),
      'BILL_ID': id.toString(),
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final dynamic rootKey = data.keys.first;
      final List<dynamic> mainList = data[rootKey];
      final rowPart = mainList[1] as Map<String, dynamic>;
      final List<dynamic> rowData = rowPart['row'] as List<dynamic>;
      if (rowData.isNotEmpty) {
        final map = rowData.first as Map<String, dynamic>;
        return BillRow.fromJson(map);
      } else {
        throw Exception("No bill data found");
      }
    } else {
      throw Exception(
          'Failed to load bills. Status code: ${response.statusCode}');
    }
  }
}
