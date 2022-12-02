import 'package:blog2/model/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:blog2/bloc/auth/auth_bloc.dart';
import 'package:blog2/pref/auth/authPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:blog2/screen/home.dart';

import 'package:flutter/material.dart';
import 'package:blog2/bloc/auth/auth_bloc.dart';
import 'package:blog2/bloc/auth/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen(AuthBloc bloc);


  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = Provider.of(context);

    return Provider(
        child: Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(bloc),
          passwordField(bloc),
          submitButton(bloc),
          userData(bloc)
        ],
      ),
    ),
    );
  }

  Widget emailField(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'You email address',
            labelText: 'Email Address',
            errorText: snapshot.error,
          ),
          onChanged: (String value) {
            bloc.updateEmail(value);
          },
        );
      },
    );
  }

  Widget passwordField(AuthBloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Password',
            errorText: snapshot.error,
          ),
          onChanged: (String value) {
            bloc.updatePassword(value);
          },
        );
      },
    );
  }

  Widget submitButton(AuthBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return ElevatedButton(
          child: Text('Submit'),
          onPressed: () async {
            // SharedPreferences localStorage = await SharedPreferences.getInstance();
            if(snapshot.hasData){
              bloc.submit();
              // if(localStorage.getString('token') != null ){
              //   Navigator.pushReplacement(
              //       context,
              //       new MaterialPageRoute(
              //           builder: (context) => Home(bloc)
              //       )
              //   );
              // }
            }
          },
          // onPressed: snapshot.hasData ? bloc.submit : null,
        );
      },
    );
  }

  Widget userData(AuthBloc bloc) {
    return StreamBuilder<Auth>(
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<Auth> snapshot) {
        if (snapshot.hasData) {
          return _buildUserWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("waiting data from API..."), CircularProgressIndicator()],
        ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error"),
          ],
        ));
  }

  Widget _buildUserWidget(Auth data) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name: "+data.data.name),
            Text("Email: "+data.data.email),
            Text("Token: "+data.data.token),
            Text("ID: "+data.data.id.toString()),
            Text("Message: "+data.message),
          ],
        ));
  }
}