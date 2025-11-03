// lib/app/bloc/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/app/bloc/auth_event.dart';
import 'package:frontend/app/bloc/auth_state.dart';
import 'package:frontend/core/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;

  // The repository is automatically injected by getIt
  AuthBloc(this._authRepository) : super(const AuthState.initial()) {
    // Register the event handlers
    on<AuthEvent>(_onEvent);
  }

  Future<void> _onEvent(AuthEvent event, Emitter<AuthState> emit) async {
    await event.when(
      register: (email, password) async {
        emit(const AuthState.loading());
        final success = await _authRepository.register(
          email: email,
          password: password,
        );
        if (success) {
          emit(const AuthState.registrationSuccess());
        } else {
          emit(const AuthState.failure(message: 'Registration failed'));
        }
      },
      login: (email, password) async {
        emit(const AuthState.loading());
        final result = await _authRepository.login(
          email: email,
          password: password,
        );
        // Handle our custom AuthResult
        if (result is AuthSuccess) {
          emit(AuthState.success(accessToken: result.accessToken));
        } else if (result is AuthFailure) {
          emit(AuthState.failure(message: result.message));
        }
      },
    );
  }
}