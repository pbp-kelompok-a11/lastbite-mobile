import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../core/api_config.dart';
import '../screens/login_page.dart';

/// Helper autentikasi yang dipakai di beberapa tempat (drawer, auth gate).
class AuthService {
  AuthService._();

  /// Username user yang sedang login (dari respons login / me).
  static String username(CookieRequest request) {
    final value = request.jsonData['username'];
    return value is String && value.isNotEmpty ? value : 'Pengguna';
  }

  /// Logout ke Django, hapus sesi lokal, lalu kembali ke halaman login.
  static Future<void> logout(BuildContext context) async {
    // Ambil semua yang butuh context SEBELUM await.
    final request = context.read<CookieRequest>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    String message;
    try {
      final response = await request.logout(ApiConfig.logoutUrl);
      message = response['message']?.toString() ?? 'Logout berhasil!';
    } catch (_) {
      message = 'Server tidak bisa dihubungi, sesi di perangkat ini dihapus.';
    }

    await clearLocalSession(request);

    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  /// pbp_django_auth tidak menghapus cookie yang tersimpan di
  /// SharedPreferences saat logout, sehingga saat app dibuka lagi user
  /// dianggap masih login. Fungsi ini membersihkannya.
  static Future<void> clearLocalSession(CookieRequest request) async {
    await request.init();
    request.loggedIn = false;
    request.jsonData = {};
    request.cookies = {};
    request.headers.remove('cookie');
    await request.persist(jsonEncode({}));
  }
}
