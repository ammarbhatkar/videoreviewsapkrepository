import 'package:Video_Review/views/widgets/form_label.dart';
import 'package:Video_Review/views/widgets/signup_button.dart';
import 'package:Video_Review/views/widgets/start_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({super.key});

  @override
  State<SignUpEmail> createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 251),
      body: SafeArea(
        child: Stack(children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 24, 24.5),
              child: Image.asset('assets/images/background.png'),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
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
                    "Sign up via Email",
                    style: GoogleFonts.openSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 44),
                FormLabel(hintText: "First Name"),
                SizedBox(height: 24),
                FormLabel(hintText: "Last Name"),
                SizedBox(height: 24),
                FormLabel(hintText: "Email"),
                SizedBox(height: 24),
                FormLabel(hintText: "Password"),
                SizedBox(height: 44),
                Padding(
                  padding: const EdgeInsets.only(left: 21),
                  child: SignUpButton(
                      text: "Send Confirmation Code",
                      sideIcon: Icons.arrow_forward),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
