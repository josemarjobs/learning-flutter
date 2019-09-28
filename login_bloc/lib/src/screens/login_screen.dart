import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            emailField(bloc),
            passwordField(bloc),
            SizedBox(height: 16.0),
            submitButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget emailField(bloc) {
    return StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changeEmail,
            decoration: InputDecoration(
              labelText: 'Email Address',
              hintText: 'you@example.com',
              errorText: snapshot.error,
            ),
            keyboardType: TextInputType.emailAddress,
          );
        });
  }

  Widget passwordField(bloc) {
    return StreamBuilder<Object>(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changePassword,
            decoration: InputDecoration(
                labelText: 'Password',
                hintText: '*****',
                errorText: snapshot.error),
            obscureText: true,
          );
        });
  }

  Widget submitButton(bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Login'),
          color: Colors.teal,
          onPressed: snapshot.hasData ? bloc.submit : null,
        );
      },
    );
  }
}
