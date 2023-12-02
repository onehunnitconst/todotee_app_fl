import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todotee_app/api/memo_io_provider.dart';
import 'package:todotee_app/api/memo_dio_provider.dart';
import 'package:todotee_app/api/todo_io_provider.dart';
import 'package:todotee_app/api/todo_dio_provider.dart';
import 'package:todotee_app/constants.dart';
import 'package:todotee_app/pages/login/login_page.dart';
import 'package:todotee_app/pages/login/login_page_input_controllers.dart';
import 'package:todotee_app/pages/memo_detail/bloc/memo_detail_bloc.dart';
import 'package:todotee_app/pages/memo_edit/memo_edit_page.dart';
import 'package:todotee_app/pages/memo_edit/memo_edit_page_input_controllers.dart';
import 'package:todotee_app/pages/main_page.dart';
import 'package:todotee_app/pages/main_page_nav_cubit.dart';
import 'package:todotee_app/pages/memo/bloc/memo_bloc.dart';
import 'package:todotee_app/pages/memo_detail/memo_detail_page.dart';
import 'package:todotee_app/pages/todo/bloc/todo_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dio>(
          create: (context) => Dio(
            BaseOptions(baseUrl: Constants.apiRoute),
          ),
        ),
        Provider<MemoDioProvider>(
          create: (context) => MemoDioProvider(
            client: context.read<Dio>(),
          ),
        ),
        Provider<TodoDioProvider>(
          create: (context) => TodoDioProvider(
            client: context.read<Dio>(),
          ),
        ),
        Provider<HttpClient>(
          create: (context) => HttpClient(),
        ),
        Provider<TodoIoProvider>(
          create: (context) => TodoIoProvider(
            client: context.read<HttpClient>(),
          ),
        ),
        Provider<MemoIoProvider>(
          create: (context) => MemoIoProvider(
            client: context.read<HttpClient>(),
          ),
        ),
        Provider<MainPageNavCubit>(
          create: (context) => MainPageNavCubit(),
        ),
        Provider<TodoBloc>(
          create: (context) => TodoBloc(
            todoProvider: context.read<TodoDioProvider>(),
          ),
        ),
        Provider<MemoBloc>(
          create: (context) => MemoBloc(
            memoProvider: context.read<MemoDioProvider>(),
          ),
        ),
        Provider<MemoDetailBloc>(
          create: (context) => MemoDetailBloc(
            memoApi: context.read<MemoIoProvider>(),
          ),
        ),
        Provider<MemoEditPageInputControllers>(
          create: (context) => MemoEditPageInputControllers(),
        ),
        Provider<LoginPageInputControllers>(
          create: (context) => LoginPageInputControllers(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: LoginPage.routeName,
        routes: {
          LoginPage.routeName: (context) => const LoginPage(),
          MainPage.routeName: (context) => const MainPage(),
          MemoEditPage.routeName: (context) => const MemoEditPage(),
          MemoDetailPage.routeName: (context) => const MemoDetailPage(),
        },
      ),
    );
  }
}
