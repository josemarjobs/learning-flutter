import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:topcoins/models/coin_model.dart';
import 'package:topcoins/repositories/crypto_repository.dart';
import 'package:meta/meta.dart';

part 'crypto_event.dart';

part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository _cryptoRepository;

  CryptoBloc({@required cryptoRepository})
      : assert(cryptoRepository != null),
        _cryptoRepository = cryptoRepository;

  @override
  CryptoState get initialState => CryptoEmpty();

  @override
  Stream<CryptoState> mapEventToState(CryptoEvent event) async* {
    print('New event: $event');

    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is RefreshCoins) {
      yield* _getCoins(coins: []);
    } else if (event is LoadMoreCoins) {
      yield* _mapLoadMoreCoinsToState(event);
    }
  }

  Stream<CryptoState> _mapAppStartedToState(AppStarted event) async* {
    yield CryptoLoading();
    yield* _getCoins(coins: []);
  }

  Stream<CryptoState> _getCoins({List<Coin> coins, int page = 0}) async* {
    try {
      List<Coin> newCoinsList = coins +
          await _cryptoRepository.getTopCoins(
            page: page,
          );
      yield CryptoLoaded(coins: newCoinsList);
    } catch (e) {
      yield CryptoError();
    }
  }

  Stream<CryptoState> _mapLoadMoreCoinsToState(LoadMoreCoins event) async* {
    final int nextPage = event.coins.length ~/ CryptoRepository.perPage;
    yield* _getCoins(coins: event.coins, page: nextPage);
  }
}
