# Planner Tugas Kuliah

Aplikasi Flutter untuk mencatat tugas kuliah. Dibuat untuk Tugas Rutin 7
Pemrograman Mobile (State Management).

## Fitur
- Daftar tugas dengan filter Semua / Aktif / Selesai
- Tambah tugas lewat form (judul, mata kuliah, tenggat)
- Tandai selesai dan hapus tugas
- Halaman statistik: total, selesai, persentase
- Badge jumlah tugas aktif di ikon statistik

## Cara menjalankan
```
flutter pub get
flutter run
flutter test
```

## Diagram letak state

```
ChangeNotifierProvider<TugasProvider>   <-- STATE BERSAMA (List<TugasKuliah>)
        |
   MaterialApp.router (go_router)
        |
   +----+----------------+-----------------+
   |                     |                 |
DaftarPage           TambahPage       StatistikPage
(filter = state      (TextEditing-    (watch Provider)
 LOKAL setState;      Controller =
 select utk badge)    state LOKAL)
```

## Alasan pemilihan
| State | Letak | Alasan |
|---|---|---|
| Filter (Semua/Aktif/Selesai) | setState di DaftarPage | Ephemeral: hanya dipakai satu halaman |
| TextEditingController | State TambahPage (initState/dispose) | Ephemeral: hanya hidup selama form tampil |
| Daftar tugas | Provider (ChangeNotifier) | App state: dipakai 3 halaman dan badge |

Saya memilih **Provider** karena aplikasinya kecil-sedang, boilerplate sedikit,
dan logikanya (TugasProvider) tidak bergantung pada UI sehingga mudah diuji.
Badge memakai `context.select` agar hanya dibangun ulang ketika jumlah tugas
aktif berubah.

## Pengujian
4 unit test pada `test/tugas_provider_test.dart`: tambah, tandaiSelesai,
hapus, dan perhitungan persen.