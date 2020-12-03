import 'package:bangunin_id/models/material_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/models/account_model.dart';

class DatabaseService {
  final String uid;
  final String projectId;
  DatabaseService({this.uid, this.projectId});

  Future writeData(String tableName, String attribute, String data) async {
    CollectionReference table =
        FirebaseFirestore.instance.collection(tableName);
    return await table.doc(uid).set({attribute: data}, SetOptions(merge: true));
  }

  Future createProjectData(Map<String, dynamic> data) async {
    String docId;
    await FirebaseFirestore.instance
        .collection('accounts')
        .doc(uid)
        .collection('projects')
        .add(data)
        .then((value) => docId = value.id);
    return docId;
  }

  Future createProjectMaterialsData(
      String tableName, Map<String, dynamic> data) async {
    String docId;
    await FirebaseFirestore.instance
        .collection('accounts')
        .doc(uid)
        .collection('projects')
        .doc(projectId)
        .collection(tableName)
        .add(data)
        .then((value) => docId = value.id);
    return docId;
  }

  Future deleteProjectData() async {
    DocumentReference table = FirebaseFirestore.instance
        .collection('accounts')
        .doc(uid)
        .collection('projects')
        .doc(projectId);

    table.collection('materials_target').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    table.collection('materials_progress').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    return await table.delete();
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
        accountId: doc.id,
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
        projectId: doc.id,
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

  List<MaterialModel> _projectMateialsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MaterialModel(
        materialId: doc.id,
        name: doc.data()['name'] ?? '',
        size: doc.data()['size'] ?? '',
        type: doc.data()['type'] ?? '',
        unit: doc.data()['unit'] ?? '',
        price: doc.data()['price'] ?? 0,
        amount: doc.data()['amount'] ?? 0,
        image: doc.data()['image'] ?? '',
      );
    }).toList();
  }

  Stream<List<MaterialModel>> get projectMaterialsTarget {
    return FirebaseFirestore.instance
        .collection('accounts')
        .doc(uid)
        .collection('projects')
        .doc(projectId)
        .collection('materials_target')
        .snapshots()
        .map(_projectMateialsListFromSnapshot);
  }

  Stream<List<MaterialModel>> get projectMaterialsProgress {
    return FirebaseFirestore.instance
        .collection('accounts')
        .doc(uid)
        .collection('projects')
        .doc(projectId)
        .collection('materials_progress')
        .snapshots()
        .map(_projectMateialsListFromSnapshot);
  }
}
