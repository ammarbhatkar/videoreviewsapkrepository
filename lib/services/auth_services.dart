import 'package:Video_Review/services/firestore_service.dart';
import 'package:Video_Review/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();
    final GoogleSignIn? googleSignIn = await GoogleSignIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleSignInAccount?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;

    if (result != null) {
      Map<String, dynamic> userInfoMap = {
        'email': userDetails!.email,
        "name": userDetails.displayName,
        "imgUrl": userDetails.photoURL,
        "id": userDetails.uid,
      };
      await FireStoreService().addUser(userDetails.uid, userInfoMap).then(
          (value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeView())));
    }

    // Once signed in, return the UserCredential
    // return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
