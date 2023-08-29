import 'package:flutter/cupertino.dart';

class LetterLabel extends StatelessWidget {
  const LetterLabel({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: CupertinoTheme.brightnessOf(context) == Brightness.dark
          ? CupertinoColors.systemFill
          : CupertinoColors.systemGroupedBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
              fontSize: 14, color: CupertinoColors.inactiveGray),
        ),
      ),
    );
  }
}