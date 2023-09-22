import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/controller/login_controller.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  void handleTap() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget get _suffixIcon {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: GestureDetector(
        onTap: handleTap,
        child: Icon(
          _obscureText ? CupertinoIcons.lock : CupertinoIcons.lock_open,
          size: 28,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginController = context.read<LoginController>();
    final auth = context.read<AuthViewmodel>();

    return CupertinoTextField(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8.0),
      ),
      placeholder: 'Digite sua senha',
      focusNode: loginController.passwordFocusNode,
      controller: loginController.passwordController,
      obscureText: _obscureText,
      suffix: _suffixIcon,
      onEditingComplete: () async => await auth.login(loginController.user),
    );
  }
}
