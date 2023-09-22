import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

const textStyle = GoogleFonts.archivo;
// const textStyle = TextStyle(fontFamily: "CabinetGrotesk");
final headingText = textStyle(fontSize: 32, fontWeight: FontWeight.w700);
final headingDesc = textStyle(fontSize: 18.0, fontWeight: FontWeight.w500);

final cashDecimalSplit = NumberFormat.decimalPattern('en_us');
