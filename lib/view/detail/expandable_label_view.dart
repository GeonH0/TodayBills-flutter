import 'package:flutter/material.dart';

final class ExpandableLabelView extends StatefulWidget {
  final String text;

  const ExpandableLabelView({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpandableLabelView> createState() => _ExpandableLabelViewState();
}

final class _ExpandableLabelViewState extends State<ExpandableLabelView>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool shouldShowToggle = widget.text.trim() != '내용 없음';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Text(
            widget.text,
            maxLines: isExpanded ? null : 3,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        if (shouldShowToggle) ...[
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? '접기' : '더 보기',
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ],
    );
  }
}
