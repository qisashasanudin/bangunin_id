import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/models/account_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  Future writeData(String table, String attribute, String data) async {
    CollectionReference tabel = FirebaseFirestore.instance.collection(table);
    return await tabel.doc(uid).set({attribute: data}, SetOptions(merge: true));
  }

  Future createDataOnSubcollection(String table, String subtable, data) async {
    CollectionReference tabel = FirebaseFirestore.instance
        .collection(table)
        .doc(uid)
        .collection(subtable);
    return await tabel.add(data);
  }

  Stream entityDocumentSnapshot(String tablename) {
    return FirebaseFirestore.instance
        .collection(tablename)
        .doc(uid)
        .snapshots();
  }

  List<AccountModel> _accountListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AccountModel(
        address: doc.data()['address'] ?? '',
        email: doc.data()['email'] ?? '',
        name: doc.data()['name'] ?? '',
        phone: doc.data()['phone'] ?? '',
        profilePicture: doc.data()['profilePicture'] ?? '',
        role: doc.data()['role'] ?? '',
      );
    }).toList();
  }

  Stream<List<AccountModel>> get accounts {
    return FirebaseFirestore.instance
        .collection('accounts')
        .snapshots()
        .map(_accountListFromSnapshot);
  }

  List<ProjectDetailsModel> _projectDetailsListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ProjectDetailsModel(
        projectName: doc.data()['projectName'] ?? '',
        address: doc.data()['address'] ?? '',
        addressGMap: doc.data()['addressGMap'] ?? '',
        clientName: doc.data()['clientName'] ?? '',
        clientEmail: doc.data()['clientEmail'] ?? '',
        clientPhone: doc.data()['clientPhone'] ?? '',
        dateCreated: doc.data()['dateCreated'].toDate() ?? '',
        dateDeadline: doc.data()['dateDeadline'].toDate() ?? '',
        isCompleted: doc.data()['isCompleted'] ?? false,
      );
    }).toList();
  }

  Stream<List<ProjectDetailsModel>> get myProjects {
    return FirebaseFirestore.instance
        .collection('accounts')
        .doc(uid)
        .collection('projects')
        .snapshots()
        .map(_projectDetailsListFromSnapshot);
  }
}
