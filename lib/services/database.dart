import 'package:bangunin_id/models/material_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/models/account_model.dart';

class DatabaseService {
  final String uid;
  final String docId;
  DatabaseService({this.uid, this.docId});

  Future writeData(
      String docId, String tableName, String attribute, String data) async {
    CollectionReference table =
        FirebaseFirestore.instance.collection(tableName);
    return await table
        .doc(docId)
        .set({attribute: data}, SetOptions(merge: true));
  }

  Future writeDoc(String tableName, Map<String, dynamic> data) async {
    String newDocId;

    CollectionReference table =
        FirebaseFirestore.instance.collection(tableName);
    //TODO: add condition to update material information

    (docId == null)
        ? await table.add(data).then((value) => newDocId = value.id)
        : await table.doc(docId).update(data);
    return newDocId;
  }

  Future deleteProjectData() async {
    await deleteMaterialsTarget();
    await deleteMaterialsProgress();
    DocumentReference table = FirebaseFirestore.instance
        .collection('accounts')
        .doc(uid)
        .collection('projects')
        .doc(docId);
    return await table.delete();
  }

  Future deleteMaterialsTarget() async {
    DocumentReference table = FirebaseFirestore.instance
        .collection('accounts')
        .doc(uid)
        .collection('projects')
        .doc(docId);
    table.collection('materials_target').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  Future deleteMaterialsProgress() async {
    DocumentReference table = FirebaseFirestore.instance
        .collection('accounts')
        .doc(uid)
        .collection('projects')
        .doc(docId);
    table.collection('materials_progress').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
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
        .doc(docId)
        .collection('materials_target')
        .snapshots()
        .map(_projectMateialsListFromSnapshot);
  }

  Stream<List<MaterialModel>> get projectMaterialsProgress {
    return FirebaseFirestore.instance
        .collection('accounts')
        .doc(uid)
        .collection('projects')
        .doc(docId)
        .collection('materials_progress')
        .snapshots()
        .map(_projectMateialsListFromSnapshot);
  }
}
