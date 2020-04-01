import 'package:flutter/material.dart';
import 'package:timetrackerfluttercourse/app/sign_in/email_sign_in_form_bloc.dart';

import 'email_sign_in_form_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInFormChangeNotifier.create(context),
//            child: EmailSignInFormBloc.create(context),
//            child: EmailSignInFormStateful(),
          ),
        ),
      ),
    );
  }
}
