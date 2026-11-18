import 'package:flutter/material.dart';

import 'app_module.dart';

/// Daftar modul aplikasi. Drawer dan menu di Beranda dibangun dari list ini,
/// jadi menambah, menghapus, atau mengganti modul cukup di sini.
///
/// Cara menyambungkan halaman asli modul:
/// 1. Taruh kode modul di folder sendiri, misal `lib/modules/merchant_store/`.
/// 2. Isi `pageBuilder` dengan halaman utama modul, contoh:
///      pageBuilder: (_) => const MerchantStorePage(),
///    Selama `pageBuilder` kosong, yang tampil adalah halaman placeholder.
final List<AppModule> appModules = [
  const AppModule(
    id: 'surprise_bag',
    title: 'Surprise Bag',
    description: 'Katalog paket makanan surplus',
    icon: Icons.shopping_bag_outlined,
    pic: 'Gde Maharta Putra Wicaksana Ridjasa',
  ),
  const AppModule(
    id: 'order',
    title: 'Order',
    description: 'Pemesanan & status pickup',
    icon: Icons.receipt_long_outlined,
    pic: 'Salwa Alyani Naznin',
  ),
  const AppModule(
    id: 'merchant_store',
    title: 'Merchant Store',
    description: 'Direktori toko & wishlist',
    icon: Icons.storefront_outlined,
    pic: 'Fathir Atha Rizki Tasril',
  ),
  const AppModule(
    id: 'community',
    title: 'Community',
    description: 'Review & food hack',
    icon: Icons.forum_outlined,
    pic: 'Azzam Zawawi Al Rasyid',
  ),
  const AppModule(
    id: 'eco_impact',
    title: 'Eco Impact',
    description: 'Impact journal & green wallet',
    icon: Icons.eco_outlined,
    pic: 'Khayla Syafira Ardiasih',
  ),
];