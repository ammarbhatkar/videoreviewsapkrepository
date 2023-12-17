// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:Video_Review/main_page.dart';
import 'package:Video_Review/services/auth_services.dart';
import 'package:Video_Review/utilities/diaogs/generic_dialog.dart';
import 'package:Video_Review/views/home_view.dart';
import 'package:Video_Review/views/widgets/form_label.dart';
import 'package:Video_Review/views/widgets/signup_button.dart';
import 'package:Video_Review/views/widgets/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 251),
      body: _user == null ? _userInfo() : _navigateToHomeView(context),
    );
  }

  _navigateToHomeView(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    });
  }

  Widget _userInfo() {
    return SafeArea(
      child: Stack(children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 29.31, 32),
            child: Image.asset('assets/images/background.png'),
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 16, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => StartPage()));
                      },
                      child: Icon(
                        Icons.arrow_back_sharp,
                        size: 20,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
                    child: Text(
                      "Back to Get Started",
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(21, 40, 0, 0),
                child: Text(
                  "Login...",
                  style: GoogleFonts.openSans(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 44),
              FormLabel(hintText: "Email"),
              SizedBox(height: 24),
              FormLabel(hintText: "Password"),
              SizedBox(height: 44),
              Padding(
                padding: const EdgeInsets.only(left: 21),
                child: SignUpButton(
                    text: "Sign in", sideIcon: Icons.arrow_forward),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.fromLTRB(21, 0, 0, 0),
                child: Text(
                  "Or",
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(left: 21),
                child: GestureDetector(
                  onTap: () {
                    GenericDialog.showLoadingDialog(context, "");
                    // signInWithGoogle();
                    AuthMethods().signInWithGoogle(context);
                    GenericDialog.hideDialog(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 12, 12, 12),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset("assets/icon/google.png", height: 20),
                              SizedBox(width: 20),
                              Text(
                                "Sign in with google",
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(78, 76, 76, 1),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 23),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  // void _handleGoogleSignin() {
  //   try {
  //     GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
  //     _auth.signInWithProvider(_googleAuthProvider);
  //   } catch (e) {
  //    // print(e);
  //   }
  // }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
