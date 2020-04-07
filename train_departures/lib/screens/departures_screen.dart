import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traindepartures/models/train.dart';
import 'package:traindepartures/providers/septa_provider.dart';
import 'package:traindepartures/screens/settings_screen.dart';

class DeparturesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SeptaProvider>(context).bloc;

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
            stream: bloc.station,
            builder: (context, snapshot) {
              return Text(
                snapshot.hasData ? snapshot.data : 'Departures',
                style: Theme.of(context).textTheme.title,
              );
            }),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<List<Train>>(
        stream: bloc.trains,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something went wrong.',
                style: TextStyle(fontSize: 30.0),
              ),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: snapshot.data.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _buildHeader(context);
              }
              return _buildDepartureItem(
                context,
                snapshot.data[index - 1],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Departures',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text('Time', style: Theme.of(context).textTheme.body2),
                flex: 1,
              ),
              Expanded(
                child: Text(
                  'Destination',
                  style: Theme.of(context).textTheme.body2,
                ),
                flex: 4,
              ),
              Expanded(
                child: Text('Track', style: Theme.of(context).textTheme.body2),
                flex: 1,
              ),
              Expanded(
                child: Text('Status', style: Theme.of(context).textTheme.body2),
                flex: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDepartureItem(BuildContext context, Train train) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 20.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              formatDate(train.departTime, [hh, ':', nn]),
              style: Theme.of(context).textTheme.body1,
            ),
            flex: 1,
          ),
          Expanded(
            child: Text(
              train.destination,
              style: Theme.of(context).textTheme.body1,
              overflow: TextOverflow.ellipsis,
            ),
            flex: 3,
          ),
          Expanded(
            child:
                Text(train.track, style: Theme.of(context).textTheme.body1),
            flex: 1,
          ),
          Expanded(
            child:
                Text(train.status, style: Theme.of(context).textTheme.body1),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
