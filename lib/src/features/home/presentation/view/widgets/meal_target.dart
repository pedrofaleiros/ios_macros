import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/data/dto/item_dto.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
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
    final token = context.read<AuthViewmodel>().sessionUser!.token;

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

  Future<dynamic> showPopup(BuildContext context) {
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
        final token = context.read<AuthViewmodel>().sessionUser!.token;
        final mealController = context.read<MealViewmodel>();

        final response = await showPopup(context);

        final amount = validAmount(response);

        if (amount == null) return;

        await createItem(
          mealController: mealController,
          token: token,
          foodId: food.id,
          amount: amount,
        );
        await showAdded();
      },
      builder: (context, foods, list) {
        return Container(
          width: 125.0,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [
          //       CupertinoColors.black.withOpacity(0.2),
          //       CupertinoColors.black.withOpacity(0.4),
          //       CupertinoColors.black.withOpacity(0.6),
          //       CupertinoColors.black.withOpacity(0.8),
          //       CupertinoColors.black.withOpacity(1),
          //     ],
          //   ),
          // ),
          color: CupertinoColors.black.withOpacity(0),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: foods.isNotEmpty
                  ? CupertinoTheme.brightnessOf(context) == Brightness.dark
                      ? Color(0xff2c2c2c)
                      : CupertinoColors.white
                  : CupertinoTheme.brightnessOf(context) == Brightness.dark
                      ? CupertinoColors.label
                      : CupertinoColors.systemGroupedBackground,
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
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.meal.minutes > 9
                    ? '${widget.meal.hour}:${widget.meal.minutes}'
                    : '${widget.meal.hour}:0${widget.meal.minutes}',
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
        ),
        Expanded(
          child: Text(
            widget.meal.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: CupertinoTheme.brightnessOf(context) == Brightness.dark
                  ? CupertinoColors.systemGrey2
                  : CupertinoColors.systemGrey,
            ),
          ),
        ),
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
}

class AmountAlertDialog extends StatelessWidget {
  const AmountAlertDialog({
    super.key,
    required this.focus,
    required this.textController,
  });

  final FocusNode focus;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(focus);
    });

    return CupertinoAlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Selecione a quantidade'),
      ),
      content: CupertinoTextField(
        focusNode: focus,
        controller: textController,
        keyboardType: TextInputType.number,
        onEditingComplete: () => Navigator.pop(context, textController.text),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context, null),
          isDestructiveAction: true,
          child: const Text('Cancelar'),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context, textController.text),
          isDefaultAction: true,
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}

class AddedText extends StatelessWidget {
  const AddedText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Adicionado',
            style: TextStyle(
              fontSize: 14,
              color: CupertinoColors.systemCyan,
            ),
          ),
          Icon(
            CupertinoIcons.check_mark_circled_solid,
            size: 14,
            color: CupertinoColors.systemCyan,
          )
        ],
      ),
    );
  }
}
