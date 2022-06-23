import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
const String API_KEY = 'd76fd13c6f25e196c5a396255996fded';
// colors
const Color kRichBlack = Color(0xFF000814);
const Color kOxfordBlue = Color(0xFF001D3D);
const Color kPrussianBlue = Color(0xFF003566);

const Color kYellow = Color(0xFFFFD928);
const Color kYellowDark = Color(0xFFFFD301);
const Color kExoticBlack = Color(0xFF333333);
const Color kPrimereBlack = Color(0xFF3F3F3F);
const Color kPastelPeach = Color(0xFFF76172);
const Color kPastelRed = Color(0xFFDD2B2E);

// text style
final TextStyle kHeading5 =
    GoogleFonts.roboto(fontSize: 23, fontWeight: FontWeight.w400);
final TextStyle kHeading6 = GoogleFonts.roboto(
    fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
final TextStyle kSubtitle = GoogleFonts.roboto(
    fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25);
final TextStyle kBodyText = GoogleFonts.roboto(
    fontSize: 13, fontWeight: FontWeight.w300, letterSpacing: 0.25);
final TextStyle kBodyTextSmall = GoogleFonts.roboto(
    fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.25);
final TextStyle kTitlesmall = GoogleFonts.roboto(
    fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.25);

final TextStyle kHeading3 = GoogleFonts.roboto(
    fontSize: 16,
    letterSpacing: 0.25,
    fontWeight: FontWeight.w800,
    color: Colors.white);

final kSubtitle2 = GoogleFonts.roboto(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    letterSpacing: 0.25);

// text theme
final kTextTheme = TextTheme(
  headline5: kHeading5,
  headline6: kHeading6,
  headline3: kHeading3,
  subtitle1: kSubtitle,
  subtitle2: kSubtitle2,
  bodyText2: kBodyText,
);

const kColorScheme = ColorScheme(
  primary: kYellow,
  primaryContainer: kYellow,
  secondary: kYellowDark,
  secondaryContainer: kYellowDark,
  surface: kRichBlack,
  background: Colors.white,
  error: kPastelRed,
  onPrimary: kRichBlack,
  onSecondary: kExoticBlack,
  onSurface: kExoticBlack,
  onBackground: kExoticBlack,
  onError: kExoticBlack,
  brightness: Brightness.light,
);

