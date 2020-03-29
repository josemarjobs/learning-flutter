import 'package:flutter/material.dart';
import 'package:timetrackerfluttercourse/custom_widgets/custom_raised_button.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    @required VoidCallback onPressed,
  })  : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
          onPressed: onPressed,
          height: 44.0,
          color: Colors.indigo,
          borderRadius: 4.0,
        );
}
