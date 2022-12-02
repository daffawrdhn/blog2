import 'package:blog2/bloc/auth/auth_bloc.dart';
import 'package:blog2/bloc/auth/auth_provider.dart';
import 'package:blog2/model/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:blog2/screen/home.dart';
import 'package:blog2/screen/auth/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog',
      debugShowCheckedModeBanner: false,
      home: CheckAuth(),
      darkTheme: ThemeData(brightness: Brightness.dark, accentColor: Colors.black),
      themeMode: ThemeMode.dark,
    );
  }
}
class CheckAuth extends StatefulWidget{
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth>{

  bool isAuth = false;
  var token;

  @override
  void initState(){
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    if(token != null){
      isAuth = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (isAuth) {
      child = Home(bloc);
    } else {
      child = LoginScreen(bloc);
    }

    return Provider(
      child: Scaffold(
        body: child,
      ),
    );
    // return Scaffold(
    //   body: child,
    // );
  }
}