import 'package:flutter/material.dart';

import '../../../widgets/app_drawer.dart';
import '../../../widgets/module_section.dart';

class SurpriseBagPage extends StatelessWidget {
  const SurpriseBagPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Surprise Bag')),
      drawer: const AppDrawer(currentId: 'surprise_bag'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('Temukan paket makanan surplus dari toko di sekitarmu.',
                style: textTheme.titleLarge),
            const SizedBox(height: 12),
            const Text(
              'Halaman awal modul. Data dan fitur interaktif masih dalam pengembangan.',
            ),
            const SizedBox(height: 12),
            const ModuleSection(
              title: 'Katalog paket',
              description:
                  'Pilihan Surprise Bag akan ditampilkan di sini setelah katalog terhubung ke server.',
              icon: Icons.shopping_bag_outlined,
            ),
            const Divider(),
            const ModuleSection(
              title: 'Kategori makanan',
              description:
                  'Jelajahi paket roti, makanan utama, dan pilihan makanan lainnya.',
              icon: Icons.category_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
