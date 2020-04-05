import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String _units;
  List<String> _waxLines = [];

  SettingsProvider() {
    loadPreferences();
  }

  String get units => _units;

  List<String> get waxLines => _waxLines;

  void setUnits(String units) {
    _units = units;
    _notifyAndSave();
  }

  bool containsWaxLine(String waxLine) => _waxLines.contains(waxLine);

  void toggleWaxLine(String waxLine) {
    if (containsWaxLine(waxLine)) {
      _waxLines.remove(waxLine);
    } else {
      _waxLines.add(waxLine);
    }
    _notifyAndSave();
  }

  void _setWaxLines(List<String> waxLines) {
    _waxLines = waxLines;
    _notifyAndSave();
  }

  void _notifyAndSave() {
    notifyListeners();
    savePreferences();
  }

  savePreferences() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('units', _units);
    prefs.setStringList('waxLines', _waxLines);
  }

  loadPreferences() async {
    var prefs = await SharedPreferences.getInstance();
    final String units = prefs.getString('units');
    final List<String> waxLines = prefs.getStringList('waxLines');

    if (units != null) setUnits(units);
    if (waxLines != null) _setWaxLines(waxLines);
  }
}
