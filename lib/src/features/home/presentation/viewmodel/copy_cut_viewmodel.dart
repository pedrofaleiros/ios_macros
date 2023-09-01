import 'package:ios_macros/src/features/home/domain/model/item_model.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';

class CopyPasteViewmodel {
  List<ItemModel> items = [];

  void copy(MealModel meal) {
    items.clear();

    for (var item in meal.items) {
      items.add(item);
    }
  }

  List<ItemModel> paste() => items;

  void clear() {
    items.clear();
  }
}
