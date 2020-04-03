import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    print('$path: $data');

    final reference = Firestore.instance.document(path);
    await reference.setData(data);
  }

  Future<void> deleteData({@required String path}) async {
    final reference = Firestore.instance.document(path);
    print('deleting: $path');
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentId),
    String documentId,
  }) {
    final CollectionReference reference = Firestore.instance.collection(path);
    final Stream<QuerySnapshot> snapshots = reference.snapshots();
    return snapshots.map((querySnapshot) => querySnapshot.documents
        .map((docSnapshot) => builder(docSnapshot.data, docSnapshot.documentID))
        .toList());
  }
}
