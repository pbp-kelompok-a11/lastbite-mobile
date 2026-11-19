import 'package:flutter/material.dart';

import '../../../widgets/app_drawer.dart';
import '../../../widgets/module_section.dart';

class EcoImpactPage extends StatelessWidget {
  const EcoImpactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Eco Impact')),
      drawer: const AppDrawer(currentId: 'eco_impact'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('Lihat dampak penyelamatan makanan dan penghematanmu.',
                style: textTheme.titleLarge),
            const SizedBox(height: 12),
            const Text(
              'Halaman awal modul. Data dan fitur interaktif masih dalam pengembangan.',
            ),
            const SizedBox(height: 12),
            const ModuleSection(
              title: 'Impact Journal',
              description:
                  'Catatan makanan terselamatkan dan pengurangan emisi akan ditampilkan setelah jurnal terhubung ke server.',
              icon: Icons.eco_outlined,
            ),
            const Divider(),
            const ModuleSection(
              title: 'Green Wallet',
              description:
                  'Ringkasan penghematan dari pesananmu akan ditampilkan di sini.',
              icon: Icons.savings_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
