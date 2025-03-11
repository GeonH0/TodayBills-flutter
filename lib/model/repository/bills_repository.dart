import 'dart:async';
import 'dart:convert';
import 'package:todaybills/model/law.dart';
import 'package:todaybills/model/service/bills_service.dart';
import 'package:todaybills/model/bill.dart';

final class BillsRepositoryError implements Exception {
  final String message;
  BillsRepositoryError(this.message);

  @override
  String toString() => message;
}

class BillsRepository {
  final BillService billsService = BillService();
  // 날짜별 법안들을 저장하는 Map (키: "yyyy-MM-dd", 값: List<Law>)
  final Map<String, List<Law>> billsByDate = {};

  final Map<int, int> pageIndexByAge = {22: 1, 21: 1};
  int age = 22;
  String? selectedDate;

  /// 지정한 날짜에 해당하는 법안들을 fetch합니다.
  /// 캐시된 데이터가 있으면 바로 반환하고, 없으면 API 호출 후 처리합니다.
  Future<List<Law>> fetchBills({
    required DateTime date,
    required bool isUserSelectingDate,
  }) async {
    final formattedDate = formatDate(date);
    if (formattedDate == null) {
      throw BillsRepositoryError("Date conversion failed");
    }

    selectedDate = formattedDate;

    // 캐시(billsByDate)에 데이터가 있으면 바로 반환
    if (billsByDate.containsKey(formattedDate) &&
        billsByDate[formattedDate]!.isNotEmpty) {
      return billsByDate[formattedDate]!;
    }

    try {
      // BillService가 반환한 Bill 리스트를 받아옴
      final fetchedBills = await loadBills();
      processBills(fetchedBills);
      await handlePagination(fetchedBills, date);

      final bills = getBills(formattedDate);
      // 사용자가 날짜를 선택하지 않은 상태라면 최신 날짜로 업데이트
      if (!isUserSelectingDate && bills.isEmpty) {
        final latest = getLatestAvailableDate();
        if (latest != null) {
          selectedDate = latest;
        }
      }

      return billsByDate[selectedDate ?? ""] ?? [];
    } catch (e) {
      final cachedBills = billsByDate[formattedDate];
      if (cachedBills != null && cachedBills.isNotEmpty) {
        return cachedBills;
      } else {
        rethrow;
      }
    }
  }

  /// API 호출: BillService를 사용하여 데이터(법안 목록)를 받아옴.
  Future<List<Bill>> loadBills() async {
    final currentPIndex = pageIndexByAge[age] ?? 1;
    return await billsService.fetchBills(pIndex: currentPIndex, age: age);
  }

  /// 받아온 Bill 데이터를 날짜별로 분류하여 billsByDate에 저장 (중복 없이)
  void processBills(List<Bill> bills) {
    for (final bill in bills) {
      // 가정: Bill 모델에 proposeDt 필드가 "yyyy-MM-dd" 형식의 문자열로 존재
      final dateKey = bill.proposeDt;
      // Law 객체로 변환 (StarredBill과 유사하게 사용)
      final law = Law(
        ID: bill.billId,
        title: bill.billName,
      );
      billsByDate.putIfAbsent(dateKey, () => []);
      // 중복 저장 방지
      if (!billsByDate[dateKey]!.any((l) => l.ID == law.ID)) {
        billsByDate[dateKey]!.add(law);
      }
    }
  }

  /// 페이징 처리: 받아온 Bill 데이터의 가장 오래된 날짜를 기준으로 연령대 또는 페이지 인덱스를 조정
  Future<void> handlePagination(List<Bill> bills, DateTime date) async {
    if (bills.isEmpty) return;

    // Bill의 proposeDt 값을 기준으로 가장 오래된 날짜를 찾음
    final oldestDate = bills.map((bill) => bill.proposeDt).reduce(
          (a, b) => a.compareTo(b) < 0 ? a : b,
        );

    // 2020-05-30 이전 법안은 더 이상 요청하지 않음
    if (oldestDate.compareTo("2020-05-30") <= 0) {
      return;
    }

    // 2024-05-30 이전이면 연령대 전환
    if (oldestDate.compareTo("2024-05-30") <= 0) {
      if (age == 22) {
        age = 21;
        pageIndexByAge[age] = pageIndexByAge[age] ?? 1;
        await fetchBills(date: date, isUserSelectingDate: true);
        return;
      } else if (age == 21) {
        age = 22;
        pageIndexByAge[age] = pageIndexByAge[age] ?? 1;
        await fetchBills(date: date, isUserSelectingDate: true);
        return;
      }
    } else {
      pageIndexByAge[age] = (pageIndexByAge[age] ?? 1) + 1;
    }
  }

  /// 날짜를 "yyyy-MM-dd" 형식의 문자열로 변환
  String? formatDate(DateTime date) {
    try {
      final year = date.year;
      final month = date.month;
      final day = date.day;
      return '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    } catch (e) {
      return null;
    }
  }

  /// 지정한 날짜 키에 해당하는 법안 목록을 반환
  List<Law> getBills(String dateKey) {
    return billsByDate[dateKey] ?? [];
  }

  /// 저장된 법안 중 최신 날짜 키를 반환 (내림차순 정렬)
  String? getLatestAvailableDate() {
    if (billsByDate.isEmpty) return null;
    final dates = billsByDate.keys.toList();
    dates.sort((a, b) => b.compareTo(a));
    return dates.first;
  }
}
