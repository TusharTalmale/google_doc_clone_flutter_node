import 'package:dio/dio.dart';
import 'package:google_doc/utils/constant/api_constant.dart';
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
      
      final apiRes = ApiResponse<Map<String, dynamic>>.fromJson(
        res.data,
        (json) => json as Map<String, dynamic>,
      );
      
      if (!apiRes.success) throw Exception(apiRes.message);
      
      final user = UserModel.fromJson(apiRes.data!);
      return user;
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
      
      final apiRes = ApiResponse<Map<String, dynamic>>.fromJson(
        res.data,
        (json) => json as Map<String, dynamic>,
      );
      
      if (!apiRes.success) throw Exception(apiRes.message);
      
      return UserModel.fromJson(apiRes.data!);
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
      
      final apiRes = ApiResponse<Map<String, dynamic>>.fromJson(
        res.data,
        (json) => json as Map<String, dynamic>,
      );
      
      if (!apiRes.success) throw Exception(apiRes.message);
      
      return UserModel.fromJson(apiRes.data!);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final res = await _dio.get(ApiConstants.profile);
      return UserModel.fromJson(res.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    final message = e.response?.data?['message'] ?? 'Network error';
    return Exception(message);
  }
}