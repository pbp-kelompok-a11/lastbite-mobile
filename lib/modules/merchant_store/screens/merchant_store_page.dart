import 'package:flutter/material.dart';

import '../../../widgets/app_drawer.dart';
import '../../../widgets/module_section.dart';

class MerchantStorePage extends StatelessWidget {
  const MerchantStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Merchant Store')),
      drawer: const AppDrawer(currentId: 'merchant_store'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('Kenali toko mitra dan rencanakan kunjunganmu.',
                style: textTheme.titleLarge),
            const SizedBox(height: 12),
            const Text(
              'Halaman awal modul. Data dan fitur interaktif masih dalam pengembangan.',
            ),
            const SizedBox(height: 12),
            const ModuleSection(
              title: 'Direktori toko',
              description:
                  'Nama, alamat, kontak, dan jam operasional toko akan tersedia setelah direktori terhubung ke server.',
              icon: Icons.storefront_outlined,
            ),
            const Divider(),
            const ModuleSection(
              title: 'Toko favorit',
              description:
                  'Daftar toko yang kamu simpan akan ditampilkan di sini.',
              icon: Icons.favorite_border,
            ),
          ],
        ),
      ),
    );
  }
}
