import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lastbite_mobile/auth/screens/login_page.dart';
import 'package:lastbite_mobile/home/home_page.dart';
import 'package:lastbite_mobile/modules/module_registry.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

Widget _wrap(Widget child) {
  return Provider<CookieRequest>(
    create: (_) => CookieRequest(),
    child: MaterialApp(home: child),
  );
}

void main() {
  testWidgets('Halaman login menampilkan form', (tester) async {
    await tester.pumpWidget(_wrap(const LoginPage()));

    expect(find.text('Masuk'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('Login dengan field kosong menampilkan validasi', (tester) async {
    await tester.pumpWidget(_wrap(const LoginPage()));

    await tester.tap(find.text('Masuk'));
    await tester.pump();

    expect(find.text('Username wajib diisi'), findsOneWidget);
    expect(find.text('Password wajib diisi'), findsOneWidget);
  });

  testWidgets('Beranda menampilkan semua modul dan bisa membuka modul',
      (tester) async {
    await tester.pumpWidget(_wrap(const HomePage()));

    for (final module in appModules) {
      expect(find.text(module.title), findsWidgets);
    }

    await tester.tap(find.text(appModules.first.title).first);
    await tester.pumpAndSettle();

    expect(find.text('Halaman modul ini sedang dikerjakan.'), findsOneWidget);
  });
}
