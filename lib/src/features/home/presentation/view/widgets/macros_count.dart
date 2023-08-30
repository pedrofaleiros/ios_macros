import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';

class MacrosCount extends StatelessWidget {
  const MacrosCount({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    var map = calculateMacros();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MacrosCountText(
            text: 'C: ${map['carb']}',
            color: CupertinoColors.systemRed,
          ),
          MacrosCountText(
            text: 'P: ${map['prot']}',
            color: CupertinoColors.systemBlue,
          ),
          MacrosCountText(
            text: 'G: ${map['fat']}',
            color: CupertinoColors.systemOrange,
          ),
          MacrosCountText(
            text: '${map['kcal']} Kcal',
            color: CupertinoColors.systemMint,
          ),
        ],
      ),
    );
  }

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
}

class MacrosCountText extends StatelessWidget {
  const MacrosCountText({
    super.key,
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
