import 'package:flutter/material.dart';

/// Tema aplikasi. Ganti [seedColor] supaya warnanya sama dengan website,
/// seluruh warna Material 3 akan menyesuaikan otomatis.
class AppTheme {
  AppTheme._();

  // TODO(kelompok): samakan dengan warna utama website LastBite.
  static const Color seedColor = Color(0xFF2E7D32);

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(seedColor: seedColor);
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
    );
  }

  /// Dekorasi input yang seragam untuk semua form.
  static InputDecoration input({
    required String label,
    IconData? icon,
    String? hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
