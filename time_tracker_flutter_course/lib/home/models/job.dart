import 'package:meta/meta.dart';

class Job {
  final String id;
  final String name;
  final int ratePerHour;

  Job({
    @required this.id,
    @required this.name,
    @required this.ratePerHour,
  })  : assert(name != null),
        assert(ratePerHour != null);

  factory Job.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    return Job(
      id: documentId,
      name: data['name'],
      ratePerHour: data['ratePerHour'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }
}
