import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/data/dto/item_dto.dart';
import 'package:ios_macros/src/features/home/domain/model/item_model.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/draggable_foods_page.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/copy_cut_viewmodel.dart';
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
        final auth = context.read<AuthViewmodel>();
        if (auth.isAuth) {
          final token = auth.sessionUser!.token;
          await context
              .read<MealViewmodel>()
              .deleteMeal(token, meal.id)
              .then((value) => Navigator.pop(context));
        }
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
            onPressed: () async => await deleteMeal(context),
            isDestructiveAction: true,
            child: const Text('Apagar'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final list = context.read<CopyPasteViewmodel>().paste();
              final mealsController = context.read<MealViewmodel>();
              final auth = context.read<AuthViewmodel>();

              if (auth.isAuth == false) return;

              await addItems(list, mealsController, auth.sessionUser!.token)
                  .then(
                (value) => Navigator.pop(context),
              );
            },
            child: const Text('Colar alimentos'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              context.read<CopyPasteViewmodel>().copy(meal);
              Navigator.pop(context);
            },
            child: const Text('Copiar alimentos'),
          ),
          
          CupertinoActionSheetAction(
            onPressed: () async {
              await Navigator.pushNamed(context, DraggableFoodsPage.routeName)
                  .then(
                (value) => Navigator.pop(context),
              );
            },
            child: const Text('Adicionar alimentos'),
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

  Future<void> addItems(
    List<ItemModel> list,
    MealViewmodel mealsController,
    String token,
  ) async {
    for (var item in list) {
      await mealsController.createItem(
        token,
        ItemDTO(
          mealId: meal.id,
          foodId: item.food.id,
          amount: item.amount,
        ),
      );
    }
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
