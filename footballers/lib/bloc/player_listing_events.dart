import 'package:footballers/models/nation.dart';

abstract class PlayerListingEvent {}

class CountrySelectedEvent extends PlayerListingEvent {
  final NationModel nationModel;

  CountrySelectedEvent({this.nationModel}) : assert(nationModel != null);

  @override
  String toString() {
    return 'CountrySelectedEvent {nation: $nationModel}';
  }
}
