import 'package:flutter/material.dart';

import '../../../widgets/app_drawer.dart';
import '../../../widgets/module_section.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Order')),
      drawer: const AppDrawer(currentId: 'order'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('Pantau pesanan dan jadwal pengambilan makananmu.',
                style: textTheme.titleLarge),
            const SizedBox(height: 12),
            const Text(
              'Halaman awal modul. Data dan fitur interaktif masih dalam pengembangan.',
            ),
            const SizedBox(height: 12),
            const ModuleSection(
              title: 'Pesanan aktif',
              description:
                  'Pesanan yang menunggu diproses atau siap diambil akan ditampilkan di sini.',
              icon: Icons.receipt_long_outlined,
            ),
            const Divider(),
            const ModuleSection(
              title: 'Riwayat pesanan',
              description:
                  'Pesanan selesai dan dibatalkan akan ditampilkan di sini setelah data terhubung.',
              icon: Icons.history,
            ),
          ],
        ),
      ),
    );
  }
}
