import 'package:flutter_test/flutter_test.dart';
import 'package:planner_tugas/providers/tugas_provider.dart';

void main() {
  late TugasProvider p;

  setUp(() {
    p = TugasProvider();
  });

  test('tambah() menambah satu tugas', () {
    p.tambah(judul: 'Laporan', mataKuliah: 'Mobile', tenggat: DateTime(2026, 12, 1));
    expect(p.total, 1);
    expect(p.jumlahAktif, 1);
  });

  test('tandaiSelesai() mengubah status tugas', () {
    p.tambah(judul: 'Laporan', mataKuliah: 'Mobile', tenggat: DateTime(2026, 12, 1));
    final id = p.daftar.first.id;
    p.tandaiSelesai(id);
    expect(p.daftar.first.selesai, true);
    expect(p.jumlahSelesai, 1);
  });

  test('hapus() membuang tugas dari daftar', () {
    p.tambah(judul: 'Laporan', mataKuliah: 'Mobile', tenggat: DateTime(2026, 12, 1));
    p.hapus(p.daftar.first.id);
    expect(p.total, 0);
  });

  test('persen dihitung benar', () {
    p.tambah(judul: 'A', mataKuliah: 'X', tenggat: DateTime(2026, 12, 1));
    p.tambah(judul: 'B', mataKuliah: 'X', tenggat: DateTime(2026, 12, 2));
    p.tandaiSelesai(p.daftar.first.id);
    expect(p.persen, 50);
  });
}