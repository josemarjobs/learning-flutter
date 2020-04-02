import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballers/bloc/player_listing_bloc.dart';
import 'package:footballers/bloc/player_listing_events.dart';
import 'package:footballers/models/nation.dart';

class HorizontalBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView.separated(
        separatorBuilder: buildSeparator,
        itemCount: nations.length,
        itemBuilder: buildItem,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        BlocProvider.of<PlayerListingBloc>(context).add(
          CountrySelectedEvent(nationModel: nations[index]),
        );
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(nations[index].imagePath),
          ),
        ),
      ),
    );
  }

  Widget buildSeparator(context, index) {
    return VerticalDivider(
      width: 8.0,
      color: Colors.transparent,
    );
  }
}
