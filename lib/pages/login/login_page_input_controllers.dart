import 'package:flutter/material.dart';
import 'package:todotee_app/pages/login/cubit/login_button_cubit.dart';

class LoginPageInputControllers {
  late TextEditingController _idController;
  TextEditingController get idController => _idController;

  late TextEditingController _passwordController;
  TextEditingController get passwordController => _passwordController;

  late LoginButtonCubit _loginButtonCubit;
  LoginButtonCubit get loginButtonCubit => _loginButtonCubit;

  LoginPageInputControllers();

  void initializeControllers() {
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    _loginButtonCubit = LoginButtonCubit();
  }

  void switchLoginButtonState() {
    final bool isButtonValid =
        _idController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    _loginButtonCubit.changeState(isButtonValid);
  }
}
