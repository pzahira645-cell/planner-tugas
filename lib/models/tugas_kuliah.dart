class TugasKuliah {
  final int id;
  final String judul;
  final String mataKuliah;
  final DateTime tenggat;
  final bool selesai;

  const TugasKuliah({
    required this.id,
    required this.judul,
    required this.mataKuliah,
    required this.tenggat,
    this.selesai = false,
  });

  TugasKuliah copyWith({bool? selesai}) {
    return TugasKuliah(
      id: id,
      judul: judul,
      mataKuliah: mataKuliah,
      tenggat: tenggat,
      selesai: selesai ?? this.selesai,
    );
  }
}