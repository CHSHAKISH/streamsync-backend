// lib/app/bloc/auth_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart'; // This file will be generated

@freezed
sealed class AuthState with _$AuthState {
  // The initial state, when nothing has happened
  const factory AuthState.initial() = _Initial;

  // The state when we are talking to the API
  const factory AuthState.loading() = _Loading;

  // The state when login was successful
  const factory AuthState.success({required String accessToken}) = _Success;

  // The state when registration was successful
  const factory AuthState.registrationSuccess() = _RegistrationSuccess;

  // The state when something went wrong
  const factory AuthState.failure({required String message}) = _Failure;
}