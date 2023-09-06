import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/data/dto/item_dto.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/create_item_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/added_text.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/amount_alert_dialog.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/meal_target_name.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/meal_target_time.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:ios_macros/src/utils/last_amount_food.dart';
import 'package:provider/provider.dart';

class MealTarget extends StatefulWidget {
  const MealTarget({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  State<MealTarget> createState() => _MealTargetState();
}

class _MealTargetState extends State<MealTarget> {
  bool isLoading = false;

  Future<void> handleAccept(BuildContext context, FoodModel food) async {
    await Navigator.pushNamed(
      context,
      CreateItemPage.routeName,
      arguments: {
        'food': food,
        'mealId': widget.meal.id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<FoodModel>(
      onAccept: (food) => handleAccept(context, food),
      builder: (context, foods, list) {
        return Container(
          width: 125.0,
          color: CupertinoColors.black.withOpacity(0),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: _chooseColor(foods, context),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: CupertinoColors.opaqueSeparator,
                width: 0,
              ),
            ),
            child: _content,
          ),
        );
      },
    );
  }

  Widget get _content {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MealTargetTime(hour: widget.meal.hour, minutes: widget.meal.minutes),
        MealTargetName(name: widget.meal.name),
      ],
    );
  }

  Color _chooseColor(List<FoodModel?> foods, BuildContext context) {
    return foods.isNotEmpty
        ? CupertinoTheme.brightnessOf(context) == Brightness.dark
            ? const Color(0xff2c2c2c)
            : CupertinoColors.white
        : CupertinoTheme.brightnessOf(context) == Brightness.dark
            ? CupertinoColors.label
            : CupertinoColors.systemGrey6;
  }
}
