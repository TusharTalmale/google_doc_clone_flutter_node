import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/utils/constant/api_constant.dart';
import 'package:google_doc/models/user_model.dart';
import 'package:google_doc/services/dio_client.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(dioProvider));
});

class AuthRepository {
  final Dio _dio;
  AuthRepository(this._dio);

  Future<UserModel> login(String email, String password) async {
    try {
      final res = await _dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );
      return UserModel.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }

  Future<UserModel> register(String name, String email, String password) async {
    final res = await _dio.post(
      ApiConstants.register,
      data: {'name': name, 'email': email, 'password': password},
    );
    return UserModel.fromJson(res.data);
  }

  Future<UserModel> googleLogin(String idToken) async {
    try {
      final res = await _dio.post(
        ApiConstants.google,
        data: {'idToken': idToken},
      );
      return UserModel.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Google login failed');
    }
  }

  Future<UserModel> getUserProfile() async {
    try {
      final res = await _dio.get(ApiConstants.profile);
      return UserModel.fromJson(res.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch profile');
    }
  }
}
