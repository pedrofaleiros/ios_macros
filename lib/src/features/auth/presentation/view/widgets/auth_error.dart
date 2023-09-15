import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class AuthError extends StatelessWidget {
  const AuthError({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final error = context.read<AuthViewmodel>().authError;
        return error != null
            ? Text(
                error,
                style: const TextStyle(
                  color: CupertinoColors.systemRed,
                ),
              )
            : Container();
      },
    );
  }
}