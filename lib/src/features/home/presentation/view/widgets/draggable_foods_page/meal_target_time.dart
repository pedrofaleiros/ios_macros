import 'package:flutter/cupertino.dart';

class MealTargetTime extends StatelessWidget {
  const MealTargetTime({
    super.key,
    required this.hour,
    required this.minutes,
  });

  final int hour;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            minutes > 9 ? '$hour:$minutes' : '$hour:0$minutes',
            style: const TextStyle(
              color: CupertinoColors.activeBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            CupertinoIcons.clock,
            size: 18,
          ),
        ],
      ),
    );
  }
}