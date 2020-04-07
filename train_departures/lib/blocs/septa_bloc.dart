import 'package:rxdart/rxdart.dart';
import 'package:traindepartures/models/train.dart';
import 'package:traindepartures/services/septa_service.dart';

class SeptaBloc {
  final _trains = BehaviorSubject<List<Train>>();
  final _station = BehaviorSubject<String>();
  final _count = BehaviorSubject<int>();
  final _directions = BehaviorSubject<List<String>>();

  final SeptaService service = SeptaService();

  SeptaBloc() {
    loadSettings();

    // listeners
    station.listen((station) async {
      changeTrain(await service.loadStationData(station));
    });
  }

  Stream<List<Train>> get trains => _trains.stream;

  Function(List<Train>) get changeTrain => _trains.sink.add;

  Stream<int> get count => _count;

  Function(int) get changeCount => _count.sink.add;

  Stream<String> get station => _station;

  Function(String) get changeStation => _station.sink.add;

  Stream<List<String>> get directions => _directions;

  Function(List<String>) get changeDirections => _directions.sink.add;

  void dispose() {
    _trains.close();
    _count.close();
    _station.close();
    _directions.close();
  }

  loadSettings() {
    changeCount(10);
    changeDirections(['N', 'S']);
    changeStation('Suburban Station');
  }
}
