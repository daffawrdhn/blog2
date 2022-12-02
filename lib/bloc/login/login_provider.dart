import 'package:blog2/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final LoginBloc bloc = LoginBloc();
  bool updateShouldNotify(_) => true;

  // https://www.dartlang.org/guides/language/language-tour#initializer-list
  Provider({Key key, Widget child}) : super(key: key, child: child);

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).bloc;
  }
}