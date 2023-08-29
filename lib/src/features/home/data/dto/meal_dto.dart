import 'dart:convert';

class MealDTO {
  final String name;
  final int hour;
  final int minutes;

  MealDTO({
    required this.name,
    required this.hour,
    required this.minutes,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'hour': hour,
      'minutes': minutes,
    };
  }

  factory MealDTO.fromMap(Map<String, dynamic> map) {
    return MealDTO(
      name: map['name'],
      hour: map['hour'],
      minutes: map['minutes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MealDTO.fromJson(String jsonData) {
    return MealDTO.fromMap(
      json.decode(jsonData),
    );
  }
}
