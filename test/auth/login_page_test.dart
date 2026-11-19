import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lastbite_mobile/auth/screens/login_page.dart';

import '../helpers/test_app.dart';

void main() {
  testWidgets('Halaman login menampilkan form', (tester) async {
    await tester.pumpWidget(wrapTestApp(const LoginPage()));

    expect(find.text('Masuk'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('Login dengan field kosong menampilkan validasi', (tester) async {
    await tester.pumpWidget(wrapTestApp(const LoginPage()));

    await tester.tap(find.text('Masuk'));
    await tester.pump();

    expect(find.text('Username wajib diisi'), findsOneWidget);
    expect(find.text('Password wajib diisi'), findsOneWidget);
  });
}
