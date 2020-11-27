import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/models/account_model.dart';

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
    String supervisorID,
    String projectName,
    String address,
    String addressGMap,
    String clientName,
    String clientEmail,
    String clientPhone,
    DateTime dateCreated,
    DateTime dateDeadline,
    bool isCompleted,
  ) async {
    CollectionReference tabel =
        FirebaseFirestore.instance.collection('projects');
    return await tabel.doc().set(
      {
        'supervisorID': supervisorID,
        'projectName': projectName,
        'address': address,
        'addressGMap': addressGMap,
        'clientName': clientName,
        'clientEmail': clientEmail,
        'clientPhone': clientPhone,
        'dateCreated': dateCreated,
        'dateDeadline': dateDeadline,
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

  List<ProjectDetailsModel> _projectDetailsListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ProjectDetailsModel(
        supervisorID: doc.data()['supervisorID'] ?? '',
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

  Stream<List<ProjectDetailsModel>> get projects {
    return FirebaseFirestore.instance
        .collection('projects')
        .snapshots()
        .map(_projectDetailsListFromSnapshot);
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
}
