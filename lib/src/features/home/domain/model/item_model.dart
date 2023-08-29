import 'dart:convert';

import 'package:ios_macros/src/features/home/domain/model/food_model.dart';

class ItemModel {
  final String id;
  final double amount;
  final FoodModel food;

  ItemModel({
    required this.id,
    required this.amount,
    required this.food,
  });

  ItemModel copyWith({
    String? id,
    double? amount,
    FoodModel? food,
  }) {
    return ItemModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      food: food ?? this.food,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'food': food.toMap(),
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      amount: double.tryParse(map['amount'].toString()) ?? 0.0,
      food: FoodModel.fromMap(map['food']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String jsonData) {
    return ItemModel.fromMap(
      json.decode(jsonData),
    );
  }
}
