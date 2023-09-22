import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/view/pages/signup_page.dart';

class GotoSignupButton extends StatelessWidget {
  const GotoSignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.pushNamed(context, SignupPage.routeName);
      },
      child: const Text('Cadastrar'),
    );
  }
}
