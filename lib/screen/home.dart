import 'package:blog2/bloc/home/home_bloc.dart';
import 'package:blog2/bloc/login/login_bloc.dart';
import 'package:blog2/bloc/login/login_provider.dart';
import 'package:blog2/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc bloc = HomeBloc();

  int id = 0;
  String name = '';
  String email = '';
  String user = '';

  @override
  void initState(){
    super.initState();
    _loadUserData();
  }

  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    id = localStorage.getInt('id');
    user = localStorage.getString('token');
    name = localStorage.getString('name');
    email = localStorage.getString('email');

    if(user != null) {
      setState(() {
      });
    }
  }

  Widget build(BuildContext context) {
    return Provider(
        child: Scaffold(
          appBar: AppBar(

            title: Text('Home'),
          ),
          body: Center(

            child: Column(
              children: [
                Text(name),
                Text(email),
                Text(user),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              bloc.logoutUser();
              Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (context) => LoginScreen()
                ),
              );

            },
            tooltip: 'Increment',
            child: Icon(Icons.logout),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        )
    );
  }

}