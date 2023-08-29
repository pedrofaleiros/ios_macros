import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

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
          onPressed: () async => await showMealActionSheet(context),
        )
      ],
    );
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Apagar refeição?'),
        content: Text(meal.name),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, false),
            isDestructiveAction: true,
            child: const Text('Cancelar'),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, true),
            isDefaultAction: true,
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Future<void> deleteMeal(BuildContext context) async {
    await _showDialog(context).then((value) async {
      if (value == true) {
        final token = context.read<AuthViewmodel>().sessionUser!.token;
        await context.read<MealViewmodel>().deleteMeal(token, meal.id).then(
              (value) => Navigator.pop(context),
            );
      }
    });
  }

  Future<dynamic> showMealActionSheet(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(meal.name),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Editar'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async => await deleteMeal(context),
            child: const Text('Apagar'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Copiar alimentos'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
      ),
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
