import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todaybills/controller/detail_viewController.dart';
import 'package:todaybills/view/detail/expandable_label_view.dart';
import 'package:todaybills/view/detail/timeline_view.dart';

final class DetailView extends StatefulWidget {
  final String lawId;
  final String age;
  const DetailView({super.key, required this.lawId, required this.age});

  @override
  State<StatefulWidget> createState() => _DeatilViewState();
}

final class _DeatilViewState extends StateMVC<DetailView> {
  late DetailViewcontroller _controller;
  _DeatilViewState() : super(DetailViewcontroller()) {
    _controller = controller as DetailViewcontroller;
  }
  @override
  void initState() {
    super.initState();
    _controller.fetchBillDetail(widget.lawId, widget.age);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_controller.bill?.billName ?? ''),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _controller.onBackPressed(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BasicInfoSection(
              proposeDt: _controller.bill?.proposeDt ?? '',
              age: '22',
            ),
            const SizedBox(height: 24),
            const Text(
              '제안 이유',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ExpandableLabelView(
              text: _controller.bill?.proposalReason.isEmpty ?? true
                  ? '내용없음'
                  : _controller.bill!.proposalReason,
            ),
            const SizedBox(height: 24),
            const Text(
              '주요 내용',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ExpandableLabelView(
              text: _controller.bill?.keyContent.isEmpty ?? true
                  ? '내용없음'
                  : _controller.bill!.keyContent,
            ),
            const SizedBox(height: 24),
            const Text(
              '진행 단계',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TimelineView(steps: _controller.timelineSteps),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _controller.onDetailLinkPressed(context),
              child: const Text('상세페이지 보기'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BasicInfoSection extends StatelessWidget {
  final String proposeDt;
  final String age;

  const _BasicInfoSection({
    Key? key,
    required this.proposeDt,
    required this.age,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('제안일: $proposeDt'),
        Text('대수: $age'),
      ],
    );
  }
}
