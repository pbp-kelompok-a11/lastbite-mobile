import 'package:flutter/material.dart';

import '../modules/app_module.dart';

/// Helper navigasi supaya perilaku drawer dan menu Beranda konsisten:
/// Beranda selalu jadi halaman paling bawah, dan paling banyak ada
/// satu halaman modul di atasnya (tombol back selalu kembali ke Beranda).
class AppNavigator {
  AppNavigator._();

  static const String homeId = 'home';

  /// Buka halaman utama sebuah modul.
  static void openModule(NavigatorState navigator, AppModule module) {
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: module.pageBuilder,
        settings: RouteSettings(name: module.id),
      ),
      (route) => route.isFirst,
    );
  }

  /// Kembali ke Beranda.
  static void goHome(NavigatorState navigator) {
    navigator.popUntil((route) => route.isFirst);
  }
}
