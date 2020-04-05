import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waxapp/models/report.dart';
import 'package:waxapp/providers/settings_provider.dart';
import 'package:waxapp/screens/settings_screen.dart';
import 'package:date_format/date_format.dart';
import 'package:waxapp/services/firestore_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wax'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirestoreService().addReport();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    final reports = Provider.of<List<Report>>(context)
        .where((report) => settings.containsWaxLine(report.line))
        .toList();

    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (BuildContext context, int index) {
        final r = reports[index];
        return ListTile(
          leading: getTemp(r, settings.units),
          title: Text(r.wax),
          subtitle: Text(r.line),
          trailing: Text(
            formatDate(
              DateTime.parse(r.timeStamp),
              [h, ':', mm, ' ', am],
            ),
          ),
        );
      },
    );
  }

  Text getTemp(Report r, String units) {
    if (units == 'Metric') {
      return Text('${r.temp.toString()}\u00B0C');
    }
    return Text('${(32 + (r.temp * (9 / 5))).round()}\u00B0F');
  }
}
