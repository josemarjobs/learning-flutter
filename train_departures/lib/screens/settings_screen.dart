import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traindepartures/blocs/septa_bloc.dart';
import 'package:traindepartures/providers/septa_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SeptaProvider>(context).bloc;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 16.0),
          _buildStationSelectOptions(context, bloc),
          SizedBox(height: 16.0),
          _buildDeparturesSelectOptions(context, bloc),
          SizedBox(height: 16.0),
          _buildDirectionsSelectOptions(context, bloc),
        ],
      ),
    );
  }

  Widget _buildDirectionsSelectOptions(BuildContext context, SeptaBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Directions'),
          SizedBox(height: 16.0),
          Container(
            width: double.infinity,
            child: Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: <Widget>[
                FilterChip(
                  label: Text(
                    'Northbound',
                    style: Theme.of(context).textTheme.body2,
                  ),
                  selected: true,
                  onSelected: (bool selected) => print(selected),
                ),
                FilterChip(
                  label: Text(
                    'Southbound',
                    style: Theme.of(context).textTheme.body2,
                  ),
                  selected: false,
                  onSelected: (bool selected) => print(selected),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeparturesSelectOptions(BuildContext context, SeptaBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: StreamBuilder<int>(
          stream: bloc.count,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Departures'),
                _buildDeparturesDropdown(context, snapshot.data, bloc),
              ],
            );
          }),
    );
  }

  Widget _buildDeparturesDropdown(
    BuildContext context,
    int count,
    SeptaBloc bloc,
  ) {
    return DropdownButton<int>(
      value: count,
      onChanged: (value) => bloc.changeCount(value),
      items: _buildDeparturesDropdownItems(context),
    );
  }

  List<DropdownMenuItem<int>> _buildDeparturesDropdownItems(context) {
    return <int>[4, 8, 10, 14, 18]
        .map(
          (v) => DropdownMenuItem<int>(
            value: v,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(v.toString()),
            ),
          ),
        )
        .toList();
  }

  Widget _buildStationSelectOptions(BuildContext context, SeptaBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: StreamBuilder<String>(
          stream: bloc.station,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Station'),
                _buildStationDropdown(context, snapshot.data, bloc),
              ],
            );
          }),
    );
  }

  Widget _buildStationDropdown(
      BuildContext context, String station, SeptaBloc bloc) {
    return DropdownButton<String>(
      value: station,
      onChanged: (value) => bloc.changeStation(value),
      items: _stationDropdownItems(context),
    );
  }

  List<DropdownMenuItem<String>> _stationDropdownItems(BuildContext context) {
    return [
      'Media',
      'Suburban Station',
      'Bala',
      '30th Street Station',
    ].map((s) => DropdownMenuItem(child: Text(s), value: s)).toList();
  }
}
