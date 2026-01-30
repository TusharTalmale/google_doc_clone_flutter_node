import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/utils/constant/api_constant.dart';
import 'package:google_doc/services/storage_service.dart';

final dioProvider = Provider<Dio>((ref) {
  final storageService = ref.read(storageServiceProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  // Custom Interceptor to add Auth Token
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storageService.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ),
  );
  
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) {
        // ignore: avoid_print
        print(obj);
      },
      error: true,
      requestHeader: true,
      responseHeader: true,
      request: true,

    ),
  );
  //  dio.interceptors.add(
  //   InterceptorsWrapper(
  //     onRequest: (options, handler) async {
  //       final token = await storageService.getToken();
  //       //storage.token; // 🔥 memory cached

  //       if (token != null) {
  //         options.headers["Authorization"] = "Bearer $token";
  //       }

  //       return handler.next(options);
  //     },

  //     onError: (error, handler) async {
  //       if (error.response?.statusCode == 401) {
  //         // 🔒 future refresh-token logic
  //         // ref.read(authControllerProvider.notifier).logout();
  //       }
  //       return handler.next(error);
  //     },
  //   ),
  // );
      // dio.interceptors.add(_loggerInterceptor());


  return dio;
});

//  InterceptorsWrapper _loggerInterceptor() {
//     return InterceptorsWrapper(
//       onRequest: (options, handler) {
//         print("➡️ ${options.method} ${options.path}");
//         return handler.next(options);
//       },
//       onResponse: (response, handler) {
//         print("✅ ${response.statusCode} ${response.requestOptions.path}");
//         return handler.next(response);
//       },
//       onError: (error, handler) {
//         print("❌ ${error.message}");
//         return handler.next(error);
//       },
//     );
//   }