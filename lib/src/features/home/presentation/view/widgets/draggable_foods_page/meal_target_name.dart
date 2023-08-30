import 'package:flutter/cupertino.dart';

class MealTargetName extends StatelessWidget {
  const MealTargetName({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: CupertinoTheme.brightnessOf(context) == Brightness.dark
              ? CupertinoColors.systemGrey2
              : CupertinoColors.darkBackgroundGray,
        ),
      ),
    );
  }
}
