import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todaybills/model/data/bill_row.dart';
import 'package:todaybills/model/data/timeline_step.dart';
import 'package:todaybills/model/service/detail_bills_service.dart';
import 'package:todaybills/model/service/html_scrapper.dart';
import 'package:url_launcher/url_launcher.dart';

final class DetailViewcontroller extends ControllerMVC {
  final DetailBillsService billService = DetailBillsService();
  final HtmlScrapper htmlScrapper = HtmlScrapper();
  BillRow? bill;
  List<TimelineStep> timelineSteps = [];

  Future<void> fetchBillDetail(String lawId, String age) async {
    try {
      final fetchedDetail =
          await billService.fetchdetailBill(age: age, id: lawId);
      setState(() {
        bill = fetchedDetail;
        _generateTimelineSteps();
      });
      await fetchAndDisplaySummaryContent(bill!.detailLink);
    } catch (e) {
      debugPrint("Error fetching detail: $e");
    }
  }

  void _generateTimelineSteps() {
    if (bill == null) return;

    timelineSteps = [
      TimelineStep(
        title: '제안',
        date: bill!.proposeDt,
        isCompleted: true,
      ),
      TimelineStep(
        title: '위원회 처리',
        date: bill!.committeeDt.isEmpty ? '미처리' : bill!.committeeDt,
        isCompleted: bill!.committeeDt.isNotEmpty,
      ),
      TimelineStep(
        title: '법사위 처리',
        date: bill!.lawProcDt.isEmpty ? '미처리' : bill!.lawProcDt,
        isCompleted: bill!.lawProcDt.isNotEmpty,
      ),
      TimelineStep(
        title: '본회의 심의',
        date: bill!.procDt.isEmpty ? '미처리' : bill!.procDt,
        isCompleted: bill!.procDt.isNotEmpty,
      ),
    ];
  }

  Future<void> fetchAndDisplaySummaryContent(String url) async {
    final summaryText = await htmlScrapper.fetchPageContent(url);
    if (summaryText != null) {
      // 예: 문장 끝 뒤의 공백을 줄바꿈으로 치환 (필요 시)
      final processedText = summaryText.replaceAll(RegExp(r"(?<=\.)\s+"), "\n");
      String proposalReason = '';
      String keyContent = '';

      if (processedText.contains("제안이유 및 주요내용")) {
        proposalReason = processedText.replaceFirst("제안이유 및 주요내용", "").trim();
        keyContent = "내용 없음";
      } else if (processedText.contains("제안이유") &&
          processedText.contains("주요내용")) {
        final proposalIndex = processedText.indexOf("제안이유");
        final keyIndex = processedText.indexOf("주요내용");
        if (proposalIndex != -1 && keyIndex != -1) {
          proposalReason = processedText
              .substring(proposalIndex + "제안이유".length, keyIndex)
              .trim();
          keyContent = processedText.substring(keyIndex + "주요내용".length).trim();
        }
      } else {
        proposalReason = processedText.trim();
        keyContent = "내용 없음";
      }

      setState(() {
        bill = BillRow(
          billName: bill!.billName,
          proposeDt: bill!.proposeDt,
          detailLink: bill!.detailLink,
          committeeDt: bill!.committeeDt,
          lawProcDt: bill!.lawProcDt,
          procDt: bill!.procDt,
          proposalReason: proposalReason,
          keyContent: keyContent,
        );
        _generateTimelineSteps();
      });
    } else {
      debugPrint("Summary content not available");
    }
  }

  Future<void> onDetailLinkPressed(BuildContext context) async {
    if (bill != null) {
      final uri = Uri.tryParse(bill!.detailLink);
      if (uri != null) {
        // url_launcher를 사용해 외부 브라우저를 엽니다.
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('상세 페이지를 열 수 없습니다: $uri')),
          );
        }
      }
    }
  }

  void onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }
}
