import 'package:blog2/bloc/auth/auth_bloc.dart';
import 'package:blog2/bloc/auth/auth_provider.dart';
import 'package:blog2/model/auth/auth.dart';
import 'package:blog2/pref/auth/authPref.dart';
import 'package:blog2/screen/auth/login.dart';
import 'package:flutter/material.dart';

import 'package:blog2/screen/home.dart';
import 'package:blog2/screen/auth/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget{
  Home(AuthBloc bloc);


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Provider(
        child: Scaffold(
          appBar: AppBar(

            title: Text('Home'),
          ),
          body: Center(

            child: Column(
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              SharedPreferences localStorage = await SharedPreferences.getInstance();
              authPref().remove();
            },
            tooltip: 'Increment',
            child: Icon(Icons.logout),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        )
    );
  }


}