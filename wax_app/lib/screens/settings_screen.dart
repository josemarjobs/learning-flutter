import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waxapp/providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final SettingsProvider provider = Provider.of<SettingsProvider>(context);
    return Column(
      children: <Widget>[
        _buildUnitsSetting(provider),
        SizedBox(height: 16.0),
        _buildWaxLinesSetting(provider),
      ],
    );
  }

  Widget _buildUnitsSetting(SettingsProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Units'),
        DropdownButton<String>(
          value: provider.units,
          onChanged: (value) => provider.setUnits(value),
          items: _unitsDropDownItems(),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> _unitsDropDownItems() {
    return ['Imperial', 'Metric']
        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
        .toList();
  }

  Widget _buildWaxLinesSetting(SettingsProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Wax Line'),
        Container(
          child: Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: <Widget>[
              FilterChip(
                label: Text(
                  'Swix',
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
                selected: provider.containsWaxLine('Swix'),
                onSelected: (bool value) => provider.toggleWaxLine('Swix'),
              ),
              FilterChip(
                selected: provider.containsWaxLine('Toko'),
                label: Text(
                  'Toko',
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
                onSelected: (bool value) => provider.toggleWaxLine('Toko'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
