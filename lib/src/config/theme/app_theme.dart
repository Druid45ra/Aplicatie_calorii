import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    const seed = Color(0xFF2E7D32);
<<<<<<< ours
<<<<<<< ours

=======
>>>>>>> theirs
=======
>>>>>>> theirs
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: seed),
      scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      appBarTheme: const AppBarTheme(centerTitle: false),
      inputDecorationTheme: InputDecorationTheme(
<<<<<<< ours
<<<<<<< ours
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
=======
=======
>>>>>>> theirs
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
      ),
    );
  }
}
