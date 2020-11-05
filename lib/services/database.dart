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

  Future updateAccountData(String attribute, String data) async {
    CollectionReference tabel =
        FirebaseFirestore.instance.collection('accounts');
    print(uid);
    print(attribute);
    print(data);
    return await tabel.doc(uid).update(
      {
        attribute: data,
      },
    );
  }

  Future writeProjectData(
      String projectName,
      String customerName,
      String customerEmail,
      String customerPhone,
      String supervisorName,
      String supervisorEmail,
      String supervisorPhone,
      DateTime dateCreated,
      String address,
      bool isCompleted) async {
    CollectionReference tabel =
        FirebaseFirestore.instance.collection('projects');
    return await tabel.doc(uid).set(
      {
        'projectName': projectName,
        'customerName': customerName,
        'customerEmail': customerEmail,
        'customerPhone': customerPhone,
        'supervisorName': supervisorName,
        'supervisorEmail': supervisorEmail,
        'supervisorPhone': supervisorPhone,
        'dateCreated': dateCreated,
        'address': address,
        'isCompleted': isCompleted,
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
