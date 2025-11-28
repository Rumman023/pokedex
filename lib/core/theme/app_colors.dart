import 'package:flutter/material.dart';

class AppColors {

  static const Color primary = Color(0xFFEF5350);
  static const Color primaryDark = Color(0xFFEE5A52);
  static const Color secondary = Color(0xFF42A5F5);
  static const Color accent = Color(0xFFFFE66D);


  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF1A1A2E);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF5F5F5);


  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFB2BEC3);

  // type colors for Pokémon types
  static const Map<String, Color> typeColors = {
    'normal': Color(0xFFA8A878),
    'fire': Color(0xFFF08030),
    'water': Color(0xFF6890F0),
    'electric': Color(0xFFF8D030),
    'grass': Color(0xFF78C850),
    'ice': Color(0xFF98D8D8),
    'fighting': Color(0xFFC03028),
    'poison': Color(0xFFA040A0),
    'ground': Color(0xFFE0C068),
    'flying': Color(0xFFA890F0),
    'psychic': Color(0xFFF85888),
    'bug': Color(0xFFA8B820),
    'rock': Color(0xFFB8A038),
    'ghost': Color(0xFF705898),
    'dragon': Color(0xFF7038F8),
    'dark': Color(0xFF705848),
    'steel': Color(0xFFB8B8D0),
    'fairy': Color(0xFFEE99AC),
  };


  static const LinearGradient primaryGradient = LinearGradient
  (
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D)],
  );

  static const LinearGradient cardGradient = LinearGradient
  (
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFF8F9FA)],
);
}
