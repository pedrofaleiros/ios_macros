// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MealModel on _MealModelBase, Store {
  late final _$idAtom = Atom(name: '_MealModelBase.id', context: context);

  @override
  String get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$nameAtom = Atom(name: '_MealModelBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$hourAtom = Atom(name: '_MealModelBase.hour', context: context);

  @override
  int get hour {
    _$hourAtom.reportRead();
    return super.hour;
  }

  @override
  set hour(int value) {
    _$hourAtom.reportWrite(value, super.hour, () {
      super.hour = value;
    });
  }

  late final _$minutesAtom =
      Atom(name: '_MealModelBase.minutes', context: context);

  @override
  int get minutes {
    _$minutesAtom.reportRead();
    return super.minutes;
  }

  @override
  set minutes(int value) {
    _$minutesAtom.reportWrite(value, super.minutes, () {
      super.minutes = value;
    });
  }

  late final _$itemsAtom = Atom(name: '_MealModelBase.items', context: context);

  @override
  ObservableList<ItemModel> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<ItemModel> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$_MealModelBaseActionController =
      ActionController(name: '_MealModelBase', context: context);

  @override
  void addItem(ItemModel item) {
    final _$actionInfo = _$_MealModelBaseActionController.startAction(
        name: '_MealModelBase.addItem');
    try {
      return super.addItem(item);
    } finally {
      _$_MealModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteItem(String itemId) {
    final _$actionInfo = _$_MealModelBaseActionController.startAction(
        name: '_MealModelBase.deleteItem');
    try {
      return super.deleteItem(itemId);
    } finally {
      _$_MealModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateItem(String id, double amount) {
    final _$actionInfo = _$_MealModelBaseActionController.startAction(
        name: '_MealModelBase.updateItem');
    try {
      return super.updateItem(id, amount);
    } finally {
      _$_MealModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
name: ${name},
hour: ${hour},
minutes: ${minutes},
items: ${items}
    ''';
  }
}
