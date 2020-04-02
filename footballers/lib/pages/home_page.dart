import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballers/bloc/player_listing_bloc.dart';
import 'package:footballers/pages/player_listing_page.dart';
import 'package:footballers/services/repository.dart';
import 'package:footballers/themes/themes.dart';
import 'package:footballers/widgets/horizontal_bar.dart';

class HomePage extends StatefulWidget {
  final PlayerRepository playerRepository;

  HomePage({@required this.playerRepository})
      : assert(playerRepository != null);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlayerListingBloc _playerListingBloc;

  @override
  void initState() {
    super.initState();
    _playerListingBloc = PlayerListingBloc(
      playerRepository: widget.playerRepository,
    );
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerListingBloc>(
      create: (context) => _playerListingBloc,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('Football Players', style: appBarTextStyle),
        ),
        backgroundColor: Colors.grey.shade50,
        body: Column(
          children: <Widget>[
            HorizontalBar(),
            SizedBox(height: 16.0),
            PlayerListingPage(),
          ],
        ),
      ),
    );
  }
}
