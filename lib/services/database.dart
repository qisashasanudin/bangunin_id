import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  CollectionReference tabel;

  Future writeAccountData(String email, String name, bool isSupervisor) async {
    tabel = Firestore.instance.collection('accounts');
    return await tabel.document(uid).setData(
      {
        'email': email,
        'name': name,
        'is_supervisor': isSupervisor,
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
    tabel = Firestore.instance.collection('projects');
    return await tabel.document(uid).setData(
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
    return Firestore.instance.collection(tablename).document(uid).snapshots();
  }
}
