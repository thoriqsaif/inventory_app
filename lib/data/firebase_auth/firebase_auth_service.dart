import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final firebaseAuth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  // final clientId =
  //     "951221634637-psjou82vbf7lbb49qdj4222bjkbeu0ci.apps.googleusercontent.com";
  // final serverClientId =
  //     '951221634637-k06b51tb5cur1spq6a2fsq52hqg2u77a.apps.googleusercontent.com';

  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //   Future<UserCredential?> signInWithGoogle() async {
  //     // Trigger the authentication flow
  //     unawaited(googleSignIn.initialize(
  //         clientId: clientId, serverClientId: serverClientId));

  //     final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication googleAuth = googleUser.authentication;

  //     // Create a new credential
  //     final OAuthCredential credential = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken,
  //     );

  //     // Once signed in, return the UserCredential
  //     return await firebaseAuth.signInWithCredential(credential);
  //   }

  //   Stream<User?> checkUserSignInState() {
  //     final state = firebaseAuth.authStateChanges();
  //     return state;
  //   }

  //   signOutWithGoogle() {
  //     googleSignIn.signOut();
  //     firebaseAuth.signOut();
  //   }
}
