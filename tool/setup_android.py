"""
Jalankan SEKALI setelah `flutter create .` untuk menyiapkan AndroidManifest:

    python tool/setup_android.py

Yang diubah:
1. android/app/src/main/AndroidManifest.xml
   - menambah izin INTERNET (wajib supaya APK release bisa akses API)
   - mengganti nama aplikasi (android:label) menjadi "LastBite"
2. android/app/src/debug/AndroidManifest.xml
   - mengizinkan HTTP biasa (cleartext) KHUSUS build debug, supaya bisa
     akses Django lokal di http://10.0.2.2:8000 dari emulator.

Script ini aman dijalankan berulang kali.
"""

import re
import sys
from pathlib import Path

APP_LABEL = "LastBite"
ROOT = Path(__file__).resolve().parent.parent
MAIN_MANIFEST = ROOT / "android/app/src/main/AndroidManifest.xml"
DEBUG_MANIFEST = ROOT / "android/app/src/debug/AndroidManifest.xml"
INTERNET = '<uses-permission android:name="android.permission.INTERNET"/>'


def patch_main(text: str) -> str:
    if "android.permission.INTERNET" not in text:
        text = re.sub(
            r"(<manifest[^>]*>)",
            r"\1\n    " + INTERNET,
            text,
            count=1,
        )
    text = re.sub(
        r'android:label="[^"]*"',
        f'android:label="{APP_LABEL}"',
        text,
        count=1,
    )
    return text


def patch_debug(text: str) -> str:
    if "usesCleartextTraffic" in text:
        return text
    return text.replace(
        "</manifest>",
        '    <application android:usesCleartextTraffic="true"/>\n</manifest>',
        1,
    )


def apply(path: Path, patcher) -> None:
    if not path.exists():
        sys.exit(f"Tidak ditemukan: {path}\nJalankan `flutter create .` dulu.")
    original = path.read_text(encoding="utf-8")
    updated = patcher(original)
    if updated != original:
        path.write_text(updated, encoding="utf-8")
        print(f"[diubah]   {path.relative_to(ROOT)}")
    else:
        print(f"[sudah ok] {path.relative_to(ROOT)}")


if __name__ == "__main__":
    apply(MAIN_MANIFEST, patch_main)
    apply(DEBUG_MANIFEST, patch_debug)
