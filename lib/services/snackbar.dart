import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnack(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: GoogleFonts.acme(),
      ),
    ),
  );
}
