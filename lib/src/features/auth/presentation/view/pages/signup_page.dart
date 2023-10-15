import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/controller/signup_controller.dart';
import 'package:ios_macros/src/features/auth/presentation/view/widgets/auth_error.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    final signupController = context.read<SignupController>();
    signupController.clear();
    context.read<AuthViewmodel>().clearError();

    return CupertinoPageScaffold(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignupTextField(
              icon: CupertinoIcons.mail,
              textController: signupController.emailController,
              focusNode: signupController.emailFocusNode,
              onEditingComplete: () => FocusScope.of(context)
                  .requestFocus(signupController.usernameFocusNode),
              obscureText: false,
              placeholder: 'Digite seu email',
            ),
            const SizedBox(height: 16),
            SignupTextField(
              icon: CupertinoIcons.person,
              textController: signupController.usernameController,
              focusNode: signupController.usernameFocusNode,
              onEditingComplete: () => FocusScope.of(context)
                  .requestFocus(signupController.passwordFocusNode),
              obscureText: false,
              placeholder: 'Digite seu username',
            ),
            const SizedBox(height: 16),
            const PasswordTextFieldSignup(),
            const SizedBox(height: 8),
            const AuthError(),
            const SizedBox(height: 8),
            const SignupButton(),
            CupertinoButton(
              onPressed: () {
                context.read<AuthViewmodel>().clearError();
                Navigator.pop(context);
              },
              child: const Text('Entrar'),
            )
          ],
        ),
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    final signupController = context.read<SignupController>();
    final auth = context.read<AuthViewmodel>();

    return CupertinoButton.filled(
      onPressed: auth.isLoading
          ? null
          : () async {
              await auth.signup(signupController.user).then(
                (value) {
                  if (value) {
                    Navigator.pop(context, true);
                  }
                },
              );
            },
      child: Observer(
        builder: (context) => auth.isLoading
            ? const CupertinoActivityIndicator()
            : const Text(
                'Cadastrar',
                style: TextStyle(color: CupertinoColors.white),
              ),
      ),
    );
  }
}

class SignupTextField extends StatelessWidget {
  const SignupTextField({
    super.key,
    required this.icon,
    required this.textController,
    required this.focusNode,
    required this.onEditingComplete,
    required this.obscureText,
    required this.placeholder,
  });

  final IconData icon;
  final FocusNode focusNode;
  final TextEditingController textController;
  final bool obscureText;
  final VoidCallback? onEditingComplete;
  final String placeholder;

  Widget get _suffixIcon {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: Icon(
        icon,
        size: 28,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      onEditingComplete: onEditingComplete,
      controller: textController,
      placeholder: placeholder,
      obscureText: obscureText,
      focusNode: focusNode,
      suffix: _suffixIcon,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8.0),
      ),
      onChanged: (value) {
        if (value.contains(' ')) {
          textController.text = value.replaceAll(' ', '');
          textController.selection = TextSelection.fromPosition(
            TextPosition(offset: textController.text.length),
          );
        }
      },
    );
  }
}

class PasswordTextFieldSignup extends StatefulWidget {
  const PasswordTextFieldSignup({super.key});

  @override
  State<PasswordTextFieldSignup> createState() =>
      _PasswordTextFieldSignupState();
}

class _PasswordTextFieldSignupState extends State<PasswordTextFieldSignup> {
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
    final signupController = context.read<SignupController>();
    final auth = context.read<AuthViewmodel>();

    return CupertinoTextField(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8.0),
      ),
      placeholder: 'Digite sua senha',
      focusNode: signupController.passwordFocusNode,
      controller: signupController.passwordController,
      obscureText: _obscureText,
      suffix: _suffixIcon,
      onEditingComplete: () async {
        await auth.signup(signupController.user).then(
          (value) {
            if (value) {
              Navigator.pop(context, true);
            }
          },
        );
      },
    );
  }
}
