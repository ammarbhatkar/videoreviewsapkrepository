import 'package:Video_Review/views/widgets/sign_up_email.dart';
import 'package:Video_Review/views/widgets/signup_button.dart';
import 'package:Video_Review/views/widgets/uncoloured_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 251),
      body: SafeArea(
        child: Stack(children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 29.31, 32),
              child: Image.asset(
                'assets/images/background.png',
                //   height: 500,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 23,
            right: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "BugSmash",
                  style: GoogleFonts.openSans(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 3, 0, 0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Review Apps ",
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                          ),
                        ),
                        TextSpan(
                          text: "20x",
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        TextSpan(
                          text: " Faster!",
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 116, 0, 0),
                  child: Text(
                    "Let's get started",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 44),
                SignUpButton(
                  text: "Sign up via Google",
                  sideIcon: Icons.arrow_forward,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => SignUpEmail()));
                  },
                  child: UncolouredButton(
                    text: "Sign up via Email",
                    icon: Icons.arrow_forward,
                  ),
                ),
                SizedBox(height: 44),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                    TextSpan(
                      text: "Login here",
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
