import 'package:flutter/material.dart';
import 'package:todaybills/model/data/timeline_step.dart';
import 'package:todaybills/view/detail/timeline_item_view.dart';

final class TimelineView extends StatelessWidget {
  final List<TimelineStep> steps;

  const TimelineView({
    Key? key,
    required this.steps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        return Column(
          children: [
            TimelineItemView(step: step),
            if (index < steps.length - 1)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 1,
                color: Colors.grey.shade300,
              ),
          ],
        );
      }).toList(),
    );
  }
}
