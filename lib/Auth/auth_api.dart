

import 'package:dio/dio.dart';

class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  // REGISTER
  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    String? referral,
  }) async {
    return await _dio.post(
      '/api/register',
      data: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "phone": phone,
        "ref": referral,
      },
    );
  }

  // LOGIN
  Future<Response> login({
    required String email,
    required String password,
  }) {
    return _dio.post(
      '/api/login',
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  // Reset password
  Future<Response> requestResetPassword({
    required String email,
  }) {
    return _dio.post(
      '/api/forget-password-token',
      data: {
        'email': email,
      },
    );
  }

  // BVN STEP 1
  Future<Response> initializeVerify({
    required String bvn,
  }) {
    return _dio.post(
      '/api/initialize-verify',
      data: {
        'type': 'bvn',
        'number': bvn,
      },
    );
  }

  // BVN STEP 2
  Future<Response> verifyOtp({
    required String id,
    required String otp,
  }) {
    return _dio.post(
      '/api/verify-otp',
      data: {
        'type': 'bvn',
        'id': id,
        'otp': otp,
      },
    );
  }
}

