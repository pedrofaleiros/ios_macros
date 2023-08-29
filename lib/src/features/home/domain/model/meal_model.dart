import 'package:ios_macros/src/features/home/domain/model/item_model.dart';
import 'package:mobx/mobx.dart';
part 'meal_model.g.dart';

// ignore: library_private_types_in_public_api
class MealModel = _MealModelBase with _$MealModel;

abstract class _MealModelBase with Store {
  @observable
  String id;

  @observable
  String name;

  @observable
  int hour;

  @observable
  int minutes;

  @observable
  ObservableList<ItemModel> items;

  _MealModelBase({
    required this.id,
    required this.name,
    required this.hour,
    required this.minutes,
    required this.items,
  });

  @action
  void addItem(ItemModel item) {
    items.add(item);
  }

  @action
  void deleteItem(String itemId) {
    items.removeWhere((element) => element.id == itemId);
  }

  @action
  void updateItem(String id, double amount) {
    // items.add(item);
    for (var element in items) {
      if (element.id == id) {
        element = element.copyWith(
          amount: amount,
        );
        return;
      }
    }
  }
}
