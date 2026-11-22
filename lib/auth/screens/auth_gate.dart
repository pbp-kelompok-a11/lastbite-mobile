import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../core/api_config.dart';
import '../../home/screens/home_page.dart';
import '../services/auth_service.dart';

/// Halaman pertama saat app dibuka.
/// Pulihkan sesi jika ada, lalu buka Beranda untuk pengguna maupun Guest.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final Future<void> _sessionFuture;

  @override
  void initState() {
    super.initState();
    _sessionFuture = _restoreSession(context.read<CookieRequest>());
  }

  Future<void> _restoreSession(CookieRequest request) async {
    try {
      await request.init();
      if (!request.loggedIn) return;

      final response = await request
          .get(ApiConfig.meUrl)
          .timeout(const Duration(seconds: 5));
      if (response is Map && response['is_authenticated'] == true) {
        request.jsonData = Map<String, dynamic>.from(response);
        return;
      }
      // Server menjawab, tapi sesi sudah tidak berlaku.
      await AuthService.clearLocalSession(request);
    } catch (_) {
      // Tetap buka Beranda sebagai Guest jika pemeriksaan sesi gagal.
      // Cookie tersimpan dipertahankan agar dapat dicoba pada pembukaan berikutnya.
      request.loggedIn = false;
      request.jsonData = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _sessionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _SplashView();
        }
        return const HomePage();
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
