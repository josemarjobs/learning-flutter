import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerfluttercourse/home/jobs/jobs_page.dart';
import 'package:timetrackerfluttercourse/app/sign_in/sign_in_page.dart';
import 'package:timetrackerfluttercourse/services/auth.dart';
import 'package:timetrackerfluttercourse/services/database.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: Provider.of<AuthBase>(context).onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          } else {
            return Provider<Database>(
              create: (context) => FirestoreDatabase(uid: user.uid),
              child: JobsPage(),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
