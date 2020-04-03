import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class LastUpdated extends StatelessWidget {
  final DateTime dateTime;

  LastUpdated({@required this.dateTime}) : assert(dateTime != null);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Updated: ${TimeOfDay.fromDateTime(dateTime).format(context)}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
}
