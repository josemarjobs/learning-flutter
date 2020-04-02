part of 'crypto_bloc.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AppStarted extends CryptoEvent {}

class RefreshCoins extends CryptoEvent {}

class LoadMoreCoins extends CryptoEvent {
  final List<Coin> coins;

  LoadMoreCoins({this.coins});

  @override
  List<Object> get props => [coins];

  @override
  String toString() => 'LoadMoreCoins { coins: $coins }';
}
