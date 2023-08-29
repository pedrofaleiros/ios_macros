import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/draggable_foods_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/item_list_tile.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/meal_title.dart';

class MealWidget extends StatelessWidget {
  const MealWidget({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => CupertinoListSection(
        header: MealTitle(meal: meal),
        // additionalDividerMargin: 0,
        dividerMargin: 0,
        hasLeading: false,
        topMargin: 0,
        children: [
          for (var item in meal.items) ItemListTile(item: item),
          // AddItemButton(),
          MacrosCount(meal: meal),
        ],
      ),
    );
  }
}

class MacrosCount extends StatelessWidget {
  const MacrosCount({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  Map<String, String> calculateMacros() {
    double kcal = 0;
    double carb = 0;
    double prot = 0;
    double fat = 0;

    for (var item in meal.items) {
      kcal += item.food.kcal / 100 * item.amount;
      carb += item.food.carb / 100 * item.amount;
      prot += item.food.prot / 100 * item.amount;
      fat += item.food.fat / 100 * item.amount;
    }

    return {
      "kcal": kcal.toStringAsFixed(0),
      "carb": carb.toStringAsFixed(1),
      "prot": prot.toStringAsFixed(1),
      "fat": fat.toStringAsFixed(1),
    };
  }

  @override
  Widget build(BuildContext context) {
    var map = calculateMacros();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'C: ${map['carb']}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.systemRed,
            ),
          ),
          Text(
            'P: ${map['prot']}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.activeBlue,
            ),
          ),
          Text(
            'G: ${map['fat']}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.activeOrange,
            ),
          ),
          Text(
            '${map['kcal']} Kcal',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.systemMint,
            ),
          ),
        ],
      ),
    );
  }
}

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        Navigator.pushNamed(context, DraggableFoodsPage.routeName);
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Adicionar',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(width: 4),
          Icon(
            CupertinoIcons.add_circled_solid,
            size: 14,
          ),
        ],
      ),
    );
  }
}
