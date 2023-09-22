import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/controller/login_controller.dart';
import 'package:provider/provider.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({super.key});

  Widget get _suffixIcon {
    return const Padding(
      padding: EdgeInsets.only(right: 6.0),
      child: Icon(
        CupertinoIcons.person,
        size: 28,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginController = context.read<LoginController>();

    return CupertinoTextField(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusNode: loginController.usernameFocusNode,
      placeholder: 'Digite seu username',
      controller: loginController.usernameController,
      suffix: _suffixIcon,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(loginController.passwordFocusNode);
      },
      onChanged: (value) {
        if (value.contains(' ')) {
          loginController.usernameController.text = value.replaceAll(' ', '');

          loginController.usernameController.selection =
              TextSelection.fromPosition(
            TextPosition(
                offset: loginController.usernameController.text.length),
          );
        }
      },
    );
  }
}
