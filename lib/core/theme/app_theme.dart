import 'package:flutter/material.dart';

class AppTheme {
  // --- Colors ---
  static const Color primary = Color(0xFFEA477D);
  static const Color primaryLight = Color(0xFFEEBECE);
  static const Color textPrimary = Color(0xFF181113);
  static const Color textSecondary = Color(0xFF88636F);
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF4F0F2);
  static const Color border = Color(0xFFE5DCDF);

  // --- Text Styles ---
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    color: textPrimary,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5, // Corresponds to 'tracking-light'
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    color: textPrimary,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.015 * 22, // tracking-[-0.015em]
  );
  
  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    color: textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  
  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    color: textSecondary,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static final ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: background,
    fontFamily: 'Plus Jakarta Sans',
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      iconTheme: IconThemeData(color: textPrimary),
    ),
  );
}
