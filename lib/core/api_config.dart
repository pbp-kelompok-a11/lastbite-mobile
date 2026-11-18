import 'package:flutter/foundation.dart';

/// Semua alamat server Django ada di sini, jadi tidak ada URL yang
/// ditulis manual di halaman-halaman lain.
///
/// Aturan pemilihan base URL:
/// 1. `--dart-define=BASE_URL=...`  → dipakai apa adanya (misal HP fisik:
///    `flutter run --dart-define=BASE_URL=http://192.168.1.5:8000`).
/// 2. Build release (APK) atau `--dart-define=USE_PROD=true` → [productionUrl].
/// 3. Debug di Chrome → http://localhost:8000
/// 4. Debug di emulator Android → http://10.0.2.2:8000
class ApiConfig {
  ApiConfig._();
  
  static const String productionUrl =
    'https://fathir-atha-lastbite-pbp-kelompok-a11.pws.cs.ui.ac.id';

  static const String _overrideUrl = String.fromEnvironment('BASE_URL');
  static const bool _useProd = bool.fromEnvironment('USE_PROD');

  static String get baseUrl {
    if (_overrideUrl.isNotEmpty) return _withoutTrailingSlash(_overrideUrl);
    if (kReleaseMode || _useProd) return productionUrl;
    if (kIsWeb) return 'http://localhost:8000';
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8000';
    }
    return 'http://127.0.0.1:8000';
  }

  /// Gabungkan base URL dengan path endpoint, misal `ApiConfig.url('/api/merchant/')`.
  /// Ingat: endpoint Django selalu diakhiri `/`.
  static String url(String path) {
    final normalized = path.startsWith('/') ? path : '/$path';
    return '$baseUrl$normalized';
  }

  // ---- Endpoint autentikasi (app `api` di proyek Django) ----
  static String get loginUrl => url('/api/auth/login/');
  static String get registerUrl => url('/api/auth/register/');
  static String get logoutUrl => url('/api/auth/logout/');
  static String get meUrl => url('/api/auth/me/');

  static String _withoutTrailingSlash(String value) =>
      value.endsWith('/') ? value.substring(0, value.length - 1) : value;
}
