import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

String name = "";
String email = "";
String photoUrl = "";
String idToken = "";
String accessToken = "";

GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;

Future<String> googleLogin() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
    );

    final UserCredential userCredential = await auth.signInWithCredential(authCredential);
    final User user = userCredential.user;

    if (user != null) {
      // Checking if email and name is null
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      name = user.displayName;
      email = user.email;
      photoUrl = user.photoURL;

      // Only taking the first part of the name, i.e., First Name
      if (name.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));
      }

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }
  // });
  return null;
}

Future<void> signOutGoogle() async {
  await _googleSignIn.signOut();

  print("User Signed Out");
}

