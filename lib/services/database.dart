import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference projectsCollection =
      Firestore.instance.collection('projects');

  Future updateUserData(
      String nama, int pasir, int keramik, int batuBata, int semen) async {
    return await projectsCollection.document(uid).setData(
      {
        'nama': nama,
        'pasir': pasir,
        'keramik': keramik,
        'batuBata': batuBata,
        'semen': semen,
      },
    );
  }
}
