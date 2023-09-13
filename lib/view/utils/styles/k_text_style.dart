import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'k_colors.dart';

/*
Focus: To maintain app wide design consistency all
the text style that are used in this app should be
declared here.

*Note: In special case: When let's say one title
text or textButton theme needsto be different,
say the color needs to be red instead of Black.
Don't create titleStyle1 (-_-). Just follow this:
Code Snippet:  (Applicable for all styles)
Text(segmentTitle,
style: AppTextStyle.titleStyle.copyWith(color: KColor.red)),
*/

class KTextStyle {
  static TextStyle headline1 = GoogleFonts.rubik(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: KColor.textColorBlack,
  );

  static TextStyle headline2 = GoogleFonts.rubik(
      fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: 0.15);

  static TextStyle headline3 = GoogleFonts.rubik(
      fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: 0.2);

  static TextStyle headline4 = GoogleFonts.rubik(
      fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 0.25);

  static TextStyle headline5 = GoogleFonts.rubik(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.3);

  static TextStyle headline6 = GoogleFonts.rubik(
      fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 0.35);

  static TextStyle subtitle1 = GoogleFonts.rubik(
      fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.35);

  static TextStyle subtitle2 = GoogleFonts.rubik(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.4);

  static TextStyle subtitle3 = GoogleFonts.rubik(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.45);

  static TextStyle subtitle4 = GoogleFonts.rubik(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.5);

  static TextStyle drawer = GoogleFonts.rubik(
      fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.1);

  static TextStyle bodyText1 = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 0.35);

  static TextStyle bodyText2 = GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.40);

  static TextStyle bodyText3 = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.45);

  static TextStyle bodyText4 = GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.5);

  static TextStyle buttonText1 = GoogleFonts.rubik(
      fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 0.3);

  static TextStyle buttonText2 = GoogleFonts.rubik(
      fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.4);

  static TextStyle buttonText3 = GoogleFonts.rubik(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.45);

  static TextStyle buttonText4 = GoogleFonts.rubik(
      fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5);

  static TextStyle caption = GoogleFonts.rubik(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4);

  static TextStyle overline = GoogleFonts.rubik(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 0.5);
}
