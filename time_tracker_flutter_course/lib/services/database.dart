import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:timetrackerfluttercourse/home/jobs/jobs_page.dart';
import 'package:timetrackerfluttercourse/home/models/job.dart';
import 'package:timetrackerfluttercourse/services/api_path.dart';
import 'package:timetrackerfluttercourse/services/firestore_service.dart';

abstract class Database {
//  Future<void> setJob(Job job);
//
//  Future<void> deleteJob(Job job);
//
//  Future<void> setEntry(Entry entry);
//
//  Future<void> deleteEntry(Entry entry);
//
//  Stream<List<Job>> getJobs();
  Future<void> setJob(Job job);

  Future<void> deleteJob(Job job);

  Stream<List<Job>> jobsStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;
  final _service = FirestoreService.instance;

  @override
  Future<void> setJob(Job job) async => await _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );

  @override
  Future<void> deleteJob(Job job) async =>
      await _service.deleteData(path: APIPath.job(uid, job.id));

  @override
  Stream<List<Job>> jobsStream() {
    return _service.collectionStream(
      path: APIPath.jobs(uid),
      builder: (data, docId) => Job.fromMap(data, docId),
    );
  }
}
