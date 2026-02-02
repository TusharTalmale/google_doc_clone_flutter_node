import 'package:dio/dio.dart';
import 'package:google_doc/utils/api_constant.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_doc/models/user_model.dart';
import 'package:google_doc/models/api_response.dart';
import 'package:google_doc/services/dio_client.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.read(dioClientProvider));
}

class AuthRepository {
  final Dio _dio;
  
  AuthRepository(this._dio);

  Future<UserModel> login(String email, String password) async {
    try {
      final res = await _dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );
      
      // Backend returns { token, user } directly
      final data = res.data as Map<String, dynamic>;
      
      final token = data['token'] as String;
      final userData = data['user'] as Map<String, dynamic>;
      
      // Merge token into user data for UserModel
      final userMap = Map<String, dynamic>.from(userData);
      userMap['token'] = token;
      
      return UserModel.fromJson(userMap);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserModel> register(String name, String email, String password) async {
    try {
      final res = await _dio.post(
        ApiConstants.register,
        data: {'name': name, 'email': email, 'password': password},
      );
      
      // Backend returns { token, user } directly
      final data = res.data as Map<String, dynamic>;
      final token = data['token'] as String;
      final userData = data['user'] as Map<String, dynamic>;
      
      final userMap = Map<String, dynamic>.from(userData);
      userMap['token'] = token;
      
      return UserModel.fromJson(userMap);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserModel> googleLogin(String idToken) async {
    try {
      final res = await _dio.post(
        ApiConstants.google,
        data: {'idToken': idToken},
      );
      
      // Backend returns { token, user } directly
      final data = res.data as Map<String, dynamic>;
      final token = data['token'] as String;
      final userData = data['user'] as Map<String, dynamic>;
      
      final userMap = Map<String, dynamic>.from(userData);
      userMap['token'] = token;
      
      return UserModel.fromJson(userMap);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final res = await _dio.get(ApiConstants.profile);
      // Backend returns user object directly
      return UserModel.fromJson(res.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response?.statusCode == 401) {
      return Exception('Unauthorized');
    }
    final message = e.response?.data?['message'] ?? 'Network error';
    return Exception(message);
  }
}