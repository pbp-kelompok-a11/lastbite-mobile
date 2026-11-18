import 'package:flutter/material.dart';

import '../core/app_navigator.dart';
import '../modules/app_module.dart';

/// Kartu menu modul di Beranda.
class ModuleCard extends StatelessWidget {
  const ModuleCard({super.key, required this.module});

  final AppModule module;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => AppNavigator.openModule(Navigator.of(context), module),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(module.icon, color: colorScheme.onPrimaryContainer),
              ),
              const Spacer(),
              Text(
                module.title,
                style: textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (module.description.isNotEmpty)
                Text(
                  module.description,
                  style: textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
