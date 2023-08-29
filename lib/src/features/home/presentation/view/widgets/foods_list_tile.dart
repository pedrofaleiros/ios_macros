import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/macros_row.dart';

class FoodListTile extends StatelessWidget {
  const FoodListTile({
    super.key,
    required this.food,
  });

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(
        food.name,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      subtitle: Text('100 ${food.liquid ? "ml" : "g"}'),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${food.kcal} Kcal',
            style: const TextStyle(
                fontSize: 14,
                color: CupertinoColors.systemMint,
                fontWeight: FontWeight.bold),
          ),
          MacrosRow(amount: 100, food: food),
        ],
      ),
    );
  }
}
