import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/data/dto/item_dto.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/added_text.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/amount_alert_dialog.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/meal_target_name.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/meal_target_time.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
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
  bool added = false;
  bool isLoading = false;

  Future<void> showAdded() async {
    if (mounted) {
      setState(() {
        added = true;
      });
    }

    if (mounted) {
      await Future.delayed(const Duration(seconds: 3));
    }

    if (mounted) {
      setState(() {
        added = false;
      });
    }
  }

  double? validAmount(dynamic response) {
    try {
      if (response == null) return null;

      if (double.tryParse(response) == null) return null;

      return double.parse(response);
    } catch (e) {
      return null;
    }
  }

  Future<void> createItem({
    required String foodId,
    required double amount,
    required String token,
    required MealViewmodel mealController,
  }) async {
    setState(() => isLoading = true);
    await mealController.createItem(
      token,
      ItemDTO(
        mealId: widget.meal.id,
        foodId: foodId,
        amount: amount,
      ),
    );
    setState(() => isLoading = false);
  }

  Future<dynamic> showAmountPopup(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) {
        TextEditingController textController = TextEditingController();
        FocusNode focus = FocusNode();

        return AmountAlertDialog(
          focus: focus,
          textController: textController,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<FoodModel>(
      onAccept: (food) async {
        final auth = context.read<AuthViewmodel>();
        if (!auth.isAuth) return;
        final token = auth.sessionUser!.token;
        final mealController = context.read<MealViewmodel>();

        final response = await showAmountPopup(context);

        final amount = validAmount(response);

        if (amount != null) {
          await createItem(
            mealController: mealController,
            token: token,
            foodId: food.id,
            amount: amount,
          );
          await showAdded();
        }
      },
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
              borderRadius: BorderRadius.circular(16),
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
        if (isLoading)
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: CupertinoActivityIndicator(),
          )
        else if (added)
          const AddedText(),
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
            : CupertinoColors.systemGrey5;
  }
}
