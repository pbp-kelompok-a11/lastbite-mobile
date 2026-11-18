import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import 'app_module.dart';

/// Halaman sementara untuk modul yang belum dikerjakan.
/// Akan diganti otomatis begitu `pageBuilder` modul diisi di registry.
class ModulePlaceholderPage extends StatelessWidget {
  const ModulePlaceholderPage({super.key, required this.module});

  final AppModule module;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(module.title)),
      drawer: AppDrawer(currentId: module.id),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(
                  module.icon,
                  size: 40,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                module.title,
                style: textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              if (module.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  module.description,
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 16),
              Text(
                'Halaman modul ini sedang dikerjakan.',
                style: textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              if (module.pic.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  'PIC: ${module.pic}',
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
