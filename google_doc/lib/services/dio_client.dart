import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_doc/utils/api_constant.dart';
import 'package:google_doc/services/storage_service.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  final storage = ref.read(storageServiceProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl, // MUST be 127.0.0.1 for web
      // connectTimeout: const Duration(seconds: 15),
      // receiveTimeout: const Duration(seconds: 15),
      headers: const {
        'Content-Type': 'application/json',
      },
    ),
  );

  // AUTH INTERCEPTOR
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.getToken();

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await storage.deleteToken();
        }
        handler.next(error);
      },
    ),
  );

  // LOGGING (DEBUG ONLY)
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint('[DIO] $obj'),
      ),
    );
  }

  return dio;
}
