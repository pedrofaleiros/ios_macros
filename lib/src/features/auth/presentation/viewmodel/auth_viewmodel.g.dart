// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthViewmodel on _AuthViewmodelBase, Store {
  Computed<bool>? _$isAuthComputed;

  @override
  bool get isAuth => (_$isAuthComputed ??=
          Computed<bool>(() => super.isAuth, name: '_AuthViewmodelBase.isAuth'))
      .value;

  late final _$sessionUserAtom =
      Atom(name: '_AuthViewmodelBase.sessionUser', context: context);

  @override
  UserModel? get sessionUser {
    _$sessionUserAtom.reportRead();
    return super.sessionUser;
  }

  @override
  set sessionUser(UserModel? value) {
    _$sessionUserAtom.reportWrite(value, super.sessionUser, () {
      super.sessionUser = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AuthViewmodelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$authErrorAtom =
      Atom(name: '_AuthViewmodelBase.authError', context: context);

  @override
  String? get authError {
    _$authErrorAtom.reportRead();
    return super.authError;
  }

  @override
  set authError(String? value) {
    _$authErrorAtom.reportWrite(value, super.authError, () {
      super.authError = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthViewmodelBase.login', context: context);

  @override
  Future<void> login(UserDTO user) {
    return _$loginAsyncAction.run(() => super.login(user));
  }

  late final _$signupAsyncAction =
      AsyncAction('_AuthViewmodelBase.signup', context: context);

  @override
  Future<bool> signup(UserDTO user) {
    return _$signupAsyncAction.run(() => super.signup(user));
  }

  late final _$autologinAsyncAction =
      AsyncAction('_AuthViewmodelBase.autologin', context: context);

  @override
  Future<void> autologin() {
    return _$autologinAsyncAction.run(() => super.autologin());
  }

  late final _$_AuthViewmodelBaseActionController =
      ActionController(name: '_AuthViewmodelBase', context: context);

  @override
  void clearError() {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.clearError');
    try {
      return super.clearError();
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sessionUser: ${sessionUser},
isLoading: ${isLoading},
authError: ${authError},
isAuth: ${isAuth}
    ''';
  }
}
