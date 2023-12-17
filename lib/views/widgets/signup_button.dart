import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpButton extends StatelessWidget {
  final String text;
  final IconData sideIcon;
  const SignUpButton({
    super.key,
    required this.text,
    required this.sideIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(126, 100, 237, 1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color.fromRGBO(126, 100, 237, 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 23),
                child: Icon(
                  sideIcon,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
