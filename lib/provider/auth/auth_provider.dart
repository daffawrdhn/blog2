// import 'package:blog2/model/auth/auth_response.dart';
import 'package:blog2/bloc/auth/auth_bloc.dart';
import 'package:blog2/model/auth/auth.dart';
import 'package:dio/dio.dart';
import 'package:blog2/utils/logging_interceptor.dart';
import 'package:blog2/pref/auth/authPref.dart';

class AuthProvider {
  final String _api = "http://10.0.2.1/";
  final String _login = "api/login";
  final String _logout = "logout";
  Dio _dio;

  AuthProvider() {
    BaseOptions options =
    BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<Auth> login(String email,String password) async {
    try {
      final data = {"email": email, "password": password};
      Response response = await _dio.post(_api+_login,data: data);
      print("dari login => "+response.data['data']['email']);
      if(response.statusCode == 200) {
        authPref().set(
            response.data['data']['id'],
            response.data['data']['name'],
            response.data['data']['email'],
            response.data['data']['token']);
        authBloc.openSession();
        return Auth.fromJson(response.data);
      } else {
        return null;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Auth> logout() async {
    try {
      String token = await authPref().get();
      _dio.options.headers["authorization"] = "Bearer ${token}";
      Response response = await _dio.get(_api + _logout,);
      authPref().remove();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}