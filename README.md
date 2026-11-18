# LastBite Mobile App

## 1. Nama dan NPM Anggota Kelompok
Kelompok A11:
- Salwa Alyani Naznin (2506622802)
- Khayla Syafira Ardiasih (2506656910)
- Fathir Atha Rizki Tasril (2506656734)
- Azzam Zawawi Al Rasyid (2506618723)
- Gde Maharta Putra Wicaksana Ridjasa (2506549051)

## 2. Deskripsi Aplikasi
LastBite Mobile adalah aplikasi marketplace penyelamatan makanan (food rescue) yang menghubungkan merchant makanan seperti bakery, kafe, dan restoran dengan pembeli di sekitar kampus dan area kos. Aplikasi ini dirancang khusus untuk menjual stok makanan surplus yang mendekati jam tutup toko. 

Merchant dapat menjual kelebihan makanan layak konsumsi tersebut dengan harga diskon 30–50% dalam bentuk Surprise Bag. Di sisi lain, pembeli dapat menikmati makanan berkualitas dengan harga hemat. Melalui alur ini, LastBite membantu mengurangi limbah makanan (food waste) sekaligus menekan jejak emisi karbon di lingkungan.

## 3. Daftar Modul dan Pembagian Kerja
- Modul Surprise Bag (Gde Maharta Putra Wicaksana Ridjasa):
  Mengelola inventaris paket makanan surplus harian. Merchant dapat membuat penawaran Surprise Bag, memperbarui stok, dan mengatur jam pickup. Pengguna dapat melihat katalog makanan yang tersedia, melakukan pencarian, dan memfilter berdasarkan kategori.

- Modul Order (Salwa Alyani Naznin):
  Mengelola alur pemesanan Surprise Bag dari awal reservasi hingga selesai. Merchant dapat memperbarui status pesanan (Pending, Ready to Pickup, Completed) dan memverifikasi pengambilan makanan dengan kode pickup unik. Customer dapat memantau riwayat pesanan aktif dan membatalkan pesanan yang belum diproses.

- Modul Merchant Store (Fathir Atha Rizki Tasril):
  Mengelola profil toko mitra, mencakup informasi gerai, jam operasional, kontak, dan alamat. Modul ini juga menampilkan direktori lokasi toko terdekat menggunakan geocoding peta, serta menyediakan fitur daftar toko favorit (wishlist) bagi customer.

- Modul Community (Azzam Zawawi Al Rasyid):
  Menampung konten komunitas pengguna, yang terdiri dari ulasan toko setelah menyelesaikan pesanan (verified review) dan artikel tips penanganan makanan surplus (food hack), dilengkapi dengan fitur apresiasi upvote.

- Modul Eco Impact: Impact Journal & Green Wallet (Khayla Syafira Ardiasih):
  Mencatat dan menampilkan dampak lingkungan serta penghematan finansial customer. Menghitung akumulasi kilogram makanan terselamatkan, reduksi emisi CO2, ekuivalensi kilometer mobil, total rupiah yang dihemat (Green Wallet), grafik riwayat log dampak (dari pesanan otomatis maupun pencatatan manual), filter periode waktu mingguan/bulanan, dan sistem tingkatan gamifikasi pengguna.

## 4. Peran Pengguna (User Roles)
- Guest: Pengunjung umum yang belum masuk ke akun. Memiliki akses membaca (read-only) untuk melihat katalog Surprise Bag, peta lokasi toko, dan tips komunitas tanpa bisa bertransaksi.
- Customer: Konsumen terdaftar yang dapat memesan Surprise Bag, mengambil makanan di toko dengan kode pickup, mencatat log dampak lingkungan di Eco Impact, serta membuat ulasan dan tips di modul komunitas.
- Merchant: Pemilik usaha makanan terdaftar yang dapat mengelola profil toko, menginput stok Surprise Bag harian, dan memvalidasi kode pickup pesanan pembeli.

## 5. Alur Integrasi Mobile dan Situs Web (PWS) melalui Web Service Django REST Framework
Aplikasi mobile Flutter terhubung dengan situs web backend Django pada PWS melalui web service Django REST Framework (DRF) dengan format pertukaran data JSON:

- Autentikasi Pengguna: Flutter mengirimkan request HTTP POST berisi kredensial pengguna ke endpoint autentikasi Django. Backend memverifikasi data dan mengembalikan sesi login. Flutter menyimpan cookie sesi (sessionid dan csrftoken) menggunakan library pbp_django_auth agar sesi pengguna tetap aktif untuk request API berikutnya.
- Pengambilan Data (GET): Ketika aplikasi membuka halaman (seperti katalog makanan, riwayat pesanan, atau dasbor dampak lingkungan), Flutter mengirim HTTP GET ke endpoint Django REST Framework. Backend memvalidasi hak akses, mengambil data dari database, lalu mengubah data model tersebut menjadi format JSON menggunakan Django REST Framework serializers. Objek JSON tersebut kemudian dikonversi menjadi objek Dart di Flutter menggunakan fungsi fromJson untuk ditampilkan pada antarmuka aplikasi.
- Pengiriman Data (POST): Saat pengguna melakukan aksi penambahan data (seperti membuat pesanan baru atau mencatat log dampak manual), Flutter mengirimkan HTTP POST berisi payload JSON ke API endpoint Django. Web service Django REST Framework memproses validasi input data, menyimpannya ke database, lalu mengembalikan respons status keberhasilan (HTTP 200/201) agar tampilan Flutter dapat langsung diperbarui secara asinkron.

## 6. Tautan Desain Figma
https://www.figma.com/design/zDAuPEQmxaq2GS0vTwFvXr/LastBite?node-id=0-1&t=iZNwDjawzaXseNsp-1

## 7. Tautan APK
(Akan ditambahkan setelah rilis Checkpoint 1)