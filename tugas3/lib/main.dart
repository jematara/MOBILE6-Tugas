import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas3/bmicalc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final base = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator BMI',
      theme: base.copyWith(
        textTheme: GoogleFonts.montserratTextTheme(base.textTheme),
        primaryTextTheme: GoogleFonts.montserratTextTheme(base.primaryTextTheme),
      ),
      home: BMIScreen(),
    );
  }
}
