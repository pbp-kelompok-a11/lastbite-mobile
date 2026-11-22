import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../auth/services/auth_service.dart';
import '../core/app_navigator.dart';
import '../modules/app_module.dart';
import '../modules/module_registry.dart';

/// Drawer yang dipakai di Beranda dan semua halaman modul.
/// Isi menu modul diambil dari [appModules].
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.currentId});

  /// ID halaman yang sedang dibuka ([AppNavigator.homeId] atau id modul).
  final String currentId;

  void _openHome(BuildContext context) {
    final navigator = Navigator.of(context);
    navigator.pop(); // tutup drawer
    if (currentId != AppNavigator.homeId) AppNavigator.goHome(navigator);
  }

  void _openModule(BuildContext context, AppModule module) {
    final navigator = Navigator.of(context);
    navigator.pop(); // tutup drawer
    if (currentId != module.id) AppNavigator.openModule(navigator, module);
  }

  void _logout(BuildContext context) {
    Navigator.of(context).pop(); // tutup drawer
    AuthService.logout(context);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              color: colorScheme.primaryContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.restaurant,
                    size: 40,
                    color: colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'LastBite',
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Halo, ${AuthService.username(request)}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  ListTile(
                    leading: const Icon(Icons.home_outlined),
                    title: const Text('Beranda'),
                    selected: currentId == AppNavigator.homeId,
                    onTap: () => _openHome(context),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: Text('Modul'),
                  ),
                  for (final module in appModules)
                    ListTile(
                      leading: Icon(module.icon),
                      title: Text(module.title),
                      selected: currentId == module.id,
                      onTap: () => _openModule(context, module),
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: Icon(request.loggedIn ? Icons.logout : Icons.login),
              title: Text(request.loggedIn ? 'Logout' : 'Masuk'),
              onTap: () {
                if (request.loggedIn) {
                  _logout(context);
                } else {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  AuthService.openLogin(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
