import 'package:blog2/bloc/auth/auth_bloc.dart';
import 'package:blog2/model/auth/auth.dart';
import 'package:blog2/repository/auth/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {

  final AuthRepository _repository = AuthRepository();
  final BehaviorSubject<Auth> _subject = BehaviorSubject<Auth>();

  logoutUser() async {
    // Auth response = await _repository.logout();
    AuthorizationBloc().closeSession();
    // _subject.sink.add(response);
  }

}