import 'package:flutter/material.dart';

/// Metadata satu modul aplikasi. Drawer dan menu Beranda dibangun dari
/// daftar [AppModule] di `module_registry.dart`.
class AppModule {
  const AppModule({
    required this.id,
    required this.title,
    required this.icon,
    this.description = '',
    this.pic = '',
    this.pageBuilder,
  });

  /// ID unik, dipakai untuk menandai menu aktif di drawer.
  final String id;

  /// Nama modul yang tampil di drawer dan kartu menu.
  final String title;

  /// Deskripsi singkat untuk kartu menu.
  final String description;

  final IconData icon;

  /// Penanggung jawab modul (nama anggota).
  final String pic;

  /// Halaman utama modul. Selama masih `null`, yang tampil adalah
  /// halaman placeholder.
  final WidgetBuilder? pageBuilder;
}
