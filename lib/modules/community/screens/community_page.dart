import 'package:flutter/material.dart';

import '../../../widgets/app_drawer.dart';
import '../../../widgets/module_section.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Community')),
      drawer: const AppDrawer(currentId: 'community'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('Berbagi pengalaman dan cara mengolah makanan surplus.',
                style: textTheme.titleLarge),
            const SizedBox(height: 12),
            const Text(
              'Halaman awal modul. Data dan fitur interaktif masih dalam pengembangan.',
            ),
            const SizedBox(height: 12),
            const ModuleSection(
              title: 'Food hack',
              description:
                  'Tips menyimpan dan mengolah makanan dari komunitas akan ditampilkan di sini.',
              icon: Icons.lightbulb_outline,
            ),
            const Divider(),
            const ModuleSection(
              title: 'Ulasan terverifikasi',
              description:
                  'Ulasan dari pembeli yang sudah menyelesaikan pesanannya akan ditampilkan di sini.',
              icon: Icons.rate_review_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
