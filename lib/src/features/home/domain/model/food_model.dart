import 'dart:convert';

class FoodModel {
  final String id;
  final double kcal;
  final double carb;
  final double prot;
  final double fat;
  final double fiber;
  final String name;
  final bool liquid;

  FoodModel({
    required this.id,
    required this.kcal,
    required this.carb,
    required this.prot,
    required this.fat,
    required this.fiber,
    required this.name,
    required this.liquid,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kcal': kcal,
      'carb': carb,
      'prot': prot,
      'fat': fat,
      'fiber': fiber,
      'name': name,
      'liquid': liquid,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'],
      name: map['name'],
      kcal: double.tryParse(map['kcal'].toString()) ?? 0.0,
      carb: double.tryParse(map['carb'].toString()) ?? 0.0,
      prot: double.tryParse(map['prot'].toString()) ?? 0.0,
      fat: double.tryParse(map['fat'].toString()) ?? 0.0,
      fiber: double.tryParse(map['fiber'].toString()) ?? 0.0,
      liquid: map['liquid'],
    );
  }

  factory FoodModel.fromJson(String jsonData) {
    return FoodModel.fromMap(
      json.decode(jsonData),
    );
  }

  factory FoodModel.empty() {
    return FoodModel(
      id: '',
      name: '',
      kcal: 0.0,
      carb: 0.0,
      prot: 0.0,
      fat: 0.0,
      fiber: 0.0,
      liquid: false,
    );
  }

  String toJson() => json.encode(toMap());
}
