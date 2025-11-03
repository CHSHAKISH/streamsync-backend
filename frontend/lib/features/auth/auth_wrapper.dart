// lib/features/auth/auth_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/app/bloc/auth_bloc.dart';
import 'package:frontend/app/bloc/auth_state.dart';
import 'package:frontend/features/auth/login_page.dart';
import 'package:frontend/features/home/home_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocBuilder rebuilds the UI based on the AuthState
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {

        return state.when(
          initial: () => const LoginPage(),
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          success: (accessToken) => const HomePage(),
          registrationSuccess: () => const LoginPage(),
          failure: (message) => const LoginPage(),
        );
      },
    );
  }
}