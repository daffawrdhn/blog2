import 'package:blog2/model/auth/auth.dart';
import 'package:blog2/repository/auth/auth_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:blog2/bloc/auth/auth_validator.dart';
import 'dart:async';

class AuthBloc {
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

  login(String email, String password) async {
    Auth response = await _repository.login(email, password);
    _subject.sink.add(response);
  }

  logout() async {
    Auth response = await _repository.logout();
    _subject.sink.add(response);
  }

  submit() async {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    print('Logging in with email: $validEmail and password: $validPassword');
    Auth response = await _repository.login(validEmail, validPassword);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
    _emailController.close();
    _passwordController.close();
  }

  BehaviorSubject<Auth> get subject => _subject;
}

final bloc = AuthBloc();