# Panduan Kontribusi — LastBite Mobile

Panduan teknis untuk anggota kelompok: cara menjalankan app, struktur kode,
cara menambah modul, dan alur Git.

## 1. Menjalankan aplikasi

```bash
flutter pub get
flutter run
```

Alamat server dipilih otomatis oleh `lib/core/api_config.dart`:

| Menjalankan di | Server yang dipakai |
| --- | --- |
| Emulator Android (debug) | `http://10.0.2.2:8000` (Django lokal) |
| Chrome (debug) | `http://localhost:8000` (Django lokal) |
| APK release | URL PWS (`ApiConfig.productionUrl`) |
| Debug tapi mau pakai data PWS | `flutter run --dart-define=USE_PROD=true` |
| HP fisik | `flutter run --dart-define=BASE_URL=http://<IP-laptop>:8000` |

Untuk Django lokal, jalankan dulu server di repo web:

```bash
python manage.py runserver            # emulator / Chrome
python manage.py runserver 0.0.0.0:8000   # HP fisik (tambahkan IP laptop ke ALLOWED_HOSTS)
```

Di VS Code, tersedia dua konfigurasi di tab *Run and Debug*:
**LastBite (Django lokal)** dan **LastBite (server PWS)**.

## 2. Struktur folder

```
lib/
├── main.dart                  # Provider<CookieRequest> + MaterialApp
├── core/
│   ├── api_config.dart        # base URL + URL endpoint
│   ├── app_navigator.dart     # helper navigasi (Beranda <-> modul)
│   └── app_theme.dart         # warna & gaya input
├── auth/
│   ├── auth_gate.dart         # cek sesi saat app dibuka
│   ├── auth_service.dart      # logout & bersihkan sesi lokal
│   └── screens/               # login_page, register_page
├── home/home_page.dart        # Beranda (grid menu modul)
├── modules/
│   ├── app_module.dart        # model metadata modul
│   ├── module_registry.dart   # DAFTAR MODUL (drawer & menu dibangun dari sini)
│   └── module_placeholder_page.dart
└── widgets/                   # app_drawer, module_card
```

## 3. Mengerjakan modul

1. Buat folder sendiri: `lib/modules/<nama_modul>/` (misal `screens/`, `models/`, `widgets/`).
2. Daftarkan halaman utamanya di `lib/modules/module_registry.dart`:
   ```dart
   AppModule(
     id: 'merchant',
     title: 'Merchant',
     description: 'Cari toko terdekat',
     icon: Icons.storefront_outlined,
     pic: 'Nama Kamu',
     pageBuilder: (_) => const MerchantListPage(),
   ),
   ```
   Drawer dan menu Beranda otomatis ikut berubah.
3. Pakai `AppDrawer(currentId: '<id modul>')` di `Scaffold` halaman utama modul.
4. Panggil API lewat `CookieRequest` (otomatis membawa cookie sesi login):
   ```dart
   final request = context.watch<CookieRequest>();   // di build()
   final data = await request.get(ApiConfig.url('/api/merchant/'));
   final res = await request.postJson(
     ApiConfig.url('/api/merchant/'),
     jsonEncode({'name': name}),
   );
   ```
   Jangan menulis URL lengkap (`http://...`) di halaman; selalu pakai `ApiConfig.url(...)`.

Endpoint Django untuk modul dibuat di app modul masing-masing (serializer +
view/viewset DRF), lalu didaftarkan di `urls.py` proyek dengan prefix `api/`.

## 4. Alur Git

- `main` — versi stabil, hanya diisi lewat Pull Request dari `develop`.
- `develop` — tempat integrasi semua modul.
- `feat/<nama-modul>` — branch kerja masing-masing anggota.

```bash
git checkout develop
git pull origin develop
git checkout -b feat/merchant
# ... kerja, commit ...
git push -u origin feat/merchant
# buka Pull Request feat/merchant -> develop di GitHub
```

Sebelum membuka PR, pastikan lolos:

```bash
flutter analyze
flutter test
```

GitHub Actions (`.github/workflows/ci.yml`) menjalankan dua perintah itu
otomatis di setiap push dan PR ke `main`/`develop`.
