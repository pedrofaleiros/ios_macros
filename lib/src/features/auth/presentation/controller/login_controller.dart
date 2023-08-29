import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/data/dto/user_dto.dart';

class LoginController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  void clear() {
    usernameController.clear();
    passwordController.clear();
  }

  UserDTO get user => UserDTO(
        name: usernameController.text,
        password: passwordController.text,
        email: '',
      );
}
