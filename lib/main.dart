import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'auth/auth_gate.dart';
import 'core/app_theme.dart';

void main() {
  runApp(const LastBiteApp());
}

class LastBiteApp extends StatelessWidget {
  const LastBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Satu CookieRequest dipakai bersama oleh semua halaman
    // (menyimpan cookie sesi Django setelah login).
    return Provider<CookieRequest>(
      create: (_) => CookieRequest(),
      child: MaterialApp(
        title: 'LastBite',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const AuthGate(),
      ),
    );
  }
}
