// lib/core/register_module.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio {
    // Configure Dio with your backend URL
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:3000', // <-- IMPORTANT!
        // '10.0.2.2' is the special IP for Android Emulator
        // to connect to your computer's 'localhost'
      ),
    );
    return dio;
  }
}