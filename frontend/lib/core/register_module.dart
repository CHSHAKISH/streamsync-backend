// lib/core/register_module.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {

  @lazySingleton
  Dio get dio {
    final dio = Dio();

    // --- MAKE SURE THIS URL IS CORRECT ---
    // It must match your backend's prefix
    dio.options.baseUrl = 'http://10.0.2.2:3000/api';
    // -----------------------------------

    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds:5);

    return dio;
  }
}