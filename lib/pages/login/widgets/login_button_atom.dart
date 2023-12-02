import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;

import '../../main_page.dart';
import '../cubit/login_button_cubit.dart';
import '../login_page_input_controllers.dart';

class LoginButtonAtom extends StatelessWidget {
  const LoginButtonAtom({super.key});

  @override
  Widget build(BuildContext context) {
    final controllers = context.read<LoginPageInputControllers>();
    
    return BlocBuilder<LoginButtonCubit, bool>(
      bloc: controllers.loginButtonCubit,
      builder: (context, state) {
        return InkWell(
          onTap: state
              ? () {
                  Navigator.of(context)
                      .pushReplacementNamed(MainPage.routeName);
                }
              : null,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: state ? Colors.blueAccent.shade400 : Colors.grey.shade300,
            ),
            child: const Text(
              "로그인",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
