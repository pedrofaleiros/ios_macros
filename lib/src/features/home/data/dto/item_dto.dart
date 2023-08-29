import 'dart:convert';

class ItemDTO {
  final String mealId;
  final String foodId;
  final double amount;

  ItemDTO({
    required this.mealId,
    required this.foodId,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'meal_id': mealId,
      'food_id': foodId,
      'amount': amount,
    };
  }

  factory ItemDTO.fromMap(Map<String, dynamic> map) {
    return ItemDTO(
      mealId: map['meal_id'],
      foodId: map['food_id'],
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemDTO.fromJson(String jsonData) {
    return ItemDTO.fromMap(
      json.decode(jsonData),
    );
  }
}
