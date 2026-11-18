import 'package:flutter/material.dart';

import '../modules/app_module.dart';
import '../modules/module_placeholder_page.dart';

/// Helper navigasi supaya perilaku drawer dan menu Beranda konsisten:
/// Beranda selalu jadi halaman paling bawah, dan paling banyak ada
/// satu halaman modul di atasnya (tombol back selalu kembali ke Beranda).
class AppNavigator {
  AppNavigator._();

  static const String homeId = 'home';

  static Widget pageFor(AppModule module, BuildContext context) {
    return module.pageBuilder?.call(context) ??
        ModulePlaceholderPage(module: module);
  }

  /// Buka halaman utama sebuah modul.
  static void openModule(NavigatorState navigator, AppModule module) {
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => pageFor(module, context),
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
