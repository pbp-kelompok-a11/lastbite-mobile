import 'package:flutter/material.dart';

import 'app_module.dart';

/// Daftar modul aplikasi. Drawer dan menu di Beranda dibangun dari list ini,
/// jadi menambah, menghapus, atau mengganti modul cukup di sini.
///
/// Setelah scoping modul selesai:
/// 1. Ganti `id`, `title`, `description`, `icon`, dan `pic` sesuai modul.
///    Tambah/hapus entri supaya jumlahnya sama dengan jumlah anggota.
/// 2. Kode modul ditaruh di folder sendiri, misal `lib/modules/merchant/`.
/// 3. Kalau halaman asli sudah ada, isi `pageBuilder`, contoh:
///      pageBuilder: (_) => const MerchantListPage(),
// TODO(kelompok): isi setelah scoping modul disepakati.
final List<AppModule> appModules = [
  const AppModule(
    id: 'modul_1',
    title: 'Modul 1',
    description: 'Belum di-scope',
    icon: Icons.looks_one,
  ),
  const AppModule(
    id: 'modul_2',
    title: 'Modul 2',
    description: 'Belum di-scope',
    icon: Icons.looks_two,
  ),
  const AppModule(
    id: 'modul_3',
    title: 'Modul 3',
    description: 'Belum di-scope',
    icon: Icons.looks_3,
  ),
  const AppModule(
    id: 'modul_4',
    title: 'Modul 4',
    description: 'Belum di-scope',
    icon: Icons.looks_4,
  ),
  const AppModule(
    id: 'modul_5',
    title: 'Modul 5',
    description: 'Belum di-scope',
    icon: Icons.looks_5,
  ),
];
