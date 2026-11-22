import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lastbite_mobile/auth/screens/auth_gate.dart';
import 'package:lastbite_mobile/auth/screens/login_page.dart';
import 'package:lastbite_mobile/auth/screens/register_page.dart';
import 'package:lastbite_mobile/home/screens/home_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class _SessionRequest extends CookieRequest {
  _SessionRequest(
      {bool authenticated = false, this.response, this.offline = false}) {
    loggedIn = authenticated;
  }

  final dynamic response;
  final bool offline;

  @override
  Future<void> init() async {
    initialized = true;
  }

  @override
  Future<dynamic> get(String url) async {
    if (offline) throw Exception('Server offline');
    return response;
  }

  @override
  Future<void> persist(String cookies) async {}

  @override
  Future<dynamic> logout(String url) async => {'message': 'Logout berhasil!'};
}

Widget _app(CookieRequest request) => Provider<CookieRequest>.value(
      value: request,
      child: const MaterialApp(home: AuthGate()),
    );

void main() {
  testWidgets('Guest mulai di Beranda dan dapat membuka login serta registrasi',
      (tester) async {
    await tester.pumpWidget(_app(_SessionRequest()));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Halo, Guest!'), findsOneWidget);
    expect(find.byType(LoginPage), findsNothing);

    await tester.tap(find.widgetWithText(TextButton, 'Masuk'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
    await tester.tap(find.text('Belum punya akun? Daftar'));
    await tester.pumpAndSettle();
    expect(find.byType(RegisterPage), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Sesi valid dipulihkan dan logout kembali ke Beranda Guest',
      (tester) async {
    final request = _SessionRequest(
      authenticated: true,
      response: {'is_authenticated': true, 'username': 'customer'},
    );
    await tester.pumpWidget(_app(request));
    await tester.pumpAndSettle();
    expect(find.text('Halo, customer!'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Masuk'), findsNothing);

    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Logout'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Halo, Guest!'), findsOneWidget);
    expect(request.loggedIn, isFalse);
  });

  testWidgets('Sesi kedaluwarsa tetap membuka Beranda sebagai Guest',
      (tester) async {
    final request = _SessionRequest(
      authenticated: true,
      response: {'is_authenticated': false},
    );
    await tester.pumpWidget(_app(request));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Halo, Guest!'), findsOneWidget);
    expect(request.loggedIn, isFalse);
  });

  testWidgets('Server offline tidak menghalangi Beranda Guest', (tester) async {
    final request = _SessionRequest(authenticated: true, offline: true);
    await tester.pumpWidget(_app(request));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Halo, Guest!'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Guest dapat membuka login melalui drawer', (tester) async {
    await tester.pumpWidget(_app(_SessionRequest()));
    await tester.pumpAndSettle();
    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ListTile, 'Logout'), findsNothing);
    await tester.tap(find.widgetWithText(ListTile, 'Masuk'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
