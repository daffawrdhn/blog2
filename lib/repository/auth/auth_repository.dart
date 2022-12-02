import 'package:blog2/model/auth/auth.dart';
import 'package:blog2/provider/auth/auth_provider.dart';

class AuthRepository{
  AuthProvider _authProvider = AuthProvider();

  Future<Auth> login(String email,String password){
    return _authProvider.login(email, password);
  }

  Future<Auth> logout(){
    return _authProvider.logout();
  }
}