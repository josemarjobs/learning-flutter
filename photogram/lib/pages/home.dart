import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignin = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    googleSignin.onCurrentUserChanged.listen(
      handleSignInSuccess,
      onError: handleSignInError,
    );

    // reauthenticate when the app is open
    googleSignin
        .signInSilently(suppressErrors: false)
        .then(handleSignInSuccess)
        .catchError(handleSignInError);
  }

  void handleSignInError(err) {
    print('Error sigining in: $err');
  }

  void handleSignInSuccess(GoogleSignInAccount account) {
    if (account == null) {
      print('not signed in');
      setState(() {
        isAuth = false;
      });
      return;
    }
    print('User sign in: $account');
    setState(() {
      isAuth = true;
    });
  }

  logout() {
    googleSignin.signOut();
  }

  login() {
    googleSignin.signIn();
  }

  Widget buildAuthScreen() {
    return RaisedButton(
      child: Text('Logout'),
      onPressed: logout,
    );
  }

  Widget buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.teal, Colors.purple],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Photogram',
              style: TextStyle(
                fontFamily: 'Signatra',
                fontSize: 90.0,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 260.0,
                height: 60.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
