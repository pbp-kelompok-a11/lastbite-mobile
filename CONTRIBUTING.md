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
│   ├── models/               # model akun dan peran pengguna
│   ├── screens/              # auth_gate, login_page, register_page
│   ├── services/             # auth_service dan integrasi autentikasi
│   └── widgets/              # komponen khusus autentikasi
├── home/
│   ├── screens/home_page.dart
│   └── widgets/module_card.dart
├── modules/
│   ├── app_module.dart        # model metadata modul
│   ├── module_registry.dart   # DAFTAR MODUL (drawer & menu dibangun dari sini)
│   ├── surprise_bag/
│   ├── order/
│   ├── merchant_store/
│   ├── community/
│   └── eco_impact/
└── widgets/                   # komponen lintas fitur: app_drawer, module_section

test/
├── helpers/test_app.dart      # pembungkus aplikasi untuk tes widget
├── auth/login_page_test.dart
└── modules/
    ├── module_navigation_test.dart
    ├── surprise_bag/
    ├── order/
    ├── merchant_store/
    ├── community/
    └── eco_impact/
```

Setiap folder modul memakai struktur tetap berikut sampai pengumpulan akhir:

```text
lib/modules/<nama_modul>/
├── models/     # objek Dart, fromJson/toJson, dan perhitungan data modul
├── services/   # request API modul menggunakan CookieRequest dan ApiConfig
├── screens/    # halaman utama, daftar, detail, dan formulir
└── widgets/    # komponen tampilan yang hanya dipakai modul ini
```

Folder kosong menyimpan `.gitkeep` agar kerangkanya ikut terbawa saat di-clone.
Hapus `.gitkeep` ketika folder tersebut sudah memiliki kode. Gunakan nama file
`snake_case`, misalnya `food_hack.dart`, `community_service.dart`, dan
`food_hack_detail_page.dart`. Simpan tes fitur di `test/modules/<nama_modul>/`
dengan akhiran `_test.dart`.

`core/` hanya berisi konfigurasi dan utilitas aplikasi bersama. `widgets/` pada
akar `lib/` hanya untuk komponen yang digunakan beberapa fitur. Widget khusus
modul tetap di modul pemiliknya. Modul lain tidak mengimpor halaman atau widget
internal modul ini; gunakan navigasi yang terdaftar di registry. Akses data lintas
modul tetap melalui API Django. Tidak perlu membuat service, model, atau lapisan
tambahan yang belum memiliki fungsi.

## 3. Mengerjakan modul

1. Kerjakan di folder modul yang sudah disiapkan sesuai pembagian README.
2. Halaman utama kelima modul sudah terdaftar di `lib/modules/module_registry.dart`.
   Saat mengganti halaman utama, perbarui import dan `pageBuilder` tanpa mengubah ID modul:
   ```dart
   AppModule(
     id: 'merchant_store',
     title: 'Merchant Store',
     description: 'Cari toko terdekat',
     icon: Icons.storefront_outlined,
     pic: 'Nama Kamu',
     pageBuilder: (_) => const MerchantListPage(),
   ),
   ```
   Drawer dan menu Beranda otomatis ikut berubah.
3. Pakai `AppDrawer(currentId: '<id modul>')` di `Scaffold` halaman utama modul.
4. Tempatkan pemanggilan API di `services/` modul, menggunakan `CookieRequest`
   yang diterima dari halaman agar semua request membawa sesi login yang sama:
   ```dart
   // Contoh di MerchantStoreService; request diterima melalui constructor.
   final data = await request.get(ApiConfig.url('/api/merchant-stores/'));
   ```
   Konversikan JSON menjadi objek di `models/`. Halaman di `screens/` mengelola
   input, navigasi, dan status loading/error, lalu menampilkan objek model melalui
   widget. Jangan menulis URL lengkap (`http://...`) di halaman; selalu pakai
   `ApiConfig.url(...)` di service. Setiap modul wajib menyediakan `pageBuilder`;
   fallback placeholder sudah dihapus.

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
