import 'package:bloc/bloc.dart';
import 'package:footballers/bloc/player_listing_events.dart';
import 'package:footballers/bloc/player_listing_states.dart';
import 'package:footballers/services/repository.dart';

class PlayerListingBloc extends Bloc<PlayerListingEvent, PlayerListingState> {
  final PlayerRepository playerRepository;

  PlayerListingBloc({this.playerRepository}) : assert(playerRepository != null);

  @override
  PlayerListingState get initialState => PlayerUninitializedState();

  Stream<PlayerListingState> _mapCountrySelectedToState(
    CountrySelectedEvent event,
  ) async* {
    yield PlayerFetchingState();
    try {
      final players = await playerRepository.fetchPlayersByCountry(
        event.nationModel.countryId,
      );
      if (players.length == 0) {
        yield PlayerEmptyState();
      } else {
        yield PlayerFetchedState(players: players);
      }
    } catch (_) {
      yield PlayerErrorState();
    }
  }

  @override
  Stream<PlayerListingState> mapEventToState(PlayerListingEvent event) async* {
    if (event is CountrySelectedEvent) {
      print('New event: $event');
      yield* _mapCountrySelectedToState(event);
    }
  }
}
