import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  Future writeAccountData(String email, String name, String role) async {
    CollectionReference tabel =
        FirebaseFirestore.instance.collection('accounts');
    return await tabel.doc(uid).set(
      {
        'email': email,
        'name': name,
        'role': role,
      },
    );
  }

  Future writeProjectData(
    String projectName,
    String address,
    String clientName,
    String clientEmail,
    String clientPhone,
    String supervisorName,
    String supervisorEmail,
    String supervisorPhone,
    DateTime dateCreated,
    DateTime dateDeadline,
    bool isCompleted,
  ) async {
    CollectionReference tabel =
        FirebaseFirestore.instance.collection('projects');
    return await tabel.doc(uid).set(
      {
        'projectName': projectName,
        'address': address,
        'customerName': clientName,
        'customerEmail': clientEmail,
        'customerPhone': clientPhone,
        'supervisorName': supervisorName,
        'supervisorEmail': supervisorEmail,
        'supervisorPhone': supervisorPhone,
        'dateCreated': dateCreated,
        'isCompleted': isCompleted,
      },
    );
  }

  Future updateData(String table, String attribute, String data) async {
    CollectionReference tabel = FirebaseFirestore.instance.collection(table);
    return await tabel.doc(uid).update(
      {
        attribute: data,
      },
    );
  }

  Stream entitySnapshot(String tablename) {
    return FirebaseFirestore.instance
        .collection(tablename)
        .doc(uid)
        .snapshots();
  }
}
