import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballers/bloc/player_listing_bloc.dart';
import 'package:footballers/bloc/player_listing_states.dart';
import 'package:footballers/models/api_models.dart';
import 'package:footballers/themes/themes.dart';
import 'package:footballers/widgets/message.dart';

class PlayerListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerListingBloc, PlayerListingState>(
      bloc: BlocProvider.of<PlayerListingBloc>(context),
      builder: (context, state) {
        if (state is PlayerUninitializedState) {
          return Message(message: 'Please select a country.');
        } else if (state is PlayerEmptyState) {
          return Message(message: 'No players found.');
        } else if (state is PlayerErrorState) {
          return Message(message: 'Error loading players.');
        } else if (state is PlayerFetchingState) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is PlayerFetchedState) {
          return buildPlayersList(state.players);
        }
        return Center(child: Text('Something went wrong...'));
      },
    );
  }

  Widget buildPlayersList(List<Players> players) {
    return Expanded(
      child: ListView.separated(
        itemCount: players.length,
        separatorBuilder: (context, index) => Divider(
          height: 16.0,
          color: Colors.transparent,
        ),
        itemBuilder: (BuildContext context, int index) {
          final player = players[index];
          return ListTile(
            leading: Image.network(player.headshot.imgUrl),
            title: Text(
              player.name,
              style: titleStyle,
            ),
            subtitle: Text(
              player.club.name,
              style: subTitleStyle,
            ),
          );
        },
      ),
    );
  }
}
