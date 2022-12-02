import 'package:shared_preferences/shared_preferences.dart';

class authPref {

  set(int id, String name, String email, String token) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setInt('id', id);
    localStorage.setString('name', name);
    localStorage.setString('email', email);
    localStorage.setString('token', token);
  }

  get() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final _prefToken = localStorage.getString('token');
    return _prefToken;
  }

  remove() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('id');
    localStorage.remove('name');
    localStorage.remove('email');
    localStorage.remove('token');
  }
}