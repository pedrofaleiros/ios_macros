import 'package:flutter/cupertino.dart';

class GotoSignupButton extends StatelessWidget {
  const GotoSignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        // Navigator.pushReplacementNamed(context, SignupPage.routeName);
      },
      child: const Text('Cadastrar'),
    );
  }
}
