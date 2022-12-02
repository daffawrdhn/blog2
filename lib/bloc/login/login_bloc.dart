import 'package:blog2/bloc/auth/auth_bloc.dart';
import 'package:blog2/model/auth/auth.dart';
import 'package:blog2/repository/auth/auth_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:blog2/bloc/login/login_validator.dart';
import 'dart:async';

class LoginBloc {
  final AuthRepository _repository = AuthRepository();
  final BehaviorSubject<Auth> _subject = BehaviorSubject<Auth>();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get updateEmail => _emailController.sink.add;
  Function(String) get updatePassword => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(Validator().validateEmail);
  Stream<String> get password => _passwordController.stream.transform(Validator().validatePassword);

  Stream<bool> get submitValid => CombineLatestStream.combine2(email, password, (email, password) {
    return true;
  });

  final PublishSubject _isSessionValid = PublishSubject<bool>();
  Stream<bool> get isSessionValid => _isSessionValid.stream;

  // logout() async {
  //   Auth response = await _repository.logout();
  //   _subject.sink.add(response);
  // }

  submit() async {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    print('Try Logging in with email: $validEmail and password: $validPassword');
    login(validEmail, validPassword);
  }

  login(String email, String password) async {
    Auth response = await _repository.login(email, password);
    _subject.sink.add(response);
    // authBloc.openSession();
  }

  dispose() {
    _subject.close();
    _emailController.close();
    _passwordController.close();
  }

  BehaviorSubject<Auth> get subject => _subject;
}

final bloc = LoginBloc();