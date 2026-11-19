import 'package:flutter/material.dart';

import 'app_module.dart';
import 'community/screens/community_page.dart';
import 'eco_impact/screens/eco_impact_page.dart';
import 'merchant_store/screens/merchant_store_page.dart';
import 'order/screens/order_page.dart';
import 'surprise_bag/screens/surprise_bag_page.dart';

/// Daftar modul aplikasi. Drawer dan menu di Beranda dibangun dari list ini,
/// jadi menambah, menghapus, atau mengganti modul cukup di sini.
///
/// Cara menyambungkan halaman asli modul:
/// 1. Taruh halaman modul di `lib/modules/<nama_modul>/screens/`.
/// 2. Isi `pageBuilder` dengan halaman utama modul, contoh:
///      pageBuilder: (_) => const MerchantStorePage(),
///    Setiap modul wajib menyediakan `pageBuilder`.
final List<AppModule> appModules = [
  AppModule(
    id: 'surprise_bag',
    title: 'Surprise Bag',
    description: 'Katalog paket makanan surplus',
    icon: Icons.shopping_bag_outlined,
    pic: 'Gde Maharta Putra Wicaksana Ridjasa',
    pageBuilder: (_) => const SurpriseBagPage(),
  ),
  AppModule(
    id: 'order',
    title: 'Order',
    description: 'Pemesanan & status pickup',
    icon: Icons.receipt_long_outlined,
    pic: 'Salwa Alyani Naznin',
    pageBuilder: (_) => const OrderPage(),
  ),
  AppModule(
    id: 'merchant_store',
    title: 'Merchant Store',
    description: 'Direktori toko & wishlist',
    icon: Icons.storefront_outlined,
    pic: 'Fathir Atha Rizki Tasril',
    pageBuilder: (_) => const MerchantStorePage(),
  ),
  AppModule(
    id: 'community',
    title: 'Community',
    description: 'Review & food hack',
    icon: Icons.forum_outlined,
    pic: 'Azzam Zawawi Al Rasyid',
    pageBuilder: (_) => const CommunityPage(),
  ),
  AppModule(
    id: 'eco_impact',
    title: 'Eco Impact',
    description: 'Impact journal & green wallet',
    icon: Icons.eco_outlined,
    pic: 'Khayla Syafira Ardiasih',
    pageBuilder: (_) => const EcoImpactPage(),
  ),
];
