// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({
    Key? key,
    required this.hintText,
  }) : super(key: key);
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 24, 0),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(126, 100, 237, 1)),
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(126, 100, 237,
                        1)), // Set the border color when the TextField is not in focus
                borderRadius: BorderRadius.circular(5),
              ),
              labelText: hintText,
              labelStyle: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(126, 100, 237, 0.5),
              ),
              fillColor: Color.fromARGB(255, 255, 255,
                  251), // Set the background color of the TextField
              filled: true),
        ),
      ),
    );
  }
}
