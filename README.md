# CatatanKu

Aplikasi catatan harian sederhana berbasis Flutter. Proyek ini berisi UI
frontend dengan data contoh lokal dan tidak menggunakan backend maupun
autentikasi.

## Menjalankan aplikasi

Pastikan Flutter SDK sudah tersedia, lalu jalankan:

```sh
flutter pub get
flutter run
```

## Fitur

- Splash screen dan login statis.
- Beranda dengan pencarian dan filter kategori.
- Membuat catatan dengan kategori, warna, dan prioritas.
- Melihat detail dan menghapus catatan dengan konfirmasi.
- Data catatan tersimpan di memori selama aplikasi berjalan.
- Tangkapan layar emulator tersedia di folder `screenshots/`.

## Memeriksa kualitas

```sh
flutter analyze
flutter test
```
