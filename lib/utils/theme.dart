import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primary = Color(0XFF1FD078);

const Color primaryDark = Color(0XFF161d21);

const Color accent = Color(0xFF51fa8f);

const Color altBg = Color(0xFFF3F5F9);

const Color darkGrey = Color(0xff0b0c0c);

const Color textColor = Color(0xFF2F3258);

const Color white = Colors.white;

const Color black = Colors.black;

const Color grey = Colors.grey;

themeData(context) => ThemeData(
      textTheme: GoogleFonts.notoSansTextTheme(
        Theme.of(context).textTheme,
      ),
      primarySwatch: Colors.green,
      primaryColor: primary,
      primaryColorDark: primaryDark,
      backgroundColor: white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
