import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthorizationBloc {
  String _tokenString = '';

  final PublishSubject _isSessionValid = PublishSubject<bool>();
  Stream<bool> get isSessionValid => _isSessionValid.stream;

  void dispose() {
    _isSessionValid.close();
  }
  void restoreSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tokenString = prefs.get('token');
    if (_tokenString != null && _tokenString.length > 0) {
      print('session restore');
      _isSessionValid.sink.add(true);
    } else {
      _isSessionValid.sink.add(false);
    }
  }
  void openSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _tokenString = await prefs.getString('token');
    print('session open');
    _isSessionValid.sink.add(true);
  }
  void closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    print('session close');
    print(_tokenString);
    _isSessionValid.sink.add(false);
  }
}
final authBloc = AuthorizationBloc();