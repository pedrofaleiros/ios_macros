import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/view/pages/login_page.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/home_page.dart';
import 'package:ios_macros/src/utils/widgets/loading_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewmodel>();
    return FutureBuilder(
      future: auth.autologin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage(
            message: 'Validando credenciais',
          );
        }

        return Observer(
          builder: (context) {
            if (auth.isAuth) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        );
      },
    );
  }
}
