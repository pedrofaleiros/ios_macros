// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_error.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginError on _LoginErrorBase, Store {
  Computed<bool>? _$hasLoginErrorsComputed;

  @override
  bool get hasLoginErrors =>
      (_$hasLoginErrorsComputed ??= Computed<bool>(() => super.hasLoginErrors,
              name: '_LoginErrorBase.hasLoginErrors'))
          .value;
  Computed<bool>? _$hasSignupErrorsComputed;

  @override
  bool get hasSignupErrors =>
      (_$hasSignupErrorsComputed ??= Computed<bool>(() => super.hasSignupErrors,
              name: '_LoginErrorBase.hasSignupErrors'))
          .value;

  late final _$emailAtom =
      Atom(name: '_LoginErrorBase.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$nameAtom = Atom(name: '_LoginErrorBase.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_LoginErrorBase.password', context: context);

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$loginErrorAtom =
      Atom(name: '_LoginErrorBase.loginError', context: context);

  @override
  String? get loginError {
    _$loginErrorAtom.reportRead();
    return super.loginError;
  }

  @override
  set loginError(String? value) {
    _$loginErrorAtom.reportWrite(value, super.loginError, () {
      super.loginError = value;
    });
  }

  late final _$_LoginErrorBaseActionController =
      ActionController(name: '_LoginErrorBase', context: context);

  @override
  void setLoginError(String? value) {
    final _$actionInfo = _$_LoginErrorBaseActionController.startAction(
        name: '_LoginErrorBase.setLoginError');
    try {
      return super.setLoginError(value);
    } finally {
      _$_LoginErrorBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_LoginErrorBaseActionController.startAction(
        name: '_LoginErrorBase.clear');
    try {
      return super.clear();
    } finally {
      _$_LoginErrorBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateLogin(UserDTO user) {
    final _$actionInfo = _$_LoginErrorBaseActionController.startAction(
        name: '_LoginErrorBase.validateLogin');
    try {
      return super.validateLogin(user);
    } finally {
      _$_LoginErrorBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateSignup(UserDTO user) {
    final _$actionInfo = _$_LoginErrorBaseActionController.startAction(
        name: '_LoginErrorBase.validateSignup');
    try {
      return super.validateSignup(user);
    } finally {
      _$_LoginErrorBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
name: ${name},
password: ${password},
loginError: ${loginError},
hasLoginErrors: ${hasLoginErrors},
hasSignupErrors: ${hasSignupErrors}
    ''';
  }
}
