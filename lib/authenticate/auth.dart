import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/authenticate/user.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;


  USER? _userFromFirebaseUser(User user) {
    return user != null ? USER(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseuser = result.user;
      return _userFromFirebaseUser(firebaseuser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseuser = result.user;
      return _userFromFirebaseUser(firebaseuser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPass(String email) async {
    try {
      return await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }
}
