import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';

class MealTitle extends StatelessWidget {
  const MealTitle({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NameAndHour(meal: meal),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          alignment: Alignment.centerRight,
          child: const Icon(CupertinoIcons.ellipsis_vertical),
          onPressed: () {},
        )
      ],
    );
  }
}

class NameAndHour extends StatelessWidget {
  const NameAndHour({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              meal.minutes > 9
                  ? '${meal.hour}:${meal.minutes}'
                  : '${meal.hour}:0${meal.minutes}',
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
        Text(meal.name),
      ],
    );
  }
}
