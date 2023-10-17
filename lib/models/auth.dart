import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User> registerEmailAndPassword(
      String email, String password, String displayName) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    result.user!.updateDisplayName(displayName);

    return result.user!;
  }

  static Future<void> singInEmailAndPassword(
      String email, String password) async {
    _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
