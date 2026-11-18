import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../core/api_config.dart';
import '../home/home_page.dart';
import 'auth_service.dart';
import 'screens/login_page.dart';

/// Halaman pertama saat app dibuka.
/// Kalau masih ada sesi tersimpan dan server bilang sesi itu valid,
/// langsung ke Beranda. Kalau tidak, ke halaman login.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final Future<bool> _sessionFuture;

  @override
  void initState() {
    super.initState();
    _sessionFuture = _restoreSession(context.read<CookieRequest>());
  }

  Future<bool> _restoreSession(CookieRequest request) async {
    await request.init();
    if (!request.loggedIn) return false;

    try {
      final response = await request.get(ApiConfig.meUrl);
      if (response is Map && response['is_authenticated'] == true) {
        request.jsonData = Map<String, dynamic>.from(response);
        return true;
      }
      // Server menjawab, tapi sesi sudah tidak berlaku.
      await AuthService.clearLocalSession(request);
    } catch (_) {
      // Server tidak bisa dihubungi / URL salah: arahkan ke login saja.
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _sessionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _SplashView();
        }
        return snapshot.data == true ? const HomePage() : const LoginPage();
      },
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restaurant, size: 64, color: colorScheme.primary),
            const SizedBox(height: 16),
            Text('LastBite', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
