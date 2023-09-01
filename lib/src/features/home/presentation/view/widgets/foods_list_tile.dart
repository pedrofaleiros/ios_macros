import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/macros_row.dart';
import 'package:ios_macros/src/utils/last_amount_food.dart';

class FoodListTile extends StatelessWidget {
  const FoodListTile({
    super.key,
    required this.food,
  });

  final FoodModel food;

  Future<double> getLastAmount(String foodId) async {
    return LastAmoutFood().getLastAmount(foodId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLastAmount(food.id),
      builder: (context, s) {
        return CupertinoListTile(
          title: Text(
            food.name,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          subtitle: s.connectionState == ConnectionState.waiting
              ? const CupertinoActivityIndicator(radius: 5)
              : Text('${s.data} ${food.liquid ? "ml" : "g"}'),
          trailing: s.connectionState == ConnectionState.waiting
              ? const CupertinoActivityIndicator(radius: 5)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${(food.kcal / 100 * s.data!).toStringAsFixed(0)} Kcal',
                      style: const TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemMint,
                          fontWeight: FontWeight.bold),
                    ),
                    MacrosRow(amount: s.data!, food: food),
                  ],
                ),
        );
      },
    );
  }
}
