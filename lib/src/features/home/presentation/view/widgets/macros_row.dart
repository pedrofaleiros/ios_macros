import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';

class MacrosRow extends StatelessWidget {
  const MacrosRow({
    super.key,
    required this.food,
    required this.amount,
  });

  final FoodModel food;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MacrosText(
            amount: food.carb / 100 * amount,
            color: CupertinoColors.systemRed,
            name: 'Carboidratos',
            alignment: Alignment.centerLeft,
          ),
          MacrosText(
            amount: food.prot / 100 * amount,
            color: CupertinoColors.systemBlue,
            name: 'Proteínas',
            alignment: Alignment.center,
          ),
          MacrosText(
            amount: food.fat / 100 * amount,
            color: CupertinoColors.systemOrange,
            name: 'Gorduras',
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }
}

class MacrosText extends StatelessWidget {
  const MacrosText({
    super.key,
    required this.amount,
    required this.color,
    required this.name,
    required this.alignment,
  });

  final String name;
  final double amount;
  final Color color;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      alignment: alignment,
      child: Tooltip(
        message: name,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          amount.toStringAsFixed(1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: color,
          ),
        ),
      ),
    );
  }
}
