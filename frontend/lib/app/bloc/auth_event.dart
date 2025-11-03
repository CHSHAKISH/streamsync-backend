// lib/app/bloc/auth_event.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart'; // This file will be generated

@freezed
sealed class AuthEvent with _$AuthEvent {
  // Event when user tries to register
  const factory AuthEvent.register({
    required String email,
    required String password,
  }) = _Register;

  // Event when user tries to login
  const factory AuthEvent.login({
    required String email,
    required String password,
  }) = _Login;
}