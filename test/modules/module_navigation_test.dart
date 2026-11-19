import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lastbite_mobile/core/app_navigator.dart';
import 'package:lastbite_mobile/home/screens/home_page.dart';
import 'package:lastbite_mobile/modules/module_registry.dart';
import 'package:lastbite_mobile/modules/community/screens/community_page.dart';
import 'package:lastbite_mobile/modules/eco_impact/screens/eco_impact_page.dart';
import 'package:lastbite_mobile/modules/merchant_store/screens/merchant_store_page.dart';
import 'package:lastbite_mobile/modules/order/screens/order_page.dart';
import 'package:lastbite_mobile/modules/surprise_bag/screens/surprise_bag_page.dart';
import 'package:lastbite_mobile/widgets/app_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../helpers/test_app.dart';

void main() {
  testWidgets('Beranda menampilkan semua modul dan bisa membuka modul',
      (tester) async {
    await tester.pumpWidget(wrapTestApp(const HomePage()));

    for (final module in appModules) {
      expect(find.text(module.title), findsWidgets);
    }

    await tester.tap(find.text(appModules.first.title).first);
    await tester.pumpAndSettle();

    expect(find.byType(SurpriseBagPage), findsOneWidget);
    expect(find.text('Katalog paket'), findsOneWidget);
  });

  testWidgets('Drawer membuka kelima halaman dan kembali ke Beranda',
      (tester) async {
    await tester.pumpWidget(wrapTestApp(const HomePage()));
    const pageTypes = [
      SurpriseBagPage,
      OrderPage,
      MerchantStorePage,
      CommunityPage,
      EcoImpactPage,
    ];

    for (var i = 0; i < appModules.length; i++) {
      final scaffold = tester.state<ScaffoldState>(find.byType(Scaffold).last);
      scaffold.openDrawer();
      await tester.pumpAndSettle();
      final menu = find.descendant(
        of: find.byType(AppDrawer),
        matching: find.widgetWithText(ListTile, appModules[i].title),
      );
      await tester.ensureVisible(menu);
      await tester.tap(menu);
      await tester.pumpAndSettle();

      expect(find.byType(pageTypes[i]), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(tester.takeException(), isNull);
    }

    tester.state<ScaffoldState>(find.byType(Scaffold).last).openDrawer();
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Beranda'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(EcoImpactPage), findsNothing);
  });

  for (final module in appModules) {
    testWidgets('${module.title} mendukung layar kecil dan tombol Back',
        (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(Provider<CookieRequest>(
        create: (_) => CookieRequest(),
        child: MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(2),
            ),
            child: child!,
          ),
          home: const HomePage(),
        ),
      ));
      // Buka melalui navigasi asli tanpa bergantung posisi kartu di layar kecil.
      final context = tester.element(find.byType(HomePage));
      AppNavigator.openModule(Navigator.of(context), module);
      await tester.pumpAndSettle();
      await tester.drag(find.byType(ListView).last, const Offset(0, -400));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  }
}
