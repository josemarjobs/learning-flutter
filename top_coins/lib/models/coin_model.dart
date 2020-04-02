import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  final String name;
  final String fullName;
  final double price;

  const Coin({
    this.name,
    this.fullName,
    this.price,
  });

  @override
  List<Object> get props => [name, fullName, price];
}
