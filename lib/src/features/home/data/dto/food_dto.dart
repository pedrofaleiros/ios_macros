import 'dart:convert';

class FoodDTO {
  final double kcal;
  final double carb;
  final double prot;
  final double fat;
  final double fiber;
  final String name;
  final bool liquid;

  FoodDTO({
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
      'name': name,
      'kcal': kcal,
      'carb': carb,
      'prot': prot,
      'fat': fat,
      'fiber': fiber,
      'liquid': liquid,
    };
  }

  factory FoodDTO.fromMap(Map<String, dynamic> map) {
    return FoodDTO(
      name: map['name'],
      kcal: double.tryParse(map['kcal'].toString()) ?? 0.0,
      carb: double.tryParse(map['carb'].toString()) ?? 0.0,
      prot: double.tryParse(map['prot'].toString()) ?? 0.0,
      fat: double.tryParse(map['fat'].toString()) ?? 0.0,
      fiber: double.tryParse(map['fiber'].toString()) ?? 0.0,
      liquid: map['liquid'],
    );
  }

  factory FoodDTO.fromJson(String jsonData) {
    return FoodDTO.fromMap(
      json.decode(jsonData),
    );
  }

  String toJson() => json.encode(toMap());
}
