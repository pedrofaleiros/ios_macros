import 'package:ios_macros/src/features/auth/data/dto/user_dto.dart';
import 'package:mobx/mobx.dart';

part 'login_error.g.dart';

// ignore: library_private_types_in_public_api
class LoginError = _LoginErrorBase with _$LoginError;

abstract class _LoginErrorBase with Store {
  @observable
  String? email;

  @observable
  String? name;

  @observable
  String? password;

  @computed
  bool get hasLoginErrors => email != null || password != null;

  @computed
  bool get hasSignupErrors => name != null || email != null || password != null;

  @observable
  String? loginError;

  @action
  void setLoginError(String? value) {
    loginError = value;
    Future.delayed(const Duration(seconds: 3)).then((value) {
      loginError = null;
    });
  }

  @action
  void clear() {
    name = null;
    password = null;
    email = null;
    loginError = null;
  }

  @action
  void validateLogin(UserDTO user) {
    clear();

    if (!user.validateName()) {
      name = 'Username invalido';
    }

    if (!user.validatePassword()) {
      password = 'Senha invalida';
    }
  }

  @action
  void validateSignup(UserDTO user) {
    validateLogin(user);

    if (!user.validateEmail()) {
      email = 'Email invalido';
    }
  }
}
