import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waxapp/models/report.dart';

class FirestoreService {
  final Firestore _db = Firestore.instance;

  Stream<List<Report>> getReports() {
    return _db
        .collection('reports')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.documents
              .map((doc) => Report.fromJson(doc.data))
              .toList(),
        );
  }

  Future<void> addReport() {
    final dataMap = Map<String, dynamic>();
    int temp = next(-15, 5);
    dataMap['temp'] = temp.toString();
    dataMap['wax'] = temp.isEven ? 'Red': 'Green';
    dataMap['line'] = temp < -5 ? 'Swix': 'Toko';
    dataMap['timeStamp'] = DateTime.now().toIso8601String();

    return _db.collection('reports').add(dataMap);
  }

  int next(int min, int max) => min + Random().nextInt(max - min);
}
