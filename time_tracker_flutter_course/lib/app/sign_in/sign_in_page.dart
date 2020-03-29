import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerfluttercourse/app/sign_in/email_sign_in_page.dart';
import 'package:timetrackerfluttercourse/app/sign_in/sign_in_bloc.dart';
import 'package:timetrackerfluttercourse/app/sign_in/sign_in_button.dart';
import 'package:timetrackerfluttercourse/app/sign_in/social_sign_in_button.dart';
import 'package:timetrackerfluttercourse/custom_widgets/platform_exception_alert_dialog.dart';
import 'package:timetrackerfluttercourse/services/auth.dart';

class SignInPage extends StatelessWidget {
  final SignInBloc bloc;

  SignInPage({@required this.bloc});

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return Provider<SignInBloc>(
      create: (context) => SignInBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, _) => SignInPage(
          bloc: bloc,
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  void _signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
      print(e);
    }
  }

  void _signInWithGoogle(BuildContext context) async {
    try {
      var user = await bloc.signInWithGoogle();
      print('Google User: $user');
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
      print(e);
    }
  }

  void _signInWithEmail(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: StreamBuilder<bool>(
          initialData: false,
          stream: bloc.isLoadingStream,
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.data);
          }),
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 50.0, child: _buildHeader(isLoading)),
          SizedBox(height: 48.0),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
            color: Colors.white,
            text: 'Sign in with Google',
            textColor: Colors.black87,
          ),
          SizedBox(height: 8.0),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            onPressed: isLoading ? null : () {},
            color: Color(0xFF334d92),
            text: 'Sign in with Facebook',
            textColor: Colors.white,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            onPressed: isLoading ? null : () => _signInWithEmail(context),
            color: Colors.teal.shade700,
            text: 'Sign in with email',
            textColor: Colors.white,
          ),
          SizedBox(height: 12.0),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
          ),
          SizedBox(height: 12.0),
          SignInButton(
            onPressed: isLoading ? null : () => _signInAnonymously(context),
            color: Colors.lime.shade300,
            text: 'Go anonymous',
            textColor: Colors.black87,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
          );
  }
}
