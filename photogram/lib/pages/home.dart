import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:photogram/models/user.dart';
import 'package:photogram/pages/activity_feed.dart';
import 'package:photogram/pages/create_account.dart';
import 'package:photogram/pages/profile.dart';
import 'package:photogram/pages/search.dart';
import 'package:photogram/pages/upload.dart';

final GoogleSignIn googleSignin = GoogleSignIn();
final usersRef = Firestore.instance.collection('users');
final timestamp = DateTime.now();
User currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController();

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
    createUserInFirestore();
    setState(() {
      isAuth = true;
    });
  }

  createUserInFirestore() async {
    final GoogleSignInAccount user = googleSignin.currentUser;
    DocumentSnapshot doc = await usersRef.document(user.id).get();

    if (!doc.exists) {
      final username = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateAccount()),
      );

      usersRef.document(user.id).setData({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp,
      });
      doc = await usersRef.document(user.id).get();
    }
    currentUser = User.fromDocument(doc);
    print(currentUser);
    print(currentUser.username);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  logout() {
    googleSignin.signOut();
  }

  login() {
    googleSignin.signIn();
  }

  Widget buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          // Timeline(),
          RaisedButton(
            child: Text('Logout'),
            onPressed: logout,
          ),
          ActivityFeed(),
          Upload(currentUser: currentUser),
          Search(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: onPageChange,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_camera,
              size: 35.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  onPageChange(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
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
