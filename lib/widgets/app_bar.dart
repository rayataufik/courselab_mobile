import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              style: GoogleFonts.manrope(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
              children: const <TextSpan>[
                TextSpan(text: "Courselab"),
                TextSpan(text: ".", style: TextStyle(color: Color(0xFF6366F1))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
