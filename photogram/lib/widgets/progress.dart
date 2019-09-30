import 'package:flutter/material.dart';

Container circularProgress() {
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.purple),
    ),
  );
}

Container linearProgress() {
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
    ),
  );
}
