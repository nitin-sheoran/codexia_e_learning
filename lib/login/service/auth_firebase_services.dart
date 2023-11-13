import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthFirebaseService {
  final auth = FirebaseAuth.instance;
  final googleLogin = GoogleSignIn();

  signInWithGmail() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await googleLogin.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential authCre = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await auth.signInWithCredential(authCre);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  logOut() async {
    await auth.signOut();
    await googleLogin.signOut();
  }
}