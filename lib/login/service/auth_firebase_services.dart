import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthFirebaseService {
  final _auth = FirebaseAuth.instance;
  final _googleLogin = GoogleSignIn();

  signInWithGmail() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleLogin.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  signOut() async {
    await _auth.signOut();
    await _googleLogin.signOut();
  }
}
