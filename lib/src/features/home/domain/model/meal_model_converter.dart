import 'dart:convert';

import 'package:ios_macros/src/features/home/domain/model/item_model.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:mobx/mobx.dart';

class MealModelConverter {
  Map<String, dynamic> toMap(MealModel meal) {
    return {
      'id': meal.id,
      'name': meal.name,
      'hour': meal.hour,
      'minutes': meal.minutes,
      'items': meal.items.map((item) => item.toMap()).toList(),
    };
  }

  MealModel fromMap(Map<String, dynamic> map) {
    return MealModel(
      id: map['id'],
      name: map['name'],
      hour: map['hour'],
      minutes: map['minutes'],
      items: map['items'] == null
          ? ObservableList<ItemModel>()
          : (map['items'] as List)
              .map((itemMap) => ItemModel.fromMap(itemMap))
              .toList()
              .asObservable(),
    );
  }

  String toJson(MealModel meal) => json.encode(toMap(meal));

  MealModel fromJson(String jsonData) {
    return fromMap(
      json.decode(jsonData),
    );
  }

  List<MealModel> getList(List<dynamic> data) {
    final responseList = <MealModel>[];

    for (var i = 0; i < data.length; i++) {
      MealModel meal = fromMap(data[i]);
      responseList.add(meal);
    }

    return responseList;
  }
}
