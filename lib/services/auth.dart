import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_box/model/custom_user.dart';
import 'package:quiz_box/services/database.dart';


String uid='';

class AuthService{

  String name='';
  String email='';
  String imageUrl='';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();


  CustomUser _userFromFirebaseUser(User user){
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  //auth change user stream of data changes
  Stream<CustomUser> get user{
    return _auth.onAuthStateChanged
        .map((User user) => _userFromFirebaseUser(user));
  }

  // email validation and Regex
  //todo
  // google
  Future<String> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      // Store the retrieved data
      uid = user.uid;
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoURL;
      String phoneNo=user.phoneNumber;

      await DatabaseService().updateTeacherData(name, phoneNo, imageUrl, null, null);
      await DatabaseService().updateUserData(name, phoneNo, imageUrl, null, null, null);
      // Only taking the first part of the name, i.e., First Name
      if (name.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));
      }
      print('signInWithGoogle succeeded: $user');
      return '$user';
    }
    return null;
  }


//to signout
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    print("User Signed Out");
  }


}