import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UncolouredButton extends StatelessWidget {
  const UncolouredButton({super.key, required this.text, this.icon});

  final String text;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 22, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
                  color: Color.fromRGBO(126, 100, 237, 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(
                  icon,
                  size: 20,
                  color: Color.fromRGBO(126, 100, 237, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
