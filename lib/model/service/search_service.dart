import 'package:todaybills/model/data/bill.dart';
import 'package:todaybills/model/service/bills_service.dart';

final class SearchService {
  final BillService billService = BillService();

  Future<List<Bill>> searchBillsByKeywords(String keyword) async {
    return await billService.fetchBillsByKeyword(
      keyword: keyword,
      pIndex: 1,
      age: 22,
    );
  }
}
