import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotee_app/pages/login/login_page_input_controllers.dart';
import 'package:todotee_app/pages/login/widgets/login_button_atom.dart';
import 'package:todotee_app/pages/login/widgets/login_input_atom.dart';
import 'package:todotee_app/widgets/logo_atom.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = "/login";

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controllers = context.read<LoginPageInputControllers>();

    controllers.initializeControllers();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LogoAtom(
              width: 240.0,
            ),
            const SizedBox(height: 50.0),
            LoginInputAtom(
              controller: controllers.idController,
              hintText: "아이디",
              onChanged: (_) {
                controllers.switchLoginButtonState();
              },
            ),
            const SizedBox(height: 22.0),
            LoginInputAtom(
              controller: controllers.passwordController,
              hintText: "비밀번호",
              onChanged: (_) {
                controllers.switchLoginButtonState();
              },
            ),
            const SizedBox(height: 50.0),
            const LoginButtonAtom(),
          ],
        ),
      ),
    );
  }
}
