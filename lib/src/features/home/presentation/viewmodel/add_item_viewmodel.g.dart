// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_item_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddItemViewmodel on _AddItemViewmodelBase, Store {
  late final _$foodAtom =
      Atom(name: '_AddItemViewmodelBase.food', context: context);

  @override
  FoodModel? get food {
    _$foodAtom.reportRead();
    return super.food;
  }

  @override
  set food(FoodModel? value) {
    _$foodAtom.reportWrite(value, super.food, () {
      super.food = value;
    });
  }

  late final _$_AddItemViewmodelBaseActionController =
      ActionController(name: '_AddItemViewmodelBase', context: context);

  @override
  void copy(FoodModel newFood) {
    final _$actionInfo = _$_AddItemViewmodelBaseActionController.startAction(
        name: '_AddItemViewmodelBase.copy');
    try {
      return super.copy(newFood);
    } finally {
      _$_AddItemViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_AddItemViewmodelBaseActionController.startAction(
        name: '_AddItemViewmodelBase.clear');
    try {
      return super.clear();
    } finally {
      _$_AddItemViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
food: ${food}
    ''';
  }
}
