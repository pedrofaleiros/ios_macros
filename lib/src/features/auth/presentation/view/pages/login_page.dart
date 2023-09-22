import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/controller/login_controller.dart';
import 'package:ios_macros/src/features/auth/presentation/view/widgets/auth_error.dart';
import 'package:ios_macros/src/features/auth/presentation/view/widgets/login/goto_signup_button.dart';
import 'package:ios_macros/src/features/auth/presentation/view/widgets/login/login_button.dart';
import 'package:ios_macros/src/features/auth/presentation/view/widgets/login/password_textfield.dart';
import 'package:ios_macros/src/features/auth/presentation/view/widgets/login/username_testfield.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    context.read<AuthViewmodel>().clearError();

    context.read<LoginController>().clear();
    return CupertinoPageScaffold(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UsernameTextField(),
            SizedBox(height: 16),
            PasswordTextField(),
            SizedBox(height: 8),
            AuthError(),
            SizedBox(height: 8),
            LoginButton(),
            GotoSignupButton(),
          ],
        ),
      ),
    );
  }
}
