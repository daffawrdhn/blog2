import 'package:flutter/material.dart';
import 'package:blog2/bloc/auth/auth_bloc.dart';

class Provider extends InheritedWidget {
  final AuthBloc bloc = AuthBloc();
  bool updateShouldNotify(_) => true;

  // https://www.dartlang.org/guides/language/language-tour#initializer-list
  Provider({Key key, Widget child}) : super(key: key, child: child);

  static AuthBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).bloc;
  }
}