import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/macros_row.dart';
import 'package:ios_macros/src/utils/last_amount_food.dart';

class FoodListTile extends StatelessWidget {
  const FoodListTile({
    super.key,
    required this.food,
    required this.selected,
    required this.amount,
  });

  final FoodModel food;
  final bool selected;
  final double amount;

  Future<double> getLastAmount(String foodId) async {
    return LastAmoutFood().getLastAmount(foodId);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      leading: selected
          ? const Icon(
              CupertinoIcons.add_circled,
              color: CupertinoColors.systemGreen,
            )
          : null,
      title: Text(
        food.name,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        '${amount.toStringAsFixed(0)} ${food.liquid ? "ml" : "g"}',
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${(food.kcal / 100 * amount).toStringAsFixed(0)} Kcal',
            style: const TextStyle(
                fontSize: 14,
                color: CupertinoColors.systemMint,
                fontWeight: FontWeight.bold),
          ),
          MacrosRow(amount: amount, food: food),
        ],
      ),
    );
  }
}
