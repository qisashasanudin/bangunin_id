import 'package:firebase_auth/firebase_auth.dart';
import 'package:bangunin_id/services/database.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  //get UID
  String getCurrentUID() {
    authStateChanges;
    return _firebaseAuth.currentUser.uid.toString();
  }

  //register with email & password
  Future signUpWithEmail(String email, String name, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await DatabaseService(uid: getCurrentUID())
          .writeAccountData(email, name, 'Konsumen');
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }

  //sign in with email & password
  Future signInWithEmail(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
          print(getCurrentUID());
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
