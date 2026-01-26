// lib/services/dio_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://YOUR_LOCAL_IP:3000', // Use your IP, not localhost for Android
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  
  // Custom Interceptor to add Auth Token
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // You can fetch token from secure storage here
      // options.headers['Authorization'] = 'Bearer $yourToken';
      return handler.next(options);
    },
  ));

  return dio;
});