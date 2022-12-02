// import 'package:blog2/model/auth/auth_response.dart';
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
      authPref().set(
          response.data['data']['id'],
          response.data['data']['name'],
          response.data['data']['email'],
          response.data['data']['token']);
      return Auth.fromJson(response.data);
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

  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
          "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
          "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}