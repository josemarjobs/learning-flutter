import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerfluttercourse/custom_widgets/form_submit_button.dart';
import 'package:timetrackerfluttercourse/custom_widgets/platform_exception_alert_dialog.dart';
import 'package:timetrackerfluttercourse/services/auth.dart';

import 'email_sign_in_bloc.dart';
import 'email_sign_in_model.dart';

class EmailSignInFormBloc extends StatefulWidget {
  EmailSignInFormBloc({@required this.bloc});

  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return Provider<EmailSignInBloc>(
      create: (context) => EmailSignInBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<EmailSignInBloc>(
        builder: (context, bloc, widget) => EmailSignInFormBloc(
          bloc: bloc,
        ),
      ),
    );
  }

  @override
  _EmailSignInFormBlocState createState() => _EmailSignInFormBlocState();
}

class _EmailSignInFormBlocState extends State<EmailSignInFormBloc> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    print('dispose called');
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  void _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    }
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      Text(
        model.formType == EmailSignInFormType.signIn ? 'Sign In' : 'Register',
        style: TextStyle(
          fontSize: 40.0,
        ),
      ),
      SizedBox(height: 16.0),
      _buildEmailTextField(model),
      SizedBox(height: 16.0),
      _buildPasswordTextField(model),
      SizedBox(height: 16.0),
      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(height: 16.0),
      FlatButton(
        child: Text(model.secondaryButtonText),
        onPressed: model.isLoading ? null : _toggleFormType,
      )
    ];
  }

  Widget _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      autocorrect: false,
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: widget.bloc.updatePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'your password here',
        errorText: model.passwordErrorText,
        enabled: !model.isLoading,
      ),
    );
  }

  Widget _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      controller: _emailController,
      autocorrect: false,
      focusNode: _emailFocusNode,
      onEditingComplete: () => _emailEditingComplete(model),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: widget.bloc.updateEmail,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'email@example.com',
        errorText: model.emailErrorText,
        enabled: !model.isLoading,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildChildren(model),
            ),
          );
        });
  }
}
