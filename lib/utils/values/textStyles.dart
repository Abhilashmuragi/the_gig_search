import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  //The naming convention used here is:- style-fontSize-width
  static TextStyle poppins12Normal({Color? color}) =>
      GoogleFonts.poppins().copyWith(fontSize: 12, fontWeight: FontWeight.normal, color: color);

  static TextStyle poppins14Normal({Color? color}) =>
      GoogleFonts.poppins().copyWith(fontSize: 14, fontWeight: FontWeight.normal, color: color);

  static TextStyle poppins28Normal({Color? color}) =>
      GoogleFonts.poppins().copyWith(fontSize: 28, fontWeight: FontWeight.normal, color: color);

  static TextStyle poppins14w500({Color? color}) => GoogleFonts.poppins().copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: color);

  static TextStyle poppins30w700({Color? color}) => GoogleFonts.poppins().copyWith(fontSize: 30, fontWeight: FontWeight.w700, color: color);
  static TextStyle poppins16w500({Color? color}) => GoogleFonts.poppins().copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: color);
  static TextStyle poppins18Normal({Color? color}) => GoogleFonts.poppins().copyWith(fontSize: 18, fontWeight: FontWeight.w700, color:
  color);

}
